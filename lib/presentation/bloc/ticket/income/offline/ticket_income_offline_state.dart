import '../../../../../core/data/model/response/ticket_income_response.dart';

abstract class TicketIncomeOfflineState {}

class InitiateTicketIncomeOfflineState extends TicketIncomeOfflineState {}

class LoadingTicketIncomeOffline extends TicketIncomeOfflineState {}

class SuccessShowOfflineTicketIncome extends TicketIncomeOfflineState {
  final List<IncomeTicket> data;
  final int totalData, grandTotal;
  final String deviceName, operatorName, wisataName;

  SuccessShowOfflineTicketIncome(
      {required this.data,
      required this.totalData,
      required this.grandTotal,
      required this.deviceName,
      required this.operatorName,
      required this.wisataName});
}

class FailedShowOfflineTicket extends TicketIncomeOfflineState {
  String message;

  FailedShowOfflineTicket(this.message);
}

class ShowTokenExpiredIncomeOffline extends TicketIncomeOfflineState {
  String message;

  ShowTokenExpiredIncomeOffline(this.message);
}
