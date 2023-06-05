import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// google login
class GoogleAccountProvider extends ChangeNotifier {
  GoogleSignInAccount? _user;

  GoogleSignInAccount? get user => _user;

  void setUser(GoogleSignInAccount? user) {
    _user = user;
    notifyListeners();
  }
}

///user info
class UserProvider extends ChangeNotifier {
  String? user;

  ///mail
  void setUser(String value) {
    user = value;
    notifyListeners();
  }

  ///logout
  void logout() {
    user = null;
    notifyListeners();
  }
}
