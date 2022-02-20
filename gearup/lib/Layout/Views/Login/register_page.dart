import 'package:e_commers/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commers/Bloc/user/user_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:e_commers/Accessory/helpers.dart';
import 'package:e_commers/Accessory/validation_form.dart';
import 'package:e_commers/Layout/Views/Login/login_page.dart';
import 'package:e_commers/Layout/themes/colors_gearUp.dart';
import 'package:e_commers/Layout/widgets/widgets.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late TextEditingController userController;
  late TextEditingController emailController;
  late TextEditingController passowrdController;
  late TextEditingController passController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    userController = TextEditingController();
    emailController = TextEditingController();
    passowrdController = TextEditingController();
    passController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    clear();
    userController.dispose();
    emailController.dispose();
    passowrdController.dispose();
    passController.dispose();
    super.dispose();
  }

  void clear() {
    userController.clear();
    emailController.clear();
    passowrdController.clear();
    passController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);
    final size = MediaQuery.of(context).size;

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is LoadingUserState) {
          modalLoading(context, 'Validating...');
        }
        if (state is SuccessUserState) {
          Navigator.of(context).pop();
          modalSuccess(context, 'USER CREATED', onPressed: () {
            clear();
            Navigator.pushReplacement(context, routeSlide(page: SignInPage()));
          });
        }
        if (state is FailureUserState) {
          Navigator.of(context).pop();
          errorMessageSnack(context, state.error);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          leading: IconButton(
            splashRadius: 20,
            icon: const Icon(
              Icons.close_rounded,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            TextButton(
              child: const TextGearUp(
                  text: 'Log In', fontSize: 17, color: ColorsGearUp.greenColor),
              onPressed: () =>
                  Navigator.of(context).pushReplacementNamed('signInPage'),
            ),
            SizedBox(width: 5)
          ],
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            physics: BouncingScrollPhysics(),
            children: [
              TextGearUp(
                  text: 'Welcome to GearUp ',
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
              SizedBox(height: 5.0),
              TextGearUp(
                  text: 'Create Account', fontSize: 17, color: Colors.white),
              SizedBox(height: 20.0),
              TextFormGearUp(
                hintText: 'Username',
                prefixIcon: Icon(Icons.person, color: Colors.black),
                controller: userController,
                validator: RequiredValidator(errorText: 'Username is required'),
              ),
              SizedBox(height: 15.0),
              TextFormGearUp(
                  hintText: 'Email Address',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icon(Icons.email_outlined, color: Colors.black),
                  controller: emailController,
                  validator: validatedEmail),
              SizedBox(height: 15.0),
              TextFormGearUp(
                hintText: 'Password',
                prefixIcon: Icon(Icons.lock, color: Colors.black),
                isPassword: true,
                controller: passowrdController,
                validator: passwordValidator,
              ),
              SizedBox(height: 15.0),
              TextFormGearUp(
                  hintText: 'Confirm Password',
                  controller: passController,
                  prefixIcon: Icon(Icons.lock, color: Colors.black),
                  isPassword: true,
                  validator: (val) =>
                      MatchValidator(errorText: 'Password do not macth ')
                          .validateMatch(val!, passowrdController.text)),
              SizedBox(height: 25.0),
              Row(
                children: const [
                  Icon(Icons.check_circle_rounded, color: Color(0xff16b13a)),
                  TextGearUp(
                    text: ' I Agree to GearUp ',
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                  TextGearUp(
                    text: ' Terms of Use',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ],
              ),
              SizedBox(height: 25.0),
              BtnGearUp(
                text: 'Sign Up',
                width: size.width,
                fontSize: 20,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    registerNotify();
                    userBloc.add(OnAddNewUser(
                        userController.text.trim(),
                        emailController.text.trim(),
                        passowrdController.text.trim()));
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
