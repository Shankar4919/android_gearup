part of 'helpers.dart';

void modalLoading(BuildContext context, String text) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black45,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      content: SizedBox(
        height: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                TextGearUp(
                    text: 'Gear ',
                    color: ColorsGearUp.greenColor,
                    fontWeight: FontWeight.w500),
                TextGearUp(text: 'Up', fontWeight: FontWeight.w500),
              ],
            ),
            const Divider(),
            const SizedBox(height: 10.0),
            Row(
              children: [
                const CircularProgressIndicator(color: ColorsGearUp.greenColor),
                const SizedBox(width: 15.0),
                TextGearUp(text: text)
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
