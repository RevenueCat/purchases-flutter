// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchases_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PurchasesError _$PurchasesErrorFromJson(Map json) => _PurchasesError(
      const PurchasesErrorCodeConverter()
          .fromJson((json['code'] as num).toInt()),
      json['message'] as String,
      json['underlyingErrorMessage'] as String,
      json['readableErrorCode'] as String? ?? '',
    );

Map<String, dynamic> _$PurchasesErrorToJson(_PurchasesError instance) =>
    <String, dynamic>{
      'code': const PurchasesErrorCodeConverter().toJson(instance.code),
      'message': instance.message,
      'underlyingErrorMessage': instance.underlyingErrorMessage,
      'readableErrorCode': instance.readableErrorCode,
    };
