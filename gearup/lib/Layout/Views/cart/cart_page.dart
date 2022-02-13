import 'package:e_commers/Accessory/helpers.dart';
import 'package:e_commers/Layout/Views/cart/checkout_page.dart';
import 'package:e_commers/Layout/Views/cart/widgets/details_product_cart.dart';
import 'package:e_commers/Layout/Views/cart/widgets/without_product_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commers/Layout/widgets/widgets.dart';
import 'package:e_commers/Bloc/product/product_bloc.dart';
import 'widgets/app_bar_cart.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final productBloc = BlocProvider.of<ProductBloc>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          _ListProductsCard(),
          Positioned(
            bottom: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              height: 133,
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0)),
                // boxShadow: [
                //   BoxShadow(
                //       color: Colors.grey[300]!, blurRadius: 10, spreadRadius: 5)
                // ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const TextGearUp(
                            text: 'Total',
                            fontSize: 23,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                        BlocBuilder<ProductBloc, ProductState>(
                          builder: (context, state) => TextGearUp(
                              text: '\$ ${state.total.toStringAsFixed(2)}',
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff0C6CF2)),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 18.0),
                  BtnFrave(
                    text: 'Checkout',
                    fontSize: 22,
                    width: size.width,
                    height: 56,
                    border: 15,
                    onPressed: () {
                      if (productBloc.product.isNotEmpty) {
                        Navigator.push(
                            context, routeSlide(page: CheckOutPage()));
                      }
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _ListProductsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productBloc = BlocProvider.of<ProductBloc>(context);

    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 15.0),
          const AppBarCart(),
          const SizedBox(height: 20.0),
          productBloc.product.isEmpty
              ? const WithoutProductsCart()
              : DetailsProductsCart()
        ],
      ),
    );
  }
}
