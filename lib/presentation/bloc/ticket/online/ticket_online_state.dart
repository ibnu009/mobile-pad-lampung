
import 'package:pad_lampung/core/data/model/response/ticket_list_response.dart';

abstract class TicketOnlineState {}

class InitiateTicketOnlineState extends TicketOnlineState {}

class LoadingTicketOnline extends TicketOnlineState {}

class SuccessShowOnlineTicket extends TicketOnlineState {
  final List<Ticket> data;
  SuccessShowOnlineTicket(this.data);
}

class FailedShowOnlineTicket extends TicketOnlineState {
  String message;
  FailedShowOnlineTicket(this.message);
}

class ShowTokenExpired extends TicketOnlineState {
  String message;
  ShowTokenExpired(this.message);
}