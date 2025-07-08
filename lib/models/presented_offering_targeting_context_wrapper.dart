import 'package:equatable/equatable.dart';

class PresentedOfferingTargetingContext extends Equatable {
  /// The revision of the targeting used to obtain this object
  final int revision;

  /// The rule id from the targeting used to obtain this object
  final String ruleId;

  const PresentedOfferingTargetingContext(
    this.revision,
    this.ruleId,
  );

  factory PresentedOfferingTargetingContext.fromJson(
    Map<String, dynamic> json,
  ) =>
      PresentedOfferingTargetingContext(
        json['revision'] as int,
        json['ruleId'] as String,
      );

  Map<String, dynamic> toJson() => {
        'revision': revision,
        'ruleId': ruleId,
      };

  @override
  List<Object> get props => [
        revision,
        ruleId,
      ];
}
