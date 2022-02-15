import 'package:e_commers/Bloc/product/product_bloc.dart';
import 'package:e_commers/Accessory/helpers.dart';
import 'package:e_commers/Layout/Views/Home/home_page.dart';
import 'package:e_commers/Models/Response/response_products_home.dart';
import 'package:e_commers/Service/product_services.dart';
import 'package:e_commers/Layout/Views/favorite/widgets/list_favorite.dart';
import 'package:e_commers/Layout/widgets/shimmer_gearup.dart';
import 'package:e_commers/Layout/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritePage extends StatefulWidget {
  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is LoadingProductState) {
          modalLoadingShort(context);
        } else if (state is FailureProductState) {
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        } else if (state is SuccessProductState) {
          Navigator.pop(context);
          setState(() {});
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: IconButton(
            splashRadius: 20,
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
            onPressed: () => Navigator.pushAndRemoveUntil(
                context, routeSlide(page: HomePage()), (_) => false),
          ),
          title: const TextGearUp(
              text: 'Favorites',
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500),
          centerTitle: true,
          backgroundColor: Color(0xff00000),
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: Stack(
          children: [
            FutureBuilder<List<ListProducts>>(
                future: productServices.allFavoriteProducts(),
                builder: (context, snapshot) => !snapshot.hasData
                    ? Column(
                        children: const [
                          ShimmerGearUp(),
                          SizedBox(height: 10.0),
                          ShimmerGearUp(),
                          SizedBox(height: 10.0),
                          ShimmerGearUp(),
                        ],
                      )
                    : ListFavoriteProduct(products: snapshot.data!)),
            // Positioned(
            //   bottom: 20,
            //   child: Container(
            //       width: size.width,
            //       child: Align(child: BottomNavigationGearUp(index: 2))),
            // ),
          ],
        ),
      ),
    );
  }
}
