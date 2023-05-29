import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

/*class BaseClient {
  static const int TIME_OUT_DURATION = 20;

  ///GET
  *//*Future<dynamic> get(String baseUrl, String api) async {
    var uri = Uri.parse(baseUrl + api);
    try {
      var response = await http.get(uri).timeout(Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No InterNet connection ' , uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time ' , uri.toString());
    }
  }*//*

  ///POST

  Future<dynamic> post(String baseUrl, String api , dynamic payloadObj ) async {
    var uri = Uri.parse(baseUrl + api);
    var payload = json.decode(payloadObj);
    try {
      var response = await http.post(uri , body: payload).timeout(Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No InterNet connection ' , uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time ' , uri.toString());
    }
  }
  ///DELETE

  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
        break;
      case 201:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
        break;
      case 400:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 401:
      case 403:
        throw UnAuthorizedException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 422:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured with code : ${response.statusCode}',
            response.request!.url.toString());
    }
  }
}*/

const String baseUrl = 'https://cnt.hiredeveloper.today';

class BaseClient {
  var client = http.Client();

  static Future<Map<String, dynamic>?> loginWithApi(String email,String password  ,String message) async{
    var api = "api/login";
    var url = Uri.parse(baseUrl + api);
    final response = await http.post(url);
    if(response.statusCode == 200){
      var responseData = jsonDecode(response.body);
      var message = responseData['message'];
      var status = responseData['status'];
    }
    return null;
  }

  ///GET
  Future<dynamic> get(String api) async {
    var url = Uri.parse(baseUrl + api);
    var _headers = {
      'Authorization': 'Bearer sfie328370428387=',
      'api_key': 'ief873fj38uf38uf83u839898989',
    };

    var response = await client.get(url, headers: _headers);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      //throw exception and catch it in UI
    }
  }

  ///post
  Future<dynamic> post(String api, dynamic object) async {
    var url = Uri.parse(baseUrl + api);
    var _payload = json.encode(object);
    var _headers = {
      'Authorization': 'Bearer sfie328370428387=',
      'Content-Type': 'application/json',
      'api_key': 'ief873fj38uf38uf83u839898989',
    };

    var response = await client.post(url, body: _payload, headers: _headers);
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      var message = responseData['message'];
      var status = responseData['status'];
      return response.body;
    } else {
      //throw exception and catch it in UI
    }
  }

  static Future<Map<String, dynamic>?> fetchLoginDetails(String response) async {
    final baseUrl = 'https://cnt.hiredeveloper.today';
    final endpoint = '/api/login';

    final url = Uri.parse(baseUrl + endpoint);

    try {
      final response = await http.get(url);

      if (response.statusCode == "200") {
        final jsonResponse = json.decode(response.body);
        return jsonResponse;
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('An error occurred: $error');
    }

    return null;
  }

  ///PUT Request
  Future<dynamic> put(String api, dynamic object) async {
    var url = Uri.parse(baseUrl + api);
    var _payload = json.encode(object);
    var _headers = {
      'Authorization': 'Bearer sfie328370428387=',
      'Content-Type': 'application/json',
      'api_key': 'ief873fj38uf38uf83u839898989',
    };

    var response = await client.put(url, body: _payload, headers: _headers);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      //throw exception and catch it in UI
    }
  }

  ///delete
  Future<dynamic> delete(String api) async {
    var url = Uri.parse(baseUrl + api);
    var _headers = {
      'Authorization': 'Bearer sfie328370428387=',
      'api_key': 'ief873fj38uf38uf83u839898989',
    };

    var response = await client.delete(url, headers: _headers);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      //throw exception and catch it in UI
    }
  }
}
