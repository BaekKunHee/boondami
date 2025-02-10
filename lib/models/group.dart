import 'package:freezed_annotation/freezed_annotation.dart';

part 'group.freezed.dart';
part 'group.g.dart';

@freezed
class Group with _$Group {
  const factory Group({
    required String id,
    required String name,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @Default(0) int memberCount,
  }) = _Group;

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);
}
