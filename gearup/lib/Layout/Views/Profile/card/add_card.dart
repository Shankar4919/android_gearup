import 'package:e_commers/Layout/themes/colors_gearUp.dart';
import 'package:e_commers/Layout/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AddCreditCardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: const TextGearUp(
              text: 'Add Cards',
              color: ColorsGearUp.greenColor,
              fontWeight: FontWeight.w600),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            splashRadius: 20,
            icon: const Icon(Icons.arrow_back_ios_rounded,
                color: ColorsGearUp.greenColor),
            onPressed: () => Navigator.of(context).pop(),
          )),
      body: Center(
        child: const Text(
          'GearUp: Football Store',
        ),
      ),
    );
  }
}
