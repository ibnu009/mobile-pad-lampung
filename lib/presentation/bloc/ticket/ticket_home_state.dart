import '../../../core/data/model/holder/ticket_home_content_holder.dart';

abstract class TicketHomeState {}

class InitiateTicketHomeState extends TicketHomeState {}

class LoadingTicketHome extends TicketHomeState {}

class SuccessShowTicketQuota extends TicketHomeState {
  final TicketHomeContentHolder data;
  SuccessShowTicketQuota(this.data);
}

class FailedShowTicketQuota extends TicketHomeState {
  String message;
  FailedShowTicketQuota(this.message);
}

class ShowTokenExpired extends TicketHomeState {
  String message;
  ShowTokenExpired(this.message);
}