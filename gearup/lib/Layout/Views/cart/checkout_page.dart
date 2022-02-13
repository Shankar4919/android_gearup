import 'package:e_commers/Bloc/product/product_bloc.dart';
import 'package:e_commers/Accessory/helpers.dart';
import 'package:e_commers/Layout/Views/Home/home_page.dart';
import 'package:e_commers/Layout/Views/cart/widgets/order_details.dart';
import 'package:e_commers/Layout/Views/cart/widgets/payment_credit_cart.dart';
import 'package:e_commers/Layout/Views/cart/widgets/street_address.dart';
import 'package:e_commers/Layout/themes/colors_gearUp.dart';
import 'package:e_commers/Layout/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckOutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // new StripeService()
    //   ..init();

    final productBloc = BlocProvider.of<ProductBloc>(context);
    final size = MediaQuery.of(context).size;

    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is LoadingProductState) {
          modalLoading(context, 'Checking...');
        } else if (state is FailureProductState) {
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        } else if (state is SuccessProductState) {
          Navigator.pop(context);
          modalSuccess(context, 'Successfully paid', onPressed: () {
            productBloc.add(OnClearProductsEvent());
            Navigator.pushAndRemoveUntil(
                context, routeFade(page: HomePage()), (_) => false);
          });
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const TextGearUp(
              text: 'Checkout',
              color: Colors.white,
              fontSize: 21,
              fontWeight: FontWeight.bold),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            splashRadius: 20,
            icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: ListView(
          children: [
            const StreetAddressCheckout(),
            const PaymentCreditCart(),
            Container(
              margin: const EdgeInsets.only(top: 10.0),
              padding: const EdgeInsets.all(15.0),
              height: 100,
              color: Color(0xff2b2c2c),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  TextGearUp(
                      text: 'Delivery Status',
                      fontSize: 19,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                  Divider(),
                  TextGearUp(
                    text: 'Delivery Within 2-3 Days',
                    fontSize: 18,
                    color: ColorsGearUp.greenColor,
                  ),
                ],
              ),
            ),
            const OrderDetails(),
            Container(
              margin: const EdgeInsets.only(top: 10),
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              height: 60,
              color: Color(0xff2b2c2c),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextGearUp(
                    text: 'Total',
                    fontSize: 19,
                    color: Colors.white,
                  ),
                  TextGearUp(
                    text: '\Rs. ${productBloc.state.total}',
                    fontSize: 19,
                    color: Colors.blue,
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15.0),
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              alignment: Alignment.bottomCenter,
              child: BtnGearUp(
                text: 'Pay',
                height: 55,
                fontSize: 22,
                width: size.width,
                onPressed: () {
                  // cartBloc.add( OnMakePayment(amount: '${ (productBloc.state.total * 100 ).floor() }', creditCardFrave: cartBloc.state.creditCardFrave ) );
                  productBloc.add(OnSaveProductsBuyToDatabaseEvent(
                      '${productBloc.state.total}', productBloc.product));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
