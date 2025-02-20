// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_assignment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
