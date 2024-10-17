import 'dart:io';

import 'models.dart';

class ApiResponse {
  final int status;
  final Client? client;
  final List<ApiError>? errors;

  const ApiResponse({
    required this.status,
    this.errors,
    this.client,
  });

  bool get isOkay => status == HttpStatus.ok;
  bool get isError => isOkay == false;
  bool get hasClient => isOkay && client is Client;

  Map<String, dynamic> toJson() => {
        'status': status,
        'errors': errors?.map((e) => e.toJson()).toList(),
        'client': client?.toJson(),
      };

  String get errorMessage => errors?.isNotEmpty == true ? errors!.join('; ') : 'Unknown error';
}
