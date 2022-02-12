part of 'helpers.dart';

void errorMessageSnack(BuildContext context, String error){

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: TextGearUp(text: error, color: Colors.white), 
      backgroundColor: Colors.red
    )
  );

}