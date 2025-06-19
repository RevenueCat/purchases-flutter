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

  toJson() => {
    'revision': revision,
    'ruleId': ruleId,
  };

  factory PresentedOfferingTargetingContext.fromJson(Map<String, dynamic> json) => PresentedOfferingTargetingContext(
    json['revision'] as int,
    json['ruleId'] as String,
  );

  @override
  List<Object> get props => [
    revision,
    ruleId,
  ];
}
