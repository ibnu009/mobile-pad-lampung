import 'package:pad_lampung/core/data/model/response/ticket_list_response.dart';


abstract class TicketPagingState {}

class InitiateTicketPagingState extends TicketPagingState {}

class LoadingTicketPagingState extends TicketPagingState {}

class SuccessShowTicketData extends TicketPagingState {
  final List<Ticket> data;
  final int totalData;
  SuccessShowTicketData(this.data, this.totalData);
}

class FailedShowTicketQuota extends TicketPagingState {
  String message;
  FailedShowTicketQuota(this.message);
}

class ShowTokenExpired extends TicketPagingState {
  String message;
  ShowTokenExpired(this.message);
}