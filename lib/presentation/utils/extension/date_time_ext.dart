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
}