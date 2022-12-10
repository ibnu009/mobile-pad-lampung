import 'package:get_it/get_it.dart';
import '../core/data/sources/remote/auth_remote_data_source.dart';
import '../core/data/sources/remote/park_remote_data_source.dart';
import '../core/data/sources/remote/ticket_remote_data_source.dart';

void initDataSourceModule(GetIt locator) {
  locator.registerLazySingleton<AuthRemoteDataSourceImpl>(
      () => AuthRemoteDataSourceImpl());
  locator.registerLazySingleton<ParkRemoteDataSourceImpl>(
          () => ParkRemoteDataSourceImpl());
  locator.registerLazySingleton<TicketRemoteDataSourceImpl>(
          () => TicketRemoteDataSourceImpl());
}
