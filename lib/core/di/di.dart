import 'package:flowery_tracking_app/core/di/di.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/services.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies() async {
  // make Flutter's rootBundle available for injection
  getIt.registerLazySingleton<AssetBundle>(() => rootBundle);
  await getIt.init();
}
