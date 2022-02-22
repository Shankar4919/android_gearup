import 'package:e_commers/Accessory/helpers.dart';
import 'package:e_commers/Bloc/product/product_bloc.dart';
import 'package:e_commers/Layout/Views/search/search.dart';
import 'package:e_commers/Layout/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class searchHome extends StatefulWidget {
  const searchHome({Key? key}) : super(key: key);

  @override
  State<searchHome> createState() => _searchHomeState();
}

class _searchHomeState extends State<searchHome> {
  @override
  Widget build(BuildContext context) {
    final productBloc = BlocProvider.of<ProductBloc>(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: Container(
          height: 38,
          child: TextField(
            onChanged: (value) => Navigator.pushAndRemoveUntil(
                context, routeSlide(page: searchPage()), (_) => false),
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
                hintText: "Search Product"),
          ),
        ),
      ),
      // body: Center(
      //   child: ListView(
      //     children: [
      //       Text(
      //         "Search Product",
      //         textAlign: TextAlign.center,
      //       ),
      //       Positioned(
      //         bottom: 50,
      //         child: Container(
      //             width: size.width,
      //             child: Align(child: BottomNavigationGearUp(index: 4))),
      //       ),
      //     ],
      //   ),
      // ),
      body: Stack(
        children: [
          Positioned(
            bottom: 20,
            child: Container(
                width: size.width,
                child: Align(child: BottomNavigationGearUp(index: 4))),
          ),
        ],
      ),
    );
  }
}
