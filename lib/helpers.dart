bool isNullOrEmpty(String? value) => value == null || value.isEmpty;

const _epochTicks = 621355968000000000;

extension TicksOnDateTime on DateTime {
  int get ticks => this.microsecondsSinceEpoch * 10 + _epochTicks;
}

DateTime convertTimeStampToDateTime(int timeStamp) => DateTime.fromMillisecondsSinceEpoch(timeStamp);

String humanizeDateTime(DateTime? dateTime) {
  if (dateTime == null) {
    return '';
  }

  if (DateTime.now().difference(dateTime).inMinutes < 60) {
    // less than an hour
    final minDiff = DateTime.now().difference(dateTime).inMinutes;

    if (minDiff <= 1) {
      return 'just now';
    }

    return '$minDiff minutes ago';
  }

  if (DateTime.now().difference(dateTime).inHours <= 24) {
    // less than or equal to 24 hours
    final hourDiff = DateTime.now().difference(dateTime).inHours;

    if (hourDiff <= 1) {
      return 'an hour ago';
    }

    return '$hourDiff hours ago';
  }

  final daysAgo = DateTime.now().difference(dateTime).inDays;
  return daysAgo <= 1 ? '1 day ago' : '$daysAgo days ago';
}
