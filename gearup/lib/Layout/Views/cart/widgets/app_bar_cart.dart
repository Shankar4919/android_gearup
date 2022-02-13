import 'package:e_commers/Bloc/product/product_bloc.dart';
import 'package:e_commers/Accessory/helpers.dart';
import 'package:e_commers/Layout/Views/Home/home_page.dart';
import 'package:e_commers/Layout/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBarCart extends StatelessWidget {
  const AppBarCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Color(0xff000000),
                radius: 24,
                child: InkWell(
                    onTap: () => Navigator.of(context).pushAndRemoveUntil(
                        routeSlide(page: HomePage()), (_) => false),
                    child: Icon(Icons.arrow_back_ios_rounded,
                        color: Colors.white)),
              ),
              const SizedBox(width: 20.0),
              Container(
                  child: const TextGearUp(
                text: 'My Cart',
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              )),
            ],
          ),
          Container(
              child: BlocBuilder<ProductBloc, ProductState>(
                  builder: (_, state) => state.products != null
                      ? TextGearUp(
                          text: '${state.products!.length} items',
                          fontSize: 19,
                          color: Colors.white)
                      : TextGearUp(
                          text: '0 items',
                          fontSize: 19,
                          color: Colors.white))),
        ],
      ),
    );
  }
}
