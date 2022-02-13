import 'package:e_commers/Bloc/user/user_bloc.dart';
import 'package:e_commers/Accessory/helpers.dart';
import 'package:e_commers/Layout/Views/cart/delivery_street_page.dart';
import 'package:e_commers/Layout/widgets/shimmer_gearup.dart';
import 'package:e_commers/Layout/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StreetAddressCheckout extends StatelessWidget {
  const StreetAddressCheckout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      color: Color(0xff2b2c2c),
      height: 96,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TextGearUp(
                  text: 'Shipping address',
                  fontSize: 19,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
              BlocBuilder<UserBloc, UserState>(
                  buildWhen: (previous, current) => previous != current,
                  builder: (context, state) => state.user != null
                      ? GestureDetector(
                          child: TextGearUp(
                              text:
                                  state.user!.address == '' ? 'Add' : 'Change',
                              color: Colors.blue,
                              fontSize: 18),
                          onTap: () => Navigator.push(
                              context, routeSlide(page: DeliveryPage())),
                        )
                      : const ShimmerGearUp()),
            ],
          ),
          const Divider(),
          const SizedBox(height: 5.0),
          BlocBuilder<UserBloc, UserState>(
              builder: (_, state) => state.user != null
                  ? state.user!.address == ''
                      ? const TextGearUp(
                          text: 'Without Street Address',
                          fontSize: 18,
                          color: Colors.white,
                        )
                      : TextGearUp(
                          text: '${state.user!.address}',
                          fontSize: 18,
                          color: Colors.white,
                        )
                  : const ShimmerGearUp())
        ],
      ),
    );
  }
}
