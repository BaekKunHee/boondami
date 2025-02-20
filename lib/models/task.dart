import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.freezed.dart';
part 'task.g.dart';

enum TaskType {
  @JsonValue('cleaning')
  cleaning('청소'),
  @JsonValue('laundry')
  laundry('세탁');

  final String label;
  const TaskType(this.label);
}

@freezed
class Task with _$Task {
  const factory Task({
    required String id,
    @JsonKey(name: 'group_id') required String groupId,
    @JsonKey(name: 'category_id') required String categoryId,
    required String title,
    required String description,
    @JsonKey(name: 'task_assignments')
    required List<TaskAssignment> taskAssignments,
    
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}

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

@freezed
class Profile with _$Profile {
  const factory Profile({
    required String id,
    required String nickname,
    @JsonKey(name: 'profile_url') String? profileUrl,
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
}
