// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SocialSettings _$SocialSettingsFromJson(Map<String, dynamic> json) =>
    SocialSettings(
      apple: SocialEntity.fromJson(json['oauth_apple'] as Map<String, dynamic>),
      google:
          SocialEntity.fromJson(json['oauth_google'] as Map<String, dynamic>),
      github:
          SocialEntity.fromJson(json['oauth_github'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SocialSettingsToJson(SocialSettings instance) =>
    <String, dynamic>{
      'oauth_apple': instance.apple.toJson(),
      'oauth_google': instance.google.toJson(),
      'oauth_github': instance.github.toJson(),
    };
