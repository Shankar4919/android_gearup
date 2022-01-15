import 'package:flutter/material.dart';

class Contact extends StatelessWidget {
  const Contact({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        child: Center(
          child: Text("Hello User", style: TextStyle(fontSize: 20),),
        ),
      )
      
    );
  }
}