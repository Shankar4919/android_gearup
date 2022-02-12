import 'package:animate_do/animate_do.dart';
import 'package:e_commers/Bloc/product/product_bloc.dart';
import 'package:e_commers/Bloc/user/user_bloc.dart';
import 'package:e_commers/Accessory/helpers.dart';
import 'package:e_commers/Service/urls.dart';
import 'package:e_commers/Layout/Views/cart/cart_page.dart';
import 'package:e_commers/Layout/themes/colors_gearUp.dart';
import 'package:e_commers/Layout/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HeaderHome extends StatelessWidget {
  const HeaderHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(color: Colors.black38, blurRadius: 10, spreadRadius: -5)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FadeInLeft(
            child: BlocBuilder<UserBloc, UserState>(
                buildWhen: (previous, current) => previous != current,
                builder: (context, state) => state.user != null
                    ? Row(
                        children: [
                          state.user!.image != ''
                              ? CircleAvatar(
                                  radius: 20,
                                  backgroundImage: NetworkImage(
                                      URLS.baseUrl + state.user!.image),
                                )
                              : CircleAvatar(
                                  radius: 20,
                                  backgroundColor: ColorsGearUp.greenColor,
                                  child: TextGearUp(
                                    text: state.user!.users
                                        .substring(0, 2)
                                        .toUpperCase(),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                          const SizedBox(width: 5.0),
                          TextGearUp(
                            text: state.user!.users,
                            fontSize: 18,
                          )
                        ],
                      )
                    : const SizedBox()),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(20.0),
            onTap: () => Navigator.of(context)
                .pushAndRemoveUntil(routeSlide(page: CartPage()), (_) => false),
            child: Stack(
              children: [
                FadeInRight(
                    child: Container(
                        height: 32,
                        width: 32,
                        child: SvgPicture.asset('assets/bolso-negro.svg',
                            height: 25))),
                Positioned(
                  left: 0,
                  top: 12,
                  child: FadeInDown(
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          color: ColorsGearUp.greenColor,
                          shape: BoxShape.circle),
                      child: Center(
                          child: BlocBuilder<ProductBloc, ProductState>(
                              builder: (context, state) => state.amount == 0
                                  ? TextGearUp(
                                      text: '0',
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)
                                  : TextGearUp(
                                      text: '${state.products!.length}',
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
