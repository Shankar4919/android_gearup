import 'package:e_commers/Bloc/Auth/auth_bloc.dart';
import 'package:e_commers/Bloc/user/user_bloc.dart';
import 'package:e_commers/Accessory/validation_form.dart';
import 'package:e_commers/Layout/Views/Home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:e_commers/Accessory/helpers.dart';
import 'package:e_commers/Layout/Views/Login/loading_page.dart';
import 'package:e_commers/Layout/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late TextEditingController _emailController;
  late TextEditingController _passowrdController;
  final _keyForm = GlobalKey<FormState>();
  bool isChangeSuffixIcon = true;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passowrdController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.clear();
    _emailController.dispose();
    _passowrdController.clear();
    _passowrdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final userBloc = BlocProvider.of<UserBloc>(context);
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoadingAuthState) {
          modalLoading(context, 'Checking...');
        } else if (state is FailureAuthState) {
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        } else if (state is SuccessAuthState) {
          Navigator.pop(context);
          userBloc.add(OnGetUserEvent());
          Navigator.pushAndRemoveUntil(
              context, routeSlide(page: HomePage()), (_) => false);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            splashRadius: 20,
            icon: Icon(Icons.close_rounded, size: 25, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            TextButton(
              child: TextGearUp(
                text: 'Register',
                fontSize: 18,
                color: Color(0xff16b13a),
              ),
              onPressed: () =>
                  Navigator.of(context).pushReplacementNamed('signUpPage'),
            )
          ],
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: SafeArea(
          child: Form(
            key: _keyForm,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              physics: BouncingScrollPhysics(),
              children: [
                const SizedBox(height: 20),
                const TextGearUp(
                    text: 'Welcome',
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff16b13a)),
                const SizedBox(height: 5),
                const TextGearUp(text: 'Sign In to your account', fontSize: 18),
                const SizedBox(height: 35),
                TextFormGearUp(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: validatedEmail,
                  hintText: 'Enter your Email',
                  prefixIcon: Icon(Icons.alternate_email_rounded),
                ),
                const SizedBox(height: 20),
                TextFormGearUp(
                  controller: _passowrdController,
                  isPassword: isChangeSuffixIcon,
                  hintText: 'Enter your password',
                  prefixIcon: Icon(Icons.lock),
                  validator: passwordValidator,
                ),
                const SizedBox(height: 40),
                BtnFrave(
                  text: 'Sign In',
                  width: size.width,
                  fontSize: 20,
                  onPressed: () {
                    if (_keyForm.currentState!.validate()) {
                      authBloc.add(LoginEvent(_emailController.text.trim(),
                          _passowrdController.text.trim()));
                    }
                  },
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                      child: TextGearUp(
                          text: 'Forgot password?',
                          color: Colors.black,
                          fontSize: 17),
                      onPressed: () => Navigator.push(
                          context, routeSlide(page: LoadingPage()))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
