import 'package:flutter/widgets.dart';

enum AuthStatus { idle, loading, success, error }

class BaseProvider extends ChangeNotifier {
  AuthStatus _status = AuthStatus.idle;
  AuthStatus get status => _status;

  void setLoading(AuthStatus status) {
    _status = status;
    notifyListeners();
  }
}
