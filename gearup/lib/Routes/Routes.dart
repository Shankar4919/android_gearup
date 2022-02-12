import 'package:flutter/material.dart';
import 'package:e_commers/Layout/Views/Login/login_page.dart';
import 'package:e_commers/Layout/Views/Login/loading_page.dart';
import 'package:e_commers/Layout/Views/Login/register_page.dart';


Map<String, Widget Function(BuildContext context)> routes = {

  'signInPage': (context) => SignInPage(),
  'signUpPage': (context) => SignUpPage(),
};
