import 'package:findatutor360/core/services/auth/auth_services.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;
void setupLocator() {
  locator.registerLazySingleton(
    () => AuthServiceImpl(),
  );
}
