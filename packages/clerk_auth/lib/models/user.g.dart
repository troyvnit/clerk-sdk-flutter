// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      profileImageUrl: json['profile_image_url'] as String?,
      imageUrl: json['image_url'] as String?,
      hasImage: json['has_image'] as bool?,
      primaryEmailAddressId: json['primary_email_address_id'] as String?,
      primaryPhoneNumberId: json['primary_phone_number_id'] as String?,
      primaryWeb3WalletId: json['primary_web3_wallet_id'] as String?,
      publicMetadata: json['public_metadata'] as Map<String, dynamic>?,
      privateMetadata: json['private_metadata'] as Map<String, dynamic>?,
      unsafeMetadata: json['unsafe_metadata'] as Map<String, dynamic>?,
      emailAddresses: (json['email_addresses'] as List<dynamic>?)
          ?.map((e) => Email.fromJson(e as Map<String, dynamic>))
          .toList(),
      phoneNumbers: (json['phone_numbers'] as List<dynamic>?)
          ?.map((e) => PhoneNumber.fromJson(e as Map<String, dynamic>))
          .toList(),
      web3Wallets: (json['web3_wallets'] as List<dynamic>?)
          ?.map((e) => Web3Wallet.fromJson(e as Map<String, dynamic>))
          .toList(),
      passkeys: (json['passkeys'] as List<dynamic>?)
          ?.map((e) => Passkey.fromJson(e as Map<String, dynamic>))
          .toList(),
      organizationMemberships: (json['organization_memberships']
              as List<dynamic>?)
          ?.map(
              (e) => OrganizationMembership.fromJson(e as Map<String, dynamic>))
          .toList(),
      passwordEnabled: json['password_enabled'] as bool?,
      twoFactorEnabled: json['two_factor_enabled'] as bool?,
      totpEnabled: json['totp_enabled'] as bool?,
      backupCodeEnabled: json['backup_code_enabled'] as bool?,
      lastSignInAt: intToDateTime(json['last_sign_in_at']),
      banned: json['banned'] as bool?,
      locked: json['locked'] as bool?,
      lockoutExpiresInSeconds:
          (json['lockout_expires_in_seconds'] as num?)?.toInt(),
      verificationAttemptsRemaining:
          (json['verification_attempts_remaining'] as num?)?.toInt(),
      updatedAt: intToDateTime(json['updated_at']),
      createdAt: intToDateTime(json['created_at']),
      lastActiveAt: intToDateTime(json['last_active_at']),
      deleteSelfEnabled: json['delete_self_enabled'] as bool?,
    )
      ..email = json['email'] as String?
      ..phoneNumber = json['phone_number'] as String?
      ..web3WalletId = json['web3_wallet_id'] as String?;

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'profile_image_url': instance.profileImageUrl,
      'image_url': instance.imageUrl,
      'has_image': instance.hasImage,
      'primary_email_address_id': instance.primaryEmailAddressId,
      'primary_phone_number_id': instance.primaryPhoneNumberId,
      'primary_web3_wallet_id': instance.primaryWeb3WalletId,
      'public_metadata': instance.publicMetadata,
      'private_metadata': instance.privateMetadata,
      'unsafe_metadata': instance.unsafeMetadata,
      'email_addresses':
          instance.emailAddresses?.map((e) => e.toJson()).toList(),
      'phone_numbers': instance.phoneNumbers?.map((e) => e.toJson()).toList(),
      'web3_wallets': instance.web3Wallets?.map((e) => e.toJson()).toList(),
      'passkeys': instance.passkeys?.map((e) => e.toJson()).toList(),
      'organization_memberships':
          instance.organizationMemberships?.map((e) => e.toJson()).toList(),
      'password_enabled': instance.passwordEnabled,
      'two_factor_enabled': instance.twoFactorEnabled,
      'totp_enabled': instance.totpEnabled,
      'backup_code_enabled': instance.backupCodeEnabled,
      'banned': instance.banned,
      'locked': instance.locked,
      'lockout_expires_in_seconds': instance.lockoutExpiresInSeconds,
      'verification_attempts_remaining': instance.verificationAttemptsRemaining,
      'delete_self_enabled': instance.deleteSelfEnabled,
      'last_sign_in_at': instance.lastSignInAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
      'last_active_at': instance.lastActiveAt?.toIso8601String(),
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'web3_wallet_id': instance.web3WalletId,
    };
