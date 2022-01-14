import 'package:flutter/material.dart';
import 'package:gearup/misc/colors.dart';
import 'package:gearup/widgets/app_large_text.dart';
import 'package:gearup/widgets/app_text.dart';
import 'package:gearup/widgets/responsive_button.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  List images = [
    "gearupLanding.png",
    "gearupLanding2.png",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: images.length,
        itemBuilder: (_, index) {
          return Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "img/" + images[index],
                  ),
                  fit: BoxFit.cover),
            ),
            child: Container(
              margin: const EdgeInsets.only(top: 100, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppLargeText(text: "GearUp"),
                      AppText(
                        text: "Online Football Store",
                        size: 30,
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: 250,
                        child: AppText(
                          text: "Quality boost your confidence",
                          color: AppColors.textColor2,
                          size: 14,
                        ),
                      ),
                      SizedBox(height: 40),
                      ResponsiveButton(
                        width: 120,
                      )
                    ],
                  ),
                  Column(
                    children: List.generate(2, (indexDots) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 4),
                        width: 8,
                        height: index==indexDots?25:8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color:index==indexDots?AppColors.mainColorSecond:AppColors.mainColorSecond.withOpacity(0.3)),
                      );
                    }),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
