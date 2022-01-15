import 'package:flutter/material.dart';

class AddContacts extends StatelessWidget {
  const AddContacts({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        child: Center(
          child: Text("Hello Admin", style: TextStyle(fontSize: 20,),),
        ),
      )
      
    );
  }
}