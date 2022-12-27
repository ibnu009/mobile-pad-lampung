abstract class TicketIncomeOfflineEvent {}

class GetOfflineTicketIncome extends TicketIncomeOfflineEvent {
  final int offset, limit;
  GetOfflineTicketIncome( {required this.offset, required this.limit,});
}