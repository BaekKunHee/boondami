// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Task _$TaskFromJson(Map<String, dynamic> json) {
  return _Task.fromJson(json);
}

/// @nodoc
mixin _$Task {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'group_id')
  String get groupId => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_id')
  String get categoryId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'task_assignments')
  List<TaskAssignment> get taskAssignments =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'task_categories')
  TaskCategory? get taskCategories => throw _privateConstructorUsedError;

  /// Serializes this Task to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaskCopyWith<Task> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskCopyWith<$Res> {
  factory $TaskCopyWith(Task value, $Res Function(Task) then) =
      _$TaskCopyWithImpl<$Res, Task>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'group_id') String groupId,
      @JsonKey(name: 'category_id') String categoryId,
      String title,
      String description,
      @JsonKey(name: 'task_assignments') List<TaskAssignment> taskAssignments,
      @JsonKey(name: 'task_categories') TaskCategory? taskCategories});

  $TaskCategoryCopyWith<$Res>? get taskCategories;
}

/// @nodoc
class _$TaskCopyWithImpl<$Res, $Val extends Task>
    implements $TaskCopyWith<$Res> {
  _$TaskCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? groupId = null,
    Object? categoryId = null,
    Object? title = null,
    Object? description = null,
    Object? taskAssignments = null,
    Object? taskCategories = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      taskAssignments: null == taskAssignments
          ? _value.taskAssignments
          : taskAssignments // ignore: cast_nullable_to_non_nullable
              as List<TaskAssignment>,
      taskCategories: freezed == taskCategories
          ? _value.taskCategories
          : taskCategories // ignore: cast_nullable_to_non_nullable
              as TaskCategory?,
    ) as $Val);
  }

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TaskCategoryCopyWith<$Res>? get taskCategories {
    if (_value.taskCategories == null) {
      return null;
    }

    return $TaskCategoryCopyWith<$Res>(_value.taskCategories!, (value) {
      return _then(_value.copyWith(taskCategories: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TaskImplCopyWith<$Res> implements $TaskCopyWith<$Res> {
  factory _$$TaskImplCopyWith(
          _$TaskImpl value, $Res Function(_$TaskImpl) then) =
      __$$TaskImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'group_id') String groupId,
      @JsonKey(name: 'category_id') String categoryId,
      String title,
      String description,
      @JsonKey(name: 'task_assignments') List<TaskAssignment> taskAssignments,
      @JsonKey(name: 'task_categories') TaskCategory? taskCategories});

  @override
  $TaskCategoryCopyWith<$Res>? get taskCategories;
}

/// @nodoc
class __$$TaskImplCopyWithImpl<$Res>
    extends _$TaskCopyWithImpl<$Res, _$TaskImpl>
    implements _$$TaskImplCopyWith<$Res> {
  __$$TaskImplCopyWithImpl(_$TaskImpl _value, $Res Function(_$TaskImpl) _then)
      : super(_value, _then);

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? groupId = null,
    Object? categoryId = null,
    Object? title = null,
    Object? description = null,
    Object? taskAssignments = null,
    Object? taskCategories = freezed,
  }) {
    return _then(_$TaskImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      taskAssignments: null == taskAssignments
          ? _value._taskAssignments
          : taskAssignments // ignore: cast_nullable_to_non_nullable
              as List<TaskAssignment>,
      taskCategories: freezed == taskCategories
          ? _value.taskCategories
          : taskCategories // ignore: cast_nullable_to_non_nullable
              as TaskCategory?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskImpl implements _Task {
  const _$TaskImpl(
      {required this.id,
      @JsonKey(name: 'group_id') required this.groupId,
      @JsonKey(name: 'category_id') required this.categoryId,
      required this.title,
      required this.description,
      @JsonKey(name: 'task_assignments')
      required final List<TaskAssignment> taskAssignments,
      @JsonKey(name: 'task_categories') this.taskCategories})
      : _taskAssignments = taskAssignments;

  factory _$TaskImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'group_id')
  final String groupId;
  @override
  @JsonKey(name: 'category_id')
  final String categoryId;
  @override
  final String title;
  @override
  final String description;
  final List<TaskAssignment> _taskAssignments;
  @override
  @JsonKey(name: 'task_assignments')
  List<TaskAssignment> get taskAssignments {
    if (_taskAssignments is EqualUnmodifiableListView) return _taskAssignments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_taskAssignments);
  }

  @override
  @JsonKey(name: 'task_categories')
  final TaskCategory? taskCategories;

  @override
  String toString() {
    return 'Task(id: $id, groupId: $groupId, categoryId: $categoryId, title: $title, description: $description, taskAssignments: $taskAssignments, taskCategories: $taskCategories)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._taskAssignments, _taskAssignments) &&
            (identical(other.taskCategories, taskCategories) ||
                other.taskCategories == taskCategories));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      groupId,
      categoryId,
      title,
      description,
      const DeepCollectionEquality().hash(_taskAssignments),
      taskCategories);

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskImplCopyWith<_$TaskImpl> get copyWith =>
      __$$TaskImplCopyWithImpl<_$TaskImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskImplToJson(
      this,
    );
  }
}

abstract class _Task implements Task {
  const factory _Task(
      {required final String id,
      @JsonKey(name: 'group_id') required final String groupId,
      @JsonKey(name: 'category_id') required final String categoryId,
      required final String title,
      required final String description,
      @JsonKey(name: 'task_assignments')
      required final List<TaskAssignment> taskAssignments,
      @JsonKey(name: 'task_categories')
      final TaskCategory? taskCategories}) = _$TaskImpl;

  factory _Task.fromJson(Map<String, dynamic> json) = _$TaskImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'group_id')
  String get groupId;
  @override
  @JsonKey(name: 'category_id')
  String get categoryId;
  @override
  String get title;
  @override
  String get description;
  @override
  @JsonKey(name: 'task_assignments')
  List<TaskAssignment> get taskAssignments;
  @override
  @JsonKey(name: 'task_categories')
  TaskCategory? get taskCategories;

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskImplCopyWith<_$TaskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
