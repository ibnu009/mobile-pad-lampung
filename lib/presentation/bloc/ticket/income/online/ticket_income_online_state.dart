import '../../../../../core/data/model/response/ticket_income_response.dart';

abstract class TicketIncomeOnlineState {}

class InitiateTicketIncomeOnlineState extends TicketIncomeOnlineState {}

class LoadingTicketIncomeOnline extends TicketIncomeOnlineState {}

class SuccessShowOnlineTicketIncome extends TicketIncomeOnlineState {
  final List<IncomeTicket> data;
  final int totalData, grandTotal, total;
  final String operatorName;

  SuccessShowOnlineTicketIncome(this.data, this.totalData, this.grandTotal, this.operatorName, this.total);
}

class FailedShowOnlineTicket extends TicketIncomeOnlineState {
  String message;

  FailedShowOnlineTicket(this.message);
}

class ShowTokenExpiredIncomeOnline extends TicketIncomeOnlineState {
  String message;

  ShowTokenExpiredIncomeOnline(this.message);
}
