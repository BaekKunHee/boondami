import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/group.dart';

part 'group_provider.g.dart';

@riverpod
class GroupProvider extends _$GroupProvider {
  @override
  Future<List<Group>> build() async {
    return _fetchGroups();
  }

  Future<List<Group>> _fetchGroups() async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    if (user == null) {
      throw Exception('User not logged in');
    }

    try {
      final response = await supabase.from('group_members').select('''
            groups!inner (
              *,
              member_count:group_members(count)
            )
          ''').eq('user_id', user.id).order('joined_at', ascending: false);

      if (response.isEmpty) {
        return [];
      }

      return response.map((item) {
        final groupData = item['groups'] as Map<String, dynamic>;
        final memberCount =
            (groupData['member_count'] as List).first['count'] as int;
        return Group.fromJson({
          ...groupData,
          'memberCount': memberCount,
        });
      }).toList();
    } catch (e) {
      throw Exception('Failed to fetch groups: $e');
    }
  }

  Future<void> createGroup({required String name}) async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    if (user == null) {
      throw Exception('User not logged in');
    }

    try {
      // 1. 그룹 생성
      final groupResponse = await supabase
          .from('groups')
          .insert({
            'name': name,
            'created_at': DateTime.now().toIso8601String(),
          })
          .select()
          .single();

      // 2. 그룹 멤버 추가 (생성자를 admin으로 설정)
      await supabase.from('group_members').insert({
        'group_id': groupResponse['id'],
        'user_id': user.id,
        'role': 'admin',
        'joined_at': DateTime.now().toIso8601String(),
      });

      // 3. 상태 갱신
      ref.invalidateSelf();
    } catch (e) {
      throw Exception('Failed to create group: $e');
    }
  }

  Future<void> inviteMember({
    required String groupId,
    required String email,
  }) async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    if (user == null) {
      throw Exception('User not logged in');
    }

    try {
      // 1. 초대 생성
      final inviteResponse = await supabase
          .from('group_invitations')
          .insert({
            'group_id': groupId,
            'inviter_id': user.id, // 초대한 사람의 ID
            'invitee_email': email,
            'status': 'pending',
            'created_at': DateTime.now().toIso8601String(),
          })
          .select()
          .single();

      // 2. 이메일 전송
      await supabase.functions.invoke(
        'send-invite-email',
        body: {
          'email': email,
          'inviteId': inviteResponse['id'],
          'groupId': groupId,
        },
      );

      // 3. 상태 갱신
      ref.invalidateSelf();
    } catch (e) {
      throw Exception('Failed to invite member: $e');
    }
  }

  // 초대 수락 메서드
  Future<void> acceptInvite(String inviteId) async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    if (user == null) {
      throw Exception('User not logged in');
    }

    try {
      // 1. 초대 정보 가져오기
      final inviteResponse = await supabase
          .from('group_invitations')
          .select()
          .eq('id', inviteId)
          .single();

      // 2. 그룹 멤버로 추가
      await supabase.from('group_members').insert({
        'group_id': inviteResponse['group_id'],
        'user_id': user.id,
        'role': 'member',
        'joined_at': DateTime.now().toIso8601String(),
      });

      // 3. 초대 상태 업데이트
      await supabase.from('group_invitations').update({
        'status': 'accepted',
        'accepted_at': DateTime.now().toIso8601String(),
        'invitee_user_id': user.id,
      }).eq('id', inviteId);

      // 4. 상태 갱신
      ref.invalidateSelf();
    } catch (e) {
      throw Exception('Failed to accept invite: $e');
    }
  }
}
