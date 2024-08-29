import 'package:findatutor360/core/services/main/theme.service.dart';
import 'package:findatutor360/core/view_models/auth/auth_controller.dart';
import 'package:findatutor360/core/view_models/main/message_controller.dart';
import 'package:findatutor360/core/view_models/main/theme_controller.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class AppProviders {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider<AuthController>(
      create: (_) => AuthController(),
    ),
    ChangeNotifierProvider<ThemeController>(
      create: (_) => ThemeController(ThemeServiceImpl()),
    ),
    ChangeNotifierProvider<MessageController>(
      create: (_) => MessageController(),
    ),
  ];
}
