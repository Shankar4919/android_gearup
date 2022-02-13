part of 'helpers.dart';

void modalSuccess(BuildContext context, String text,
    {required VoidCallback onPressed}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black87,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        content: SizedBox(
          height: 250,
          child: Column(
            children: [
              Row(
                children: const [
                  TextGearUp(
                      text: 'Gear',
                      color: ColorsGearUp.greenColor,
                      fontWeight: FontWeight.w500),
                  TextGearUp(text: 'Up', fontWeight: FontWeight.w500),
                ],
              ),
              const Divider(),
              const SizedBox(height: 10.0),
              Container(
                  height: 90,
                  width: 90,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          colors: [Colors.white, ColorsGearUp.greenColor])),
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                    child:
                        const Icon(Icons.check, color: Colors.white, size: 38),
                  )),
              const SizedBox(height: 35.0),
              TextGearUp(text: text, fontSize: 17, fontWeight: FontWeight.w400),
              const SizedBox(height: 20.0),
              InkWell(
                onTap: onPressed,
                child: Container(
                  alignment: Alignment.center,
                  height: 35,
                  width: 150,
                  decoration: BoxDecoration(
                      color: ColorsGearUp.greenColor,
                      borderRadius: BorderRadius.circular(5.0)),
                  child: const TextGearUp(
                      text: 'Done', color: Colors.white, fontSize: 17),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
