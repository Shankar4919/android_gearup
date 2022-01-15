import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearup/blocs/auth/auth_bloc.dart';
import 'package:gearup/blocs/auth/auth_events.dart';
import 'package:gearup/blocs/auth/auth_state.dart';

class LoginUi extends StatefulWidget {
  const LoginUi({Key? key}) : super(key: key);

  @override
  _UserLoginUiState createState() => _UserLoginUiState();
}

class _UserLoginUiState extends State<LoginUi> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  late AuthBloc authBloc;

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final logo = Center(
      child: Icon(
        Icons.supervised_user_circle,
        size: 150,
        color: Colors.green,
      ),
    );

    final msg = BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is LoginErrorState) {
          return Text(state.message);
        } else if (state is LoginLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Container();
        }
      },
    );

    final username = TextField(
      controller: email,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.email),
          filled: true,
          fillColor: Colors.white,
          hintStyle: TextStyle(
            color: Color(0xFF666666),
          ),
          hintText: 'Email',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(24))),
    );

    final pass = TextField(
      controller: password,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          filled: true,
          fillColor: Colors.white,
          hintStyle: TextStyle(
            color: Color(0xFF666666),
          ),
          hintText: 'Password',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(24))),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          //ToDo: Login Here
          authBloc.add(
              LoginButtonPressed(this.email.text, this.password.text));
        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text(
          'Log In',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UserLoginSuccessState) {
            Navigator.pushNamed(context, "/contacts");
          } else if (state is AdminLoginSuccessState) {
            Navigator.pushNamed(context, '/addContact');
          }
        },
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              logo,
              SizedBox(
                height: 20.0,
              ),
              msg,
              SizedBox(
                height: 48.0,
              ),
              username,
              SizedBox(
                height: 20.0,
              ),
              pass,
              SizedBox(
                height: 24.0,
              ),
              loginButton,
            ],
          ),
        ),
      ),
    );
  }
}
