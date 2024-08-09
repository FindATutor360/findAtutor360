import 'package:findatutor360/core/view_models/auth/auth_controller.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class AppProviders {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider<AuthController>(
      create: (_) => AuthController(),
    ),
  ];
}
