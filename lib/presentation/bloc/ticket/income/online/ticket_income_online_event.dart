abstract class TicketIncomeOnlineEvent {}

class GetOnlineTicketIncome extends TicketIncomeOnlineEvent {
  final int offset, limit;
  GetOnlineTicketIncome( {required this.offset, required this.limit,});
}