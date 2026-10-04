class DateFormatter {
  static String formatDate(String date) {
    final parsedDate = DateTime.parse(date);

    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return '${months[parsedDate.month - 1]} '
        '${parsedDate.day}, '
        '${parsedDate.year}';
  }
}
