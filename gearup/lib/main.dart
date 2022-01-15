import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearup/blocs/auth/auth_bloc.dart';
import 'package:gearup/blocs/auth/auth_state.dart';
import 'package:gearup/pages/login/LoginUi.dart';
import 'package:gearup/pages/login/get_contacts.dart';
import 'package:gearup/pages/login/post_contacts.dart';
import 'package:gearup/pages/navpages/main_page.dart';
import 'package:gearup/pages/welcome_page.dart';
import 'package:gearup/repository/auth_repo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(

      providers: [
        BlocProvider(create: (context) => AuthBloc(LoginInitState(), AuthRepository()))
      ],
      
      child: MaterialApp(
        title: 'GearUp',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        
        initialRoute: '/',
        routes: {
          '/': (context)=>LoginUi(),
          '/contacts':(context)=>Contact(),
          '/addContact': (context)=>AddContacts()
    
        },
        // home:MainPage()
      ),
    );
  }
}