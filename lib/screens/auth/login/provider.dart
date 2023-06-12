import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  bool _isLoggedIn = false;
  dynamic _accessToken;

  String get accessToken => _accessToken;

  bool get isLoggedIn => _accessToken != null;

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _accessToken = prefs.getString('accessToken')!;
    notifyListeners();
  }

  Future<void> login(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', token);
    _accessToken = token;
    notifyListeners();
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    _accessToken = null;
    notifyListeners();
  }

  /*///mail
  void setUser(String value) {
    user = value;
    notifyListeners();
  }*/
}
