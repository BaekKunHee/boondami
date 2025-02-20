import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jobmoim/models/member.dart';

part 'group.freezed.dart';
part 'group.g.dart';

@freezed
class Group with _$Group {
  const factory Group({
    required String id,
    required String name,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @Default(0) int memberCount,
    @Default([]) List<Member> members,
  }) = _Group;

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);
}
