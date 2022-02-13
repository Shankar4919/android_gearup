import 'package:e_commers/Card_Data/ListCard.dart';
import 'package:e_commers/Accessory/helpers.dart';
import 'package:e_commers/Layout/Views/Profile/card/add_card.dart';
import 'package:e_commers/Layout/themes/colors_gearUp.dart';
import 'package:e_commers/Layout/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CreditCardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const TextGearUp(
            text: 'My Cards',
            color: ColorsGearUp.greenColor,
            fontWeight: FontWeight.w600),
        elevation: 0,
        leading: IconButton(
          splashRadius: 20,
          icon: const Icon(Icons.arrow_back_ios_rounded,
              color: ColorsGearUp.greenColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                const Icon(Icons.add_circle_outline_rounded,
                    color: ColorsGearUp.greenColor, size: 17),
                const SizedBox(width: 5.0),
                GestureDetector(
                  child: const TextGearUp(
                      text: 'Add Card',
                      color: ColorsGearUp.greenColor,
                      fontSize: 15),
                  onTap: () => Navigator.of(context)
                      .push(routeSlide(page: AddCreditCardPage())),
                ),
                const SizedBox(width: 7.0),
              ],
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              child: PageView.builder(
                controller: PageController(viewportFraction: .9),
                physics: const BouncingScrollPhysics(),
                itemCount: cards.length,
                itemBuilder: (_, i) {
                  final card = cards[i];

                  return _CreditCard(
                    cardHolderName: card.cardHolderName,
                    cardNumber: card.cardNumber,
                    expiryDate: card.expiracyDate,
                    cvvCode: card.cvv,
                    brand: card.brand,
                  );
                },
              ),
            ),
            const SizedBox(height: 15),
            const TextGearUp(
                text: 'Last movements', fontSize: 19, color: Colors.white),
            const SizedBox(height: 15),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xff747475),
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _CreditCard extends StatelessWidget {
  final String cardNumber;
  final String expiryDate;
  final String cardHolderName;
  final String cvvCode;
  final String brand;

  const _CreditCard(
      {required this.cardNumber,
      required this.expiryDate,
      required this.cardHolderName,
      required this.cvvCode,
      required this.brand});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      margin: const EdgeInsets.only(right: 15.0),
      height: 220,
      width: size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0), color: Color(0xFF3A4960)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('assets/card-chip.png', height: 60),
              SvgPicture.asset('assets/$brand.svg', height: 80)
            ],
          ),
          const SizedBox(height: 5.0),
          Padding(
            padding: EdgeInsets.only(left: 5.0),
            child: TextGearUp(
                text: cardNumber,
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 25.0),
          Padding(
            padding: EdgeInsets.only(left: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextGearUp(
                    text: cardHolderName, fontSize: 23, color: Colors.white),
                TextGearUp(text: expiryDate, color: Colors.white, fontSize: 19),
              ],
            ),
          )
        ],
      ),
    );
  }
}
