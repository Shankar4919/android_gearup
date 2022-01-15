import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthRepository {
  login(String email, String password) async {
    var res = await http.post(
      Uri.parse("http://localhost:3005/api/v1/login"),
      headers: {},
      body: {"email": email, "password": password},
    );

    final data = json.decode(res.body);

    if (data['success'] == true) {
      return data;
    } else {
      return 'auth problem';
    }
  }
}
