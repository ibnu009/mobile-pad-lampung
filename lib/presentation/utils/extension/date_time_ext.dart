import 'package:intl/intl.dart';

extension DateTimeConverter on DateTime {
  String getDueDateFromDateTime() {
    DateTime dateNow = DateTime.now();
    Duration diff = difference(dateNow);

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

  String toFormattedDate({String? format}) {
    String formattedDate = DateFormat(format ?? 'dd MMM yyyy').format(this);
    return formattedDate;
  }

  bool isWeekend() {
    return (weekday == DateTime.sunday || weekday == DateTime.saturday);
  }

}