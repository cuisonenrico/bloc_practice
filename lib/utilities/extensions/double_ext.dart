import 'package:intl/intl.dart';

extension DoubleExt on double {
  String get toFormattedCurrency => NumberFormat.currency(
        locale: 'en_PH', // Change locale based on region
        symbol: '₱', // Change symbol as needed
      ).format(this);
}
