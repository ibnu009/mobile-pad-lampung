import 'package:intl/intl.dart';

extension IntegerConverter on int {
  String toRupiah() {
    final formatCurrency = NumberFormat.currency(locale: "id-ID");
    String formattedCurrency = "Rp " + formatCurrency.format(this).substring(3);

    return formattedCurrency.substring(0, formattedCurrency.indexOf(','));
  }

  String toPercentage(int total) {
    if (total == 0) {
      return '0%';
    }
    double result = 0.0;
    result = this / total;
    result = result * 100;
    return '${result.round()}%';
  }

  bool isStatusSuccess() {
    return (this == 200 || this == 201);
  }
}
