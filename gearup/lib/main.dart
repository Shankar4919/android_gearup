import 'package:e_commers/Bloc/cart/cart_bloc.dart';
import 'package:e_commers/Bloc/category/category_bloc.dart';
import 'package:e_commers/Bloc/product/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commers/Bloc/user/user_bloc.dart';
import 'package:e_commers/Bloc/auth/auth_bloc.dart';
import 'package:e_commers/Bloc/General/general_bloc.dart';
import 'package:e_commers/Routes/Routes.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark )
    );
      
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()..add( CheckLoginEvent() )),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GearUp: Football Store',
        initialRoute: 'loadingPage',
        routes: routes,
      ),
    );
  }
}