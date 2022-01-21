import 'package:flutter/material.dart';
import 'package:gearup/pages/sign_in/AppSignIn.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:motion_toast/motion_toast.dart';

class AppSingUp extends StatefulWidget {
  @override
  State<AppSingUp> createState() => _AppSingUpState();
}

class _AppSingUpState extends State<AppSingUp> {
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String defaultFontFamily = 'Roboto-Light.ttf';
    double defaultFontSize = 14;
    double defaultIconSize = 17;

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 35, bottom: 30),
        width: double.infinity,
        height: double.infinity,
        color: Colors.white54,
        //child:ListView() and remove resizeToAvoidBottomInset
        child: Form(
          key: _formkey,
          child: ListView(
            children: <Widget>[
              Flexible(
                flex: 1,
                child: InkWell(
                  child: Container(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Icon(Icons.close),
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Flexible(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 150,
                      height: 150,
                      alignment: Alignment.center,
                      child: Image.asset("img/logo1.png"),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      validator: MultiValidator([
                        RequiredValidator(errorText: '* Required'),
                      ]),
                      showCursor: true,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                            color: Colors.green,
                          ),
                        ),
                        filled: true,
                        prefixIcon: Icon(
                          Icons.person,
                          color: Color(0xFF666666),
                          size: defaultIconSize,
                        ),
                        fillColor: Color(0xFFF2F3F5),
                        hintStyle: TextStyle(
                            color: Color(0xFF666666),
                            fontFamily: defaultFontFamily,
                            fontSize: defaultFontSize),
                        hintText: "User Name",
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      validator: MultiValidator([
                        RequiredValidator(errorText: "* Required"),
                        EmailValidator(errorText: 'Invalid Email')
                      ]),
                      showCursor: true,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                            color: Colors.green,
                          ),
                        ),
                        filled: true,
                        prefixIcon: Icon(
                          Icons.email,
                          color: Color(0xFF666666),
                          size: defaultIconSize,
                        ),
                        fillColor: Color(0xFFF2F3F5),
                        hintStyle: TextStyle(
                            color: Color(0xFF666666),
                            fontFamily: defaultFontFamily,
                            fontSize: defaultFontSize),
                        hintText: "Email",
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      validator: MultiValidator([
                        RequiredValidator(errorText: '* Required'),
                        MinLengthValidator(6,
                            errorText: 'Should be atleast 6 characters'),
                      ]),
                      showCursor: true,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                            color: Colors.green,
                          ),
                        ),
                        filled: true,
                        prefixIcon: Icon(
                          Icons.remove_red_eye,
                          color: Color(0xFF666666),
                          size: defaultIconSize,
                        ),
                        fillColor: Color(0xFFF2F3F5),
                        hintStyle: TextStyle(
                          color: Color(0xFF666666),
                          fontFamily: defaultFontFamily,
                          fontSize: defaultFontSize,
                        ),
                        hintText: "Password",
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        child: Text('Sign Up'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(17.0),
                          primary: Colors.green.shade600,
                          onPrimary: Colors.white,
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontStyle: FontStyle.normal),
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(15.0),
                              side: BorderSide(color: Colors.green)),
                        ),
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            _formkey.currentState!.save();
                            // Fluttertoast.showToast(
                            //     msg: "Successfull", backgroundColor: Colors.green);
                            MotionToast.success(
                              description: Text("Data saved Successfully"),
                              title: Text('Success'),
                              toastDuration: Duration(seconds: 3),
                            ).show(context);
                          } else {
                            // Fluttertoast.showToast(
                            //     msg: "Unsuccessfull", backgroundColor: Colors.red);
                            MotionToast.error(
                              description: Text("Unsuccessfull"),
                              title: Text('error'),
                            ).show(context);
                          }
                        },
                      ),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xFFF2F3F7)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "Already have an account? ",
                          style: TextStyle(
                            color: Color(0xFF666666),
                            fontFamily: defaultFontFamily,
                            fontSize: defaultFontSize,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AppSignIn()),
                          );
                        },
                        child: Container(
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                              color: Colors.green.shade600,
                              fontFamily: defaultFontFamily,
                              fontSize: defaultFontSize,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
