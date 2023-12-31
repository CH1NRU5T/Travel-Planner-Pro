import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  static Future<(String?, Map<String, dynamic>?)> postRequest(
      {required String url,
      Map<String, dynamic>? body,
      Map<String, String>? headers}) async {
    http.Response response;
    try {
      response = await http.post(Uri.parse(url),
          headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        return (null, jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        return (jsonDecode(response.body).toString(), null);
      }
    } catch (e) {
      return (e.toString(), null);
    }
  }

  static Future<(String?, dynamic)> getRequest(
      {required String url, Map<String, String>? headers}) async {
    http.Response response;
    try {
      response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        return (null, jsonDecode(response.body));
      } else {
        return (jsonDecode(response.body)['error'] as String, null);
      }
    } catch (e) {
      return (e.toString(), null);
    }
  }
}
