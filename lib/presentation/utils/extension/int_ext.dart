import 'package:intl/intl.dart';

extension IntegerConverter on int {
  String toRupiah() {
    final formatCurrency = NumberFormat.currency(locale: "id-ID");
    String formattedCurrency = "Rp " + formatCurrency.format(this).substring(3);

    return formattedCurrency.substring(0, formattedCurrency.indexOf(','));
  }

  int getTotalPageByTotalData(int itemPerPage){
    try {
      int totalPage = (toNearestItemPerPage(itemPerPage) / itemPerPage).round();

      if (totalPage == 0){
        return 1;
      }

      return totalPage;
    } catch(e) {
      return 1;
    }
  }

  int toNearestItemPerPage(int itemPerPage) {
    int a = this % itemPerPage;

    if (a > 0) {
      return (this ~/ itemPerPage) * itemPerPage + itemPerPage;
    }

    return this;
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
