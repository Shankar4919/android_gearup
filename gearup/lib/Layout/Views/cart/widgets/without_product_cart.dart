import 'package:e_commers/Bloc/product/product_bloc.dart';
import 'package:e_commers/Accessory/helpers.dart';
import 'package:e_commers/Layout/Views/Home/home_page.dart';
import 'package:e_commers/Layout/themes/colors_gearUp.dart';
import 'package:e_commers/Layout/widgets/shimmer_gearup.dart';
import 'package:e_commers/Layout/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WithoutProductsCart extends StatelessWidget {
  const WithoutProductsCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
        builder: (_, state) => state.products != null
            ? state.products!.length != 0
                ? SizedBox(
                    height: 290,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_bag_outlined,
                            size: 90,
                            color: ColorsGearUp.greenColor.withOpacity(.7)),
                        const SizedBox(height: 20),
                        const TextGearUp(
                            text: 'There is a cart to fill!',
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                        const SizedBox(height: 20),
                        const TextGearUp(
                            text: 'Currently do not have ', fontSize: 16),
                        const SizedBox(height: 5),
                        const TextGearUp(
                            text: 'any products in your shopping cart',
                            fontSize: 16),
                        const SizedBox(height: 40),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextButton(
                            style: ButtonStyle(
                                side: MaterialStateProperty.all(
                                    BorderSide(color: Colors.blue)),
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.symmetric(
                                        horizontal: 40, vertical: 10))),
                            child: const TextGearUp(
                                text: 'Go Products', fontSize: 19),
                            onPressed: () => Navigator.of(context)
                                .pushAndRemoveUntil(
                                    routeSlide(page: HomePage()), (_) => false),
                          ),
                        )
                      ],
                    ))
                : const SizedBox()
            : const ShimmerFrave());
  }
}
