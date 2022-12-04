import 'package:intl/intl.dart';

extension IntegerConverter on int {
  String toRupiah() {
    final formatCurrency = NumberFormat.currency(locale: "id-ID");
    String formattedCurrency = "Rp " + formatCurrency.format(this).substring(3);

    return formattedCurrency.substring(0, formattedCurrency.indexOf(','));
  }

  int toKilometerFromMeter() {
    if (this == 0){
      return 0;
    }
    return (this / 1000).round();
  }

  String toDate(){
    DateTime date = DateTime.fromMillisecondsSinceEpoch(this);
    String result = DateFormat('yyyy-MM-dd').format(date);
    return result;
  }

  String toDistance(){
    String result = '$this m';
    if(this > 1000){
      int distance = (this / 1000).round();
      result = '$distance km';
    }
    return result;
  }

  String getDifferentFromMilliWithToday(){
    DateTime dateNow = DateTime.now();
    DateTime dt2 = DateTime.fromMillisecondsSinceEpoch(this);

    Duration diff = dt2.difference(dateNow);
    if (diff.inDays > 0){
      return "${diff.inDays} hari lagi";
    }
    if (diff.inHours > 0) {
      return "${diff.inHours} jam lagi";
    }

    return "${diff.inMinutes} menit lagi";
  }

  String getDueDateFromMilli() {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(this);
    DateTime dateNow = DateTime.now();

    Duration diff = date.difference(dateNow);

    int day = diff.inDays;
    int hour = diff.inHours;
    int mins = diff.inMinutes;

    if (day <= 0 ){
      return '$hour jam lagi';
    }

    if (hour <= 0){
      return '$mins Menit lagi';
    }

    return '$day hari lagi';
  }

}