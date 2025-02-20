import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jobmoim/models/task_assignment.dart';
import 'package:jobmoim/models/task_category.dart';

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
    @JsonKey(name: 'task_categories') TaskCategory? taskCategories,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}
