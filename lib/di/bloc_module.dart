import 'package:get_it/get_it.dart';
import 'package:pad_lampung/presentation/bloc/auth/login_bloc.dart';

import '../presentation/bloc/park/park_bloc.dart';
import '../presentation/bloc/ticket/price/ticket_price_bloc.dart';
import '../presentation/bloc/ticket/ticket_home_bloc.dart';

void initBlocModule(GetIt locator) {
  //Auth
  locator.registerFactory(
      () => LoginBloc(repository: locator(), storage: locator()));

  locator.registerFactory(
          () => ParkBloc(repository: locator(), storage: locator()));

  locator.registerFactory(
          () => TicketHomeBloc(repository: locator(), storage: locator()));
  locator.registerFactory(
          () => TicketPriceBloc(repository: locator(), storage: locator()));
}
