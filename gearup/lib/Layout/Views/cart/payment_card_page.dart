import 'package:e_commers/Bloc/cart/cart_bloc.dart';
import 'package:e_commers/Card_Data/ListCard.dart';
import 'package:e_commers/Models/Card/CreditCardFrave.dart';
import 'package:e_commers/Layout/themes/colors_gearUp.dart';
import 'package:flutter/material.dart';
import 'package:e_commers/Layout/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentCardPage extends StatelessWidget {
  const PaymentCardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartBloc = BlocProvider.of<CartBloc>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const TextGearUp(
            text: 'Payment',
            color: Colors.white,
            fontSize: 21,
            fontWeight: FontWeight.bold),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          splashRadius: 20,
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: TextGearUp(
                text: 'Add Card', color: ColorsGearUp.greenColor, fontSize: 17),
          )
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        itemCount: cards.length,
        itemBuilder: (_, i) {
          final CreditCard card = cards[i];

          return BlocBuilder<CartBloc, CartState>(
            builder: (context, state) => GestureDetector(
              onTap: () => cartBloc.add(OnSelectCardEvent(card)),
              child: Container(
                margin: EdgeInsets.only(bottom: 20.0),
                padding: EdgeInsets.all(10.0),
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                        color: state.creditCardFrave == null
                            ? Colors.blue
                            : state.creditCardFrave!.cvv == card.cvv
                                ? ColorsGearUp.greenColor
                                : Colors.blue)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        height: 80,
                        width: 80,
                        color: Colors.white,
                        child: SvgPicture.asset('assets/${card.brand}.svg')),
                    Container(
                        child: TextGearUp(
                            color: Colors.white,
                            text: '**** **** **** ${card.cardNumberHidden}')),
                    Container(
                        child: state.creditCardFrave == null
                            ? Icon(Icons.radio_button_off_rounded,
                                size: 31, color: Colors.white)
                            : state.creditCardFrave!.cvv == card.cvv
                                ? Icon(
                                    Icons.radio_button_checked_rounded,
                                    size: 31,
                                    color: ColorsGearUp.greenColor,
                                  )
                                : Icon(Icons.radio_button_off_rounded,
                                    size: 31))
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
