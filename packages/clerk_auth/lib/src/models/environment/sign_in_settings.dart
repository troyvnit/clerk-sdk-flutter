import 'package:clerk_auth/src/models/informative_to_string_mixin.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import '../../utils/json_serialization_helpers.dart';

part 'sign_in_settings.g.dart';

/// [SignInSettings] Clerk object
@immutable
@JsonSerializable()
class SignInSettings with InformativeToStringMixin {
  /// Constructor
  const SignInSettings({
    this.secondFactorRequired = false,
  });

  /// second factor required?
  @JsonKey(readValue: _readRequired)
  final bool secondFactorRequired;

  /// empty [SignInSettings] object
  static const empty = SignInSettings();

  /// fromJson
  static SignInSettings fromJson(Map<String, dynamic> json) =>
      _$SignInSettingsFromJson(json);

  /// toJson
  @override
  Map<String, dynamic> toJson() => _$SignInSettingsToJson(this);
}

bool _readRequired(map, name) => readBool(map, name, 'required');
