import 'package:flutter/material.dart';
import 'package:e_commers/Layout/Views/Login/login_page.dart';
import 'package:e_commers/Layout/Views/Login/loading_page.dart';
import 'package:e_commers/Layout/Views/Login/register_page.dart';
import 'package:e_commers/Layout/Views/Start/start_home_page.dart';

Map<String, Widget Function(BuildContext context)> routes = {
  'loadingPage': (context) => LoadingPage(),
  'getStarted': (context) => StartHomePage(),
  'signInPage': (context) => SignInPage(),
  'signUpPage': (context) => SignUpPage(),
  // 'homePage': (context) => HomePage(),
  // 'cartPage': ( context ) => CartPage(),
  // 'favoritePage': ( context ) => FavoritePage(),
  // 'profilePage' : ( context ) => ProfilePage(),
  // 'notification': (context) => notification();
};
