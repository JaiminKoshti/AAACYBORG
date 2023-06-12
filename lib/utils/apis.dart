class ApiEndPoints{
  static const String baseUrl = 'https://sangita-app.jeelinfotech.com';
  static _AuthEndPoints authEndPoints = _AuthEndPoints();
}

class _AuthEndPoints{
  final String registerEmail = '/api/register';
  final String loginEmail = '/api/login';
  final String logoutEmail = '/api/logout';
  final String forgetpassword = '/api/forgetpassword';
  final String getCampaign = '/api/getCampaign';
  final String privacy = '/api/privacy';
  final String profile = '/api/profile';
  final String inquiry = '/api/inquiry';
  final String getPlans = '/api/getPlans';
  final String purchasePlan = '/api/purchasePlan';
  final String watchvideo = '/api/watchvideo';
  final String sendRequestVIP = '/api/sendRequestVIP';
  final String addCampaign = '/api/addCampaign';
}