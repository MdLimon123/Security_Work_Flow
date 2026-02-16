import 'package:intl/intl.dart';

String formatDate(String? date) {
  if (date == null || date.isEmpty) return "";

  DateTime parsedDate = DateTime.parse(date);
  return DateFormat('dd-MM-yyyy').format(parsedDate);
}
