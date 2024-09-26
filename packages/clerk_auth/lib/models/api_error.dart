import 'package:json_annotation/json_annotation.dart';

part 'api_error.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class ApiError {
  final String message;
  final String? code;
  final Map<String, String>? meta;
  final String? longMessage;

  const ApiError({
    required this.message,
    this.code,
    this.meta,
    this.longMessage,
  });

  factory ApiError.fromJson(Map<String, dynamic> json) => _$ApiErrorFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorToJson(this);

  String toString() => [code, longMessage ?? message].whereType<String>().join(': ');
}
