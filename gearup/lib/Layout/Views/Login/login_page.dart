import 'package:e_commers/Bloc/Auth/auth_bloc.dart';
import 'package:e_commers/Bloc/user/user_bloc.dart';
import 'package:e_commers/Accessory/validation_form.dart';
import 'package:e_commers/Layout/Views/Home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:e_commers/Accessory/helpers.dart';
import 'package:e_commers/Layout/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shake/shake.dart';
// import 'package:onesignal_flutter/onesignal_flutter.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late TextEditingController _emailController;
  late TextEditingController _passowrdController;
  final _keyForm = GlobalKey<FormState>();
  bool isChangeSuffixIcon = true;

  //accelerometer

  late ShakeDetector detector;

  @override
  void initState() {
    detector = ShakeDetector.autoStart(onPhoneShake: () {
      _emailController.clear();
      _passowrdController.clear();
    });
    _emailController = TextEditingController();
    _passowrdController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    detector.stopListening();
    _emailController.clear();
    _emailController.dispose();
    _passowrdController.clear();
    _passowrdController.dispose();
    super.dispose();
  }

  // @override
  // void initState() {
  //   _emailController = TextEditingController();
  //   _passowrdController = TextEditingController();
  //   super.initState();

  //   // initPlatform();
  // }

  // @override
  // void dispose() {
  //   _emailController.clear();
  //   _emailController.dispose();
  //   _passowrdController.clear();
  //   _passowrdController.dispose();
  //   super.dispose();
  // }

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
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            splashRadius: 20,
            icon: Icon(Icons.close_rounded, size: 25, color: Colors.white),
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
                const TextGearUp(
                  text: 'Sign In to your account',
                  fontSize: 18,
                  color: Colors.white,
                ),
                const SizedBox(height: 35),
                TextFormGearUp(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: validatedEmail,
                  hintText: 'Enter your Email',
                  prefixIcon:
                      Icon(Icons.alternate_email_rounded, color: Colors.black),
                ),
                const SizedBox(height: 20),
                TextFormGearUp(
                  controller: _passowrdController,
                  isPassword: isChangeSuffixIcon,
                  hintText: 'Enter your password',
                  prefixIcon: Icon(Icons.lock, color: Colors.black),
                  validator: passwordValidator,
                ),
                const SizedBox(height: 40),
                BtnGearUp(
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Future<void> initPlatform() async {
  //   await OneSignal.shared.setAppId("");
  //   await OneSignal.shared.getDeviceState().then((value) => {
  //         print(value!.userId),
  //       });
  // }
}
