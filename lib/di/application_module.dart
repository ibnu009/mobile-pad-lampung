import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'bloc_module.dart';
import 'data_source_module.dart';
import 'repository_module.dart';

final locator = GetIt.instance;

Future<void> init() async {
  initDataSourceModule(locator);
  initRepositoryModule(locator);
  initBlocModule(locator);

  // helper
  locator.registerLazySingleton<FlutterSecureStorage>(() => const FlutterSecureStorage());
}