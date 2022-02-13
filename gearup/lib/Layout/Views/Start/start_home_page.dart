import 'package:e_commers/Layout/widgets/widgets.dart';
import 'package:flutter/material.dart';

class StartHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xff16b13a),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 180,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/bicycle.png')))),
                      SizedBox(height: 15.0),
                      TextGearUp(
                          text: 'GearUp',
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      TextGearUp(
                          text: 'Quality Boost Confidence',
                          fontSize: 20,
                          color: Colors.white70),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      BtnGearUp(
                          text: 'Sign In',
                          colorText: Colors.white,
                          backgroundColor: Color(0xff000000),
                          onPressed: () =>
                              Navigator.of(context).pushNamed('signInPage'),
                          width: size.width),
                      SizedBox(height: 15.0),
                      BtnGearUp(
                          text: 'Create New Account',
                          colorText: Colors.black87,
                          fontSize: 19,
                          backgroundColor: Color(0xFFFFFFFF),
                          onPressed: () =>
                              Navigator.of(context).pushNamed('signUpPage'),
                          width: size.width),
                      SizedBox(height: 10.0),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
