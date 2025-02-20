// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskImpl _$$TaskImplFromJson(Map<String, dynamic> json) => _$TaskImpl(
      id: json['id'] as String,
      groupId: json['group_id'] as String,
      categoryId: json['category_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      taskAssignments: (json['task_assignments'] as List<dynamic>)
          .map((e) => TaskAssignment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$TaskImplToJson(_$TaskImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'group_id': instance.groupId,
      'category_id': instance.categoryId,
      'title': instance.title,
      'description': instance.description,
      'task_assignments':
          instance.taskAssignments.map((e) => e.toJson()).toList(),
    };

_$TaskAssignmentImpl _$$TaskAssignmentImplFromJson(Map<String, dynamic> json) =>
    _$TaskAssignmentImpl(
      taskId: json['task_id'] as String,
      userId: json['user_id'] as String,
      startTime: DateTime.parse(json['start_time'] as String),
      endTime: DateTime.parse(json['end_time'] as String),
      taskStatus: json['task_status'] as String,
      profiles: Profile.fromJson(json['profiles'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TaskAssignmentImplToJson(
        _$TaskAssignmentImpl instance) =>
    <String, dynamic>{
      'task_id': instance.taskId,
      'user_id': instance.userId,
      'start_time': instance.startTime.toIso8601String(),
      'end_time': instance.endTime.toIso8601String(),
      'task_status': instance.taskStatus,
      'profiles': instance.profiles.toJson(),
    };

_$ProfileImpl _$$ProfileImplFromJson(Map<String, dynamic> json) =>
    _$ProfileImpl(
      id: json['id'] as String,
      nickname: json['nickname'] as String,
      profileUrl: json['profile_url'] as String?,
    );

Map<String, dynamic> _$$ProfileImplToJson(_$ProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nickname': instance.nickname,
      'profile_url': instance.profileUrl,
    };
