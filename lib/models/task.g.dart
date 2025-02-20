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
      taskCategories: json['task_categories'] == null
          ? null
          : TaskCategory.fromJson(
              json['task_categories'] as Map<String, dynamic>),
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
      'task_categories': instance.taskCategories?.toJson(),
    };
