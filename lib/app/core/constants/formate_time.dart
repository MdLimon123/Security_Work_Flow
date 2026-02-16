import 'package:intl/intl.dart';

// Global helper function
String formatUtcToLocal(
  String? date,
  String? time, {
  String format = "hh:mm a",
}) {
  if (date == null || time == null || date.isEmpty || time.isEmpty) return "";
  try {
    DateTime utcDateTime = DateTime.parse("${date}T${time}Z");
    DateTime localDateTime = utcDateTime.toLocal();
    return DateFormat(format).format(localDateTime);
  } catch (e) {
    return time ?? "";
  }
}

String formatUtcToLocalSafe(String? utcTime) {
  if (utcTime == null || utcTime.isEmpty) return "-";
  final parsedTime = DateTime.tryParse(utcTime);
  if (parsedTime == null) return "-";
  return DateFormat.jm().format(parsedTime.toLocal());
}
