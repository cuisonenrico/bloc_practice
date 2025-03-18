import 'package:intl/intl.dart';

extension DateExt on DateTime {
  String get toFormattedDate => DateFormat('MMMM dd, yyyy').format(this);
}
