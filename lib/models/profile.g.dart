// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfileImpl _$$ProfileImplFromJson(Map<String, dynamic> json) =>
    _$ProfileImpl(
      id: json['id'] as String,
      nickname: json['nickname'] as String,
      profileUrl: json['profile_url'] as String?,
    );

Map<String, dynamic> _$$ProfileImplToJson(_$ProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nickname': instance.nickname,
      'profile_url': instance.profileUrl,
    };
