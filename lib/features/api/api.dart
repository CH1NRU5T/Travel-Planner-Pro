import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/user_model.dart';

class Api {
  static Future<(String?, User?)> postRequest(
      {required String url,
      Map<String, dynamic>? body,
      Map<String, String>? headers}) async {
    http.Response response;
    try {
      response = await http.post(Uri.parse(url),
          headers: headers, body: jsonEncode(body));
      if (response.statusCode == 200) {
        return (null, User.fromJson(response.body));
      } else {
        return (jsonDecode(response.body)['error'] as String, null);
      }
    } catch (e) {
      return (e.toString(), null);
    }
  }
}
