import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'web3_wallet.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class Web3Wallet extends UserIdentifyingData {
  final String web3Wallet;
  final Verification verification;
  final DateTime updatedAt;
  final DateTime createdAt;

  Web3Wallet({
    required super.id,
    required this.web3Wallet,
    required this.verification,
    required this.updatedAt,
    required this.createdAt,
  });

  String get identifier => web3Wallet;

  factory Web3Wallet.fromJson(Map<String, dynamic> json) => _$Web3WalletFromJson(json);

  Map<String, dynamic> toJson() => _$Web3WalletToJson(this);
}
