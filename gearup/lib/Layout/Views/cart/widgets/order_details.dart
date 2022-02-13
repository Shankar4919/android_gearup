import 'package:e_commers/Bloc/product/product_bloc.dart';
import 'package:e_commers/Layout/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productBloc = BlocProvider.of<ProductBloc>(context);

    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      height: 130,
      color: Color(0xff2b2c2c),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TextGearUp(
                text: 'Order',
                fontSize: 19,
                color: Colors.white,
              ),
              TextGearUp(
                text: '\Rs. ${productBloc.state.total}',
                fontSize: 19,
                color: Colors.white,
              )
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TextGearUp(
                text: 'Delivery',
                fontSize: 19,
                color: Colors.white,
              ),
              TextGearUp(
                text: '\Rs. ${productBloc.state.delivery}',
                fontSize: 19,
                color: Colors.white,
              )
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TextGearUp(
                text: 'Insurance',
                fontSize: 19,
                color: Colors.white,
              ),
              TextGearUp(
                text: '\Rs. ${productBloc.state.insurance}',
                fontSize: 19,
                color: Colors.white,
              )
            ],
          ),
        ],
      ),
    );
  }
}
