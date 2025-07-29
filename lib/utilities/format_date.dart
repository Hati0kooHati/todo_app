import 'package:intl/intl.dart';

final Map<int, String> months = {
  1: 'January',
  2: 'February',
  3: 'March',
  4: 'April',
  5: 'May',
  6: 'June',
  7: 'July',
  8: 'August',
  9: 'September',
  10: 'October',
  11: 'November',
  12: 'December',
};

final dateFormatter = DateFormat("d MM yyyy");

String formatDate(DateTime date) {
  final int monthIndex = date.month;

  String formattedDate = dateFormatter.format(date);
  return formattedDate.replaceAll("$monthIndex", months[monthIndex]!);
}
