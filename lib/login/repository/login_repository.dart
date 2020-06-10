import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:ceria/ceria_core.dart';

class LoginRepository {
  Future<bool> login(String phone, String password) async {
    var uri =
        Uri.https(CeriaCore.instance.restApiBaseUrl, '/api/courier/login');

    try {
      final response = await http.Client()
          .post(uri,
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(<String, String>{
                'phone': phone,
                'password': password,
              }))
          .timeout(const Duration(seconds: 25));
      http.Client().close();

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on TimeoutException catch (_) {
      return false;
    } on SocketException catch (_) {
      return false;
    }
  }
}
