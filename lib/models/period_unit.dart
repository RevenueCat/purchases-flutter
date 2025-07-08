enum PeriodUnit {
  day,
  week,
  month,
  year,
  unknown,
  ;

  static fromJson(dynamic value) {
    switch (value) {
      case 'DAY':
        return PeriodUnit.day;
      case 'WEEK':
        return PeriodUnit.week;
      case 'MONTH':
        return PeriodUnit.month;
      case 'YEAR':
        return PeriodUnit.year;
      default:
        return PeriodUnit.unknown;
    }
  }

  String toJson() {
    switch (this) {
      case PeriodUnit.day:
        return 'DAY';
      case PeriodUnit.week:
        return 'WEEK';
      case PeriodUnit.month:
        return 'MONTH';
      case PeriodUnit.year:
        return 'YEAR';
      default:
        return 'unknown';
    }
  }
}
