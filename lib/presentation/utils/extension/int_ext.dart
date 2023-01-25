import 'package:intl/intl.dart';

extension IntegerConverter on int? {
  String toRupiah() {
    if (this == null) return "Rp 0";

    final formatCurrency = NumberFormat.currency(locale: "id-ID");
    String formattedCurrency = formatCurrency.format(this).substring(3);

    print('result is ${formattedCurrency.substring(0, formattedCurrency.indexOf(','))}');
    String result = formattedCurrency.substring(0, formattedCurrency.indexOf(','));

    if (result.contains("R")) {
      return "Rp ${result.replaceAll(RegExp('R'), '-')}";
    }

    return "Rp ${formattedCurrency.substring(0, formattedCurrency.indexOf(','))}";
  }

  int getTotalPageByTotalData(int itemPerPage){

    if (this == null) return 1;

    try {
      int totalPage = (toNearestItemPerPage(itemPerPage)! / itemPerPage).round();

      if (totalPage == 0){
        return 1;
      }

      return totalPage;
    } catch(e) {
      return 1;
    }
  }

  int? toNearestItemPerPage(int itemPerPage) {
    if (this == null) return 0;

    int a = this! % itemPerPage;

    if (a > 0) {
      return (this! ~/ itemPerPage) * itemPerPage + itemPerPage;
    }

    return this;
  }

  String toPercentage(int total) {

    if (this == null) return '0%';

    if (total == 0) {
      return '0%';
    }
    double result = 0.0;
    result = (this! / total)!;
    result = result * 100;
    return '${result.round()}%';
  }

  bool isStatusSuccess() {
    return (this == 200 || this == 201);
  }
}
