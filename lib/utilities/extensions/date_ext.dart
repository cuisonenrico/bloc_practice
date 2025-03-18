import 'package:intl/intl.dart';

extension DateExt on DateTime {
  String get toFormattedDate => DateFormat('MMMM dd, yyyy').format(this);

  String get toFormattedTime => DateFormat('hh:mm').format(this);
}

extension DurationExt on Duration {
  String get formatDuration {
    String twoDigits(int n) => n.toString().padLeft(2, "0");

    String hours = twoDigits(inHours);
    String minutes = twoDigits(inMinutes.remainder(60));

    return "$hours:$minutes";
  }
}
