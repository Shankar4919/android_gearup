import 'package:e_commers/Accessory/helpers.dart';
import 'package:e_commers/Bloc/product/product_bloc.dart';
import 'package:e_commers/Layout/widgets/staggered_dual_view.dart';
import 'package:e_commers/service/urls.dart';
import 'package:e_commers/Layout/Views/products/details_product_page.dart';
import 'package:e_commers/Layout/widgets/shimmer_gearup.dart';
import 'package:e_commers/Layout/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:e_commers/Service/product_services.dart';
import 'package:e_commers/Models/Response/response_products_home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commers/Models/Product.dart';

class searchPage extends StatefulWidget {
  const searchPage({Key? key}) : super(key: key);

  @override
  State<searchPage> createState() => _searchPageState();
}

class _searchPageState extends State<searchPage> {
  @override
  Widget build(BuildContext context) {
    final productBloc = BlocProvider.of<ProductBloc>(context);
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
        backgroundColor: Color(0xff000000),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey.shade900,
          title: Container(
            color: Colors.black,
            height: 38,
            child: TextField(
              // onChanged: (value) => onSearch(value),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.all(0),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none),
                  hintStyle: TextStyle(fontSize: 14, color: Colors.black),
                  hintText: "Je"),
            ),
          ),
        ),
        body: Stack(
          children: [
            FutureBuilder<List<ListProducts>>(
              future: productServices.listProductsHome(),
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
                  : Padding(
                      padding: EdgeInsets.all(10.0),
                      child: StaggeredDualView(
                          itemCount: snapshot.data!.length,
                          spacing: 5,
                          alturaElement: 0,
                          aspectRatio: 0.8,
                          itemBuilder: (context, i) => Card(
                                shadowColor: Colors.black26,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                elevation: 10.0,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  splashColor: Colors.blue[300],
                                  onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (_) => DetailsProductPage(
                                              product: snapshot.data![i]))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Stack(
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              child: Hero(
                                                  tag: snapshot
                                                      .data![i].uidProduct
                                                      .toString(),
                                                  child: Image.network(
                                                      URLS.baseUrl +
                                                          snapshot
                                                              .data![i].picture,
                                                      height: 120)),
                                            ),
                                            const SizedBox(height: 10.0),
                                            TextGearUp(
                                                text: snapshot
                                                    .data![i].nameProduct,
                                                fontWeight: FontWeight.w500),
                                            TextGearUp(
                                                text:
                                                    '\$ ${snapshot.data![i].price}',
                                                fontSize: 16),
                                          ],
                                        ),
                                        Positioned(
                                            right: 0,
                                            child: snapshot
                                                        .data![i].isFavorite ==
                                                    1
                                                ? InkWell(
                                                    onTap: () => productBloc.add(
                                                        OnAddOrDeleteProductFavoriteEvent(
                                                            uidProduct: snapshot
                                                                .data![i]
                                                                .uidProduct
                                                                .toString())),
                                                    child: const Icon(
                                                        Icons.favorite_rounded,
                                                        color: Colors.red),
                                                  )
                                                : InkWell(
                                                    onTap: () => productBloc.add(
                                                        OnAddOrDeleteProductFavoriteEvent(
                                                            uidProduct: snapshot
                                                                .data![i]
                                                                .uidProduct
                                                                .toString())),
                                                    child: Icon(Icons
                                                        .favorite_outline_rounded))),
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                    ),
            ),
            Positioned(
              bottom: 20,
              child: Container(
                  width: size.width,
                  child: Align(child: BottomNavigationGearUp(index: 4))),
            ),
          ],
        ),
      ),
    );
  }
}
