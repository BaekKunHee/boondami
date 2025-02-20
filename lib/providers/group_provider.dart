import 'package:jobmoim/models/member.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/group.dart';
import '../utils/exceptions.dart';

part 'group_provider.g.dart';

class _Constants {
  static const String groupMembersTable = 'group_members';
  static const String groupsTable = 'groups';
  static const String groupInvitationsTable = 'group_invitations';
  static const String taskCategoriesTable = 'task_categories';
  static const String tasksTable = 'tasks';
}

@riverpod
class GroupProvider extends _$GroupProvider {
  SupabaseClient get _supabase => Supabase.instance.client;

  User? get _currentUser => _supabase.auth.currentUser;

  void _checkAuthentication() {
    if (_currentUser == null) {
      throw const AuthenticationException('User not logged in');
    }
  }

  @override
  Future<List<Group>> build() async {
    return _fetchGroups();
  }

  Future<List<Group>> _fetchGroups() async {
    _checkAuthentication();

    try {
      final response = await _supabase
          .from(_Constants.groupMembersTable)
          .select('''
            groups!inner (
              *,
              member_count:group_members(count)
            )
          ''')
          .eq('user_id', _currentUser!.id)
          .order('joined_at', ascending: false);

      if (response.isEmpty) return [];

      return (response as List).map((item) {
        final groupData = item['groups'] as Map<String, dynamic>;
        final memberCount =
            (groupData['member_count'] as List).first['count'] as int;
        return Group.fromJson({
          ...groupData,
          'memberCount': memberCount,
        });
      }).toList();
    } catch (e) {
      throw DatabaseException('Failed to fetch groups: $e');
    }
  }

  Future<void> createGroup({required String name}) async {
    _checkAuthentication();

    try {
      // 1. 그룹 생성
      final groupResponse = await _supabase
          .from(_Constants.groupsTable)
          .insert({
            'name': name,
            'created_at': DateTime.now().toIso8601String(),
          })
          .select()
          .single();

      // 2. 그룹 멤버 추가
      await _supabase.from(_Constants.groupMembersTable).insert({
        'group_id': groupResponse['id'],
        'user_id': _currentUser!.id,
        'role': 'admin',
        'joined_at': DateTime.now().toIso8601String(),
      });

      ref.invalidateSelf();
    } catch (e) {
      throw DatabaseException('Failed to create group: $e');
    }
  }

  Future<void> inviteMember({
    required String groupId,
    required String email,
  }) async {
    _checkAuthentication();

    try {
      final inviteResponse = await _supabase
          .from(_Constants.groupInvitationsTable)
          .insert({
            'group_id': groupId,
            'inviter_id': _currentUser!.id,
            'invitee_email': email,
            'status': 'pending',
            'created_at': DateTime.now().toIso8601String(),
          })
          .select()
          .single();

      await _supabase.functions.invoke(
        'send-invite-email',
        body: {
          'email': email,
          'inviteId': inviteResponse['id'],
          'groupId': groupId,
        },
      );

      ref.invalidateSelf();
    } catch (e) {
      throw DatabaseException('Failed to invite member: $e');
    }
  }

  Future<void> acceptInvite(String inviteId) async {
    _checkAuthentication();

    try {
      final inviteResponse = await _supabase
          .from(_Constants.groupInvitationsTable)
          .select()
          .eq('id', inviteId)
          .single();

      await _supabase.from(_Constants.groupMembersTable).insert({
        'group_id': inviteResponse['group_id'],
        'user_id': _currentUser!.id,
        'role': 'member',
        'joined_at': DateTime.now().toIso8601String(),
      });

      await _supabase.from(_Constants.groupInvitationsTable).update({
        'status': 'accepted',
        'accepted_at': DateTime.now().toIso8601String(),
        'invitee_user_id': _currentUser!.id,
      }).eq('id', inviteId);

      ref.invalidateSelf();
    } catch (e) {
      throw DatabaseException('Failed to accept invite: $e');
    }
  }
}

final groupMembersProvider =
    FutureProvider.family<List<Member>, String>((ref, groupId) async {
  final supabase = Supabase.instance.client;

  try {
    final response =
        await supabase.from(_Constants.groupMembersTable).select('''
          user_id,
          role,
          profiles!inner (
            nickname
          )
        ''').eq('group_id', groupId);

    return (response as List)
        .map((member) => Member(
              id: member['user_id'],
              role: member['role'],
              nickname: member['profiles']['nickname'],
            ))
        .toList();
  } catch (e) {
    throw DatabaseException('Failed to fetch group members: $e');
  }
});

final taskCategoriesProvider =
    FutureProvider.family<List<Map<String, String>>, String>(
        (ref, groupId) async {
  final supabase = Supabase.instance.client;

  try {
    final response = await supabase
        .from(_Constants.taskCategoriesTable)
        .select('id, name')
        .eq('group_id', groupId);

    return response
        .map<Map<String, String>>((item) => {
              'id': item['id'],
              'name': item['name'],
            })
        .toList();
  } catch (e) {
    throw DatabaseException('Failed to fetch task categories: $e');
  }
});

final taskAddProvider =
    FutureProvider.family<String, TaskCreateParams>((ref, params) async {
  final supabase = Supabase.instance.client;
  print(params);

  // Create task first
  final taskResponse = await supabase
      .from('tasks')
      .insert({
        'group_id': params.groupId,
        'category_id': params.categoryId,
        'title': params.title,
        'description': params.description,
        'created_at': DateTime.now().toIso8601String(),
      })
      .select()
      .single();

  final taskId = taskResponse['id'] as String;

  // Create task assignments
  await supabase.from('task_assignments').insert(
        params.memberIds
            .map((userId) => {
                  'task_id': taskId,
                  'user_id': userId,
                  'start_time': params.startTime.toIso8601String(),
                  'end_time': params.endTime.toIso8601String(),
                })
            .toList(),
      );

  return taskId;
});

class TaskCreateParams {
  final String groupId;
  final String categoryId;
  final List<String> memberIds;
  final DateTime startTime;
  final DateTime endTime;
  final String title;
  final String description;

  TaskCreateParams({
    required this.groupId,
    required this.categoryId,
    required this.memberIds,
    required this.startTime,
    required this.endTime,
    required this.title,
    required this.description,
  });
}
