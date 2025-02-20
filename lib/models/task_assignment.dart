import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jobmoim/models/profile.dart';

part 'task_assignment.freezed.dart';
part 'task_assignment.g.dart';

@freezed
class TaskAssignment with _$TaskAssignment {
  const factory TaskAssignment({
    @JsonKey(name: 'task_id') required String taskId,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'start_time') required DateTime startTime,
    @JsonKey(name: 'end_time') required DateTime endTime,
    @JsonKey(name: 'task_status') required String taskStatus,
    required Profile profiles,
  }) = _TaskAssignment;

  factory TaskAssignment.fromJson(Map<String, dynamic> json) =>
      _$TaskAssignmentFromJson(json);
} 