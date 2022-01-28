import 'dart:convert';

import 'package:gearup/model/user.dart';
import 'package:gearup/response/userResponse.dart';
import 'package:http/http.dart';

class HttpConnectUser {
  String baseurl = 'http://192.168.1.101:3005/api/v1';
  String token = '';

  //sending data to the server--- creating user
  Future<bool> registerPost(User user) async {
    Map<String, dynamic> userMap = {
      "name": user.name,
      "email": user.email,
      "password": user.password,
    };

    final response =
        await post(Uri.parse(baseurl + '/register'), body: userMap);
        if (response.statusCode == 200) {
          var usrRes = ResponseUser.fromJson(jsonDecode(response.body));
          return usrRes.success!;
        } else {
          return false;
        }
  }

  //sending data to the server- login as user
  Future<bool> loginPosts(String email, String password) async {
    Map<String, dynamic> login = {'email': email, 'password': password};

    try {
      final response = await post(
          Uri.parse(
            baseurl + "/login",
          ),
          body: login);

      //json serializing inline
      final jsonData = jsonDecode(response.body) as Map;
      // bool val = jsonData['sucess'];
      // print(jsonData['token']);
      token = jsonData['token'];
//merotoken = jsonData['token'];

      if (token.isNotEmpty) {
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
}
