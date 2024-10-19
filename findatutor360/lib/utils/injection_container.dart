import 'package:findatutor360/core/services/auth/auth_services.dart';
import 'package:findatutor360/core/services/main/book_service.dart';
import 'package:findatutor360/core/services/main/course_service.dart';
import 'package:findatutor360/core/services/main/message_service.dart';
import 'package:findatutor360/core/services/main/theme.service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;
void setupLocator() {
  locator.registerLazySingleton(
    () => AuthServiceImpl(),
  );
  locator.registerLazySingleton(
    () => ThemeServiceImpl(),
  );
  locator.registerLazySingleton(
    () => MessageServiceImpl(),
  );
  locator.registerLazySingleton(
    () => BooksServiceImpl(),
  );
  locator.registerLazySingleton(
    () => CoursesServiceImpl(),
  );
}
