import 'package:e_commers/Accessory/helpers.dart';
import 'package:e_commers/Layout/Views/categories/product_for_category_page.dart';
import 'package:e_commers/Models/Response/response_categories_home.dart';
import 'package:e_commers/Service/product_services.dart';
import 'package:e_commers/Layout/themes/colors_gearUp.dart';
import 'package:e_commers/Layout/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:e_commers/Layout/widgets/shimmer_gearup.dart';

class ListCategoriesHome extends StatelessWidget {
  const ListCategoriesHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder<List<Categories>>(
        future: productServices.listCategoriesHome(),
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? const ShimmerGearUp()
              : ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, i) => GestureDetector(
                      onTap: () => Navigator.push(
                            context,
                            routeSlide(
                              page: CategoryProductsPage(
                                  uidCategory:
                                      snapshot.data![i].uidCategory.toString(),
                                  category: snapshot.data![i].category),
                            ),
                          ),
                      child: Container(
                        margin: EdgeInsets.only(right: 8.0),
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        width: 150,
                        decoration: BoxDecoration(
                            color: Color(0xffe4e6e7),
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Center(
                          child: TextGearUp(
                            text: snapshot.data![i].category,
                            color: Colors.black,
                            overflow: TextOverflow.ellipsis,
                            fontSize: 17,
                          ),
                        ),
                      )),
                );
        },
      ),
    );
  }
}
