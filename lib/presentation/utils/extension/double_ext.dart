import 'package:intl/intl.dart';

extension DoubleConverter on double? {
  String toRupiah() {
    final formatCurrency = NumberFormat.currency(locale: "id-ID");
    String formattedCurrency = "Rp ${formatCurrency.format(this ?? 0).substring(3)}";

    return formattedCurrency.substring(0, formattedCurrency.indexOf(','));
  }

}