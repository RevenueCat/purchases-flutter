import 'package:equatable/equatable.dart';

class PresentedOfferingTargetingContext extends Equatable {
  /// The revision of the targeting used to obtain this object
  final int revision;

  /// The rule id from the targeting used to obtain this object
  final String ruleId;

  const PresentedOfferingTargetingContext({
    required this.revision,
    required this.ruleId,
  });

  toJson() => {
    'revision': revision,
    'ruleId': ruleId,
  };

  factory PresentedOfferingTargetingContext.fromJson(Map<String, dynamic> json) => PresentedOfferingTargetingContext(
    revision: json['revision'] as int,
    ruleId: json['ruleId'] as String,
  );

  @override
  List<Object> get props => [
    revision,
    ruleId,
  ];
}
