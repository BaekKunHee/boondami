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
  @JsonSerializable(
    fieldRename: FieldRename.snake,
    includeIfNull: false,
    explicitToJson: true,
  )
  factory Task({
    required String id,
    @JsonKey(name: 'user_id') String? userId,
    @JsonKey(name: 'task_type') required TaskType taskType,
    required int duration,
    required String status,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'match_id') String? matchId,
  }) = _Task;
  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}
