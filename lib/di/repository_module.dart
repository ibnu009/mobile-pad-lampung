import 'package:get_it/get_it.dart';
import 'package:pad_lampung/core/data/repositories/auth_repository.dart';
import 'package:pad_lampung/core/data/sources/shared_preferences.dart';

import '../core/data/repositories/park_repository.dart';

void initRepositoryModule(GetIt locator) {
  //preferences
  locator.registerLazySingleton<AppPreferences>(
    () => AppPreferences(locator()),
  );

  //repositories
  locator.registerLazySingleton<AuthRepository>(() => AuthRepository(locator()));
  locator.registerLazySingleton<ParkRepository>(() => ParkRepository(locator()));

}
