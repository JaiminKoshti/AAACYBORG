class ApiEndPoints{
  static const String baseUrl = 'https://sangita-app.jeelinfotech.com/api';
  static _AuthEndPoints authEndPoints = _AuthEndPoints();
}

class _AuthEndPoints{
  final String registerEmail = '/register';
  final String loginEmail = '/login';
  final String logoutEmail = '/logout';
  final String forgetpassword = '/forgetpassword';
}