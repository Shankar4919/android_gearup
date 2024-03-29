import 'package:e_commers/Bloc/product/product_bloc.dart';
import 'package:e_commers/Layout/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBarProduct extends StatelessWidget {
  final String nameProduct;
  final String uidProduct;
  final int isFavorite;

  const AppBarProduct(
      {Key? key,
      required this.nameProduct,
      required this.uidProduct,
      required this.isFavorite})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productBloc = BlocProvider.of<ProductBloc>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(50.0),
          onTap: () => Navigator.pop(context),
          child: CircleAvatar(
            backgroundColor: Color(0xff000000),
            radius: 24,
            child: Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
          ),
        ),
        Container(
            width: 250,
            child: TextGearUp(
                text: nameProduct,
                overflow: TextOverflow.ellipsis,
                fontSize: 19,
                color: Colors.white)),
        CircleAvatar(
          backgroundColor: Color(0xff000000),
          radius: 24,
          child: IconButton(
            icon: isFavorite == 1
                ? Icon(Icons.favorite_rounded, color: Colors.red)
                : Icon(Icons.favorite_border_rounded, color: Colors.white),
            onPressed: () => productBloc
                .add(OnAddOrDeleteProductFavoriteEvent(uidProduct: uidProduct)),
          ),
        ),
      ],
    );
  }
}
