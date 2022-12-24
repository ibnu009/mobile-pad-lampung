import 'package:get_it/get_it.dart';
import 'package:pad_lampung/presentation/bloc/auth/login_bloc.dart';
import 'package:pad_lampung/presentation/bloc/park/home/park_home_bloc.dart';
import 'package:pad_lampung/presentation/bloc/park/paging/parking_paging_bloc.dart';
import 'package:pad_lampung/presentation/bloc/setting/setting_bloc.dart';
import 'package:pad_lampung/presentation/bloc/ticket/income/online/ticket_income_online_bloc.dart';
import 'package:pad_lampung/presentation/bloc/ticket/online/ticket_online_bloc.dart';

import '../presentation/bloc/park/detail/parking_detail_bloc.dart';
import '../presentation/bloc/park/park_bloc.dart';
import '../presentation/bloc/starter/starter_bloc.dart';
import '../presentation/bloc/ticket/detail/ticket_detail_bloc.dart';
import '../presentation/bloc/ticket/income/offline/ticket_income_offline_bloc.dart';
import '../presentation/bloc/ticket/paging/ticket_paging_bloc.dart';
import '../presentation/bloc/ticket/payment_status/ticket_payment_status_bloc.dart';
import '../presentation/bloc/ticket/price/ticket_price_bloc.dart';
import '../presentation/bloc/ticket/scan/ticket_scan_bloc.dart';
import '../presentation/bloc/ticket/home/ticket_home_bloc.dart';

void initBlocModule(GetIt locator) {
  //Auth
  locator.registerFactory(
          () => StarterBloc(storage: locator()));
  locator.registerFactory(
      () => LoginBloc(repository: locator(), storage: locator()));
  locator.registerFactory(
          () => SettingBloc(storage: locator()));


  locator.registerFactory(
          () => ParkBloc(repository: locator(), storage: locator()));
  locator.registerFactory(
          () => ParkingHomeBloc(repository: locator(), storage: locator()));
  locator.registerFactory(
          () => ParkingDetailBloc(repository: locator(), storage: locator()));

  locator.registerFactory(
          () => TicketHomeBloc(repository: locator(), storage: locator()));
  locator.registerFactory(
          () => TicketPriceBloc(repository: locator(), storage: locator()));
  locator.registerFactory(
          () => TicketPaymentStatusBloc(repository: locator(), storage: locator()));
  locator.registerFactory(
          () => TicketOnlineBloc(repository: locator(), storage: locator()));
  locator.registerFactory(
          () => TicketScanBloc(repository: locator(), storage: locator()));
  locator.registerFactory(
          () => TicketDetailBloc(repository: locator(), storage: locator()));
  locator.registerFactory(
          () => TicketPagingBloc(repository: locator(), storage: locator()));
  locator.registerFactory(
          () => ParkingPagingBloc(repository: locator(), storage: locator()));

  locator.registerFactory(
          () => TicketIncomeOnlineBloc(repository: locator(), storage: locator()));
  locator.registerFactory(
          () => TicketIncomeOfflineBloc(repository: locator(), storage: locator()));



}
