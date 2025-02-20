// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_assignment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TaskAssignment _$TaskAssignmentFromJson(Map<String, dynamic> json) {
  return _TaskAssignment.fromJson(json);
}

/// @nodoc
mixin _$TaskAssignment {
  @JsonKey(name: 'task_id')
  String get taskId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_time')
  DateTime get startTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_time')
  DateTime get endTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'task_status')
  String get taskStatus => throw _privateConstructorUsedError;
  Profile get profiles => throw _privateConstructorUsedError;

  /// Serializes this TaskAssignment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TaskAssignment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaskAssignmentCopyWith<TaskAssignment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskAssignmentCopyWith<$Res> {
  factory $TaskAssignmentCopyWith(
          TaskAssignment value, $Res Function(TaskAssignment) then) =
      _$TaskAssignmentCopyWithImpl<$Res, TaskAssignment>;
  @useResult
  $Res call(
      {@JsonKey(name: 'task_id') String taskId,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'start_time') DateTime startTime,
      @JsonKey(name: 'end_time') DateTime endTime,
      @JsonKey(name: 'task_status') String taskStatus,
      Profile profiles});

  $ProfileCopyWith<$Res> get profiles;
}

/// @nodoc
class _$TaskAssignmentCopyWithImpl<$Res, $Val extends TaskAssignment>
    implements $TaskAssignmentCopyWith<$Res> {
  _$TaskAssignmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaskAssignment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskId = null,
    Object? userId = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? taskStatus = null,
    Object? profiles = null,
  }) {
    return _then(_value.copyWith(
      taskId: null == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      taskStatus: null == taskStatus
          ? _value.taskStatus
          : taskStatus // ignore: cast_nullable_to_non_nullable
              as String,
      profiles: null == profiles
          ? _value.profiles
          : profiles // ignore: cast_nullable_to_non_nullable
              as Profile,
    ) as $Val);
  }

  /// Create a copy of TaskAssignment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProfileCopyWith<$Res> get profiles {
    return $ProfileCopyWith<$Res>(_value.profiles, (value) {
      return _then(_value.copyWith(profiles: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TaskAssignmentImplCopyWith<$Res>
    implements $TaskAssignmentCopyWith<$Res> {
  factory _$$TaskAssignmentImplCopyWith(_$TaskAssignmentImpl value,
          $Res Function(_$TaskAssignmentImpl) then) =
      __$$TaskAssignmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'task_id') String taskId,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'start_time') DateTime startTime,
      @JsonKey(name: 'end_time') DateTime endTime,
      @JsonKey(name: 'task_status') String taskStatus,
      Profile profiles});

  @override
  $ProfileCopyWith<$Res> get profiles;
}

/// @nodoc
class __$$TaskAssignmentImplCopyWithImpl<$Res>
    extends _$TaskAssignmentCopyWithImpl<$Res, _$TaskAssignmentImpl>
    implements _$$TaskAssignmentImplCopyWith<$Res> {
  __$$TaskAssignmentImplCopyWithImpl(
      _$TaskAssignmentImpl _value, $Res Function(_$TaskAssignmentImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskAssignment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskId = null,
    Object? userId = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? taskStatus = null,
    Object? profiles = null,
  }) {
    return _then(_$TaskAssignmentImpl(
      taskId: null == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      taskStatus: null == taskStatus
          ? _value.taskStatus
          : taskStatus // ignore: cast_nullable_to_non_nullable
              as String,
      profiles: null == profiles
          ? _value.profiles
          : profiles // ignore: cast_nullable_to_non_nullable
              as Profile,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskAssignmentImpl implements _TaskAssignment {
  const _$TaskAssignmentImpl(
      {@JsonKey(name: 'task_id') required this.taskId,
      @JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'start_time') required this.startTime,
      @JsonKey(name: 'end_time') required this.endTime,
      @JsonKey(name: 'task_status') required this.taskStatus,
      required this.profiles});

  factory _$TaskAssignmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskAssignmentImplFromJson(json);

  @override
  @JsonKey(name: 'task_id')
  final String taskId;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'start_time')
  final DateTime startTime;
  @override
  @JsonKey(name: 'end_time')
  final DateTime endTime;
  @override
  @JsonKey(name: 'task_status')
  final String taskStatus;
  @override
  final Profile profiles;

  @override
  String toString() {
    return 'TaskAssignment(taskId: $taskId, userId: $userId, startTime: $startTime, endTime: $endTime, taskStatus: $taskStatus, profiles: $profiles)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskAssignmentImpl &&
            (identical(other.taskId, taskId) || other.taskId == taskId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.taskStatus, taskStatus) ||
                other.taskStatus == taskStatus) &&
            (identical(other.profiles, profiles) ||
                other.profiles == profiles));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, taskId, userId, startTime, endTime, taskStatus, profiles);

  /// Create a copy of TaskAssignment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskAssignmentImplCopyWith<_$TaskAssignmentImpl> get copyWith =>
      __$$TaskAssignmentImplCopyWithImpl<_$TaskAssignmentImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskAssignmentImplToJson(
      this,
    );
  }
}

abstract class _TaskAssignment implements TaskAssignment {
  const factory _TaskAssignment(
      {@JsonKey(name: 'task_id') required final String taskId,
      @JsonKey(name: 'user_id') required final String userId,
      @JsonKey(name: 'start_time') required final DateTime startTime,
      @JsonKey(name: 'end_time') required final DateTime endTime,
      @JsonKey(name: 'task_status') required final String taskStatus,
      required final Profile profiles}) = _$TaskAssignmentImpl;

  factory _TaskAssignment.fromJson(Map<String, dynamic> json) =
      _$TaskAssignmentImpl.fromJson;

  @override
  @JsonKey(name: 'task_id')
  String get taskId;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'start_time')
  DateTime get startTime;
  @override
  @JsonKey(name: 'end_time')
  DateTime get endTime;
  @override
  @JsonKey(name: 'task_status')
  String get taskStatus;
  @override
  Profile get profiles;

  /// Create a copy of TaskAssignment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskAssignmentImplCopyWith<_$TaskAssignmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
