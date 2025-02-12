// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskImpl _$$TaskImplFromJson(Map<String, dynamic> json) => _$TaskImpl(
      id: json['id'] as String,
      userId: json['user_id'] as String?,
      taskType: $enumDecode(_$TaskTypeEnumMap, json['task_type']),
      duration: (json['duration'] as num).toInt(),
      status: json['status'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      matchId: json['match_id'] as String?,
    );

Map<String, dynamic> _$$TaskImplToJson(_$TaskImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'task_type': _$TaskTypeEnumMap[instance.taskType]!,
      'duration': instance.duration,
      'status': instance.status,
      'created_at': instance.createdAt.toIso8601String(),
      'match_id': instance.matchId,
    };

const _$TaskTypeEnumMap = {
  TaskType.cleaning: 'cleaning',
  TaskType.laundry: 'laundry',
};
