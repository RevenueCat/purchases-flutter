import 'package:freezed_annotation/freezed_annotation.dart';

import '../errors.dart';

part 'purchases_error.freezed.dart';
part 'purchases_error.g.dart';

@freezed
class PurchasesError with _$PurchasesError {
  const factory PurchasesError(
    @PurchasesErrorCodeConverter() PurchasesErrorCode code,
    String message,
    String underlyingErrorMessage,
    // iOS can return a readable error code null, because the construction
    // of the error doesn't prevent it from being null. To be safe we default
    // it to '' instead of making it nullable
    // ignore: invalid_annotation_target
    @JsonKey(defaultValue: '') String readableErrorCode,
  ) = _PurchasesError;

  factory PurchasesError.fromJson(Map<String, dynamic> json) =>
      _$PurchasesErrorFromJson(json);
}

class PurchasesErrorCodeConverter
    implements JsonConverter<PurchasesErrorCode, int> {
  const PurchasesErrorCodeConverter();

  @override
  PurchasesErrorCode fromJson(int json) {
    if (json >= PurchasesErrorCode.values.length) {
      return PurchasesErrorCode.unknownError;
    }
    return PurchasesErrorCode.values[json];
  }

  @override
  int toJson(PurchasesErrorCode errorCode) =>
      PurchasesErrorCode.values.indexOf(errorCode);
}
