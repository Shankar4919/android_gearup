import 'dart:convert';
import 'package:e_commers/Models/Response/response_order_buy.dart';
import 'package:e_commers/Models/Response/response_order_details.dart';
import 'package:http/http.dart' as http;
import 'package:e_commers/Accessory/secure_storage.dart';
import 'package:e_commers/Models/product.dart';
import 'package:e_commers/Models/Response/response_categories_home.dart';
import 'package:e_commers/Models/Response/response_default.dart';
import 'package:e_commers/Models/Response/response_products_home.dart';
import 'package:e_commers/Models/Response/response_slide_products.dart';
import 'package:e_commers/Service/urls.dart';

class ProductServices {
  Future<List<SlideProduct>> listProductsHomeCarousel() async {
    final token = await secureStorage.readToken();

    final resp = await http.get(
        Uri.parse('${URLS.urlApi}/product/get-home-products-carousel'),
        headers: {'Accept': 'application/json', 'xxx-token': token!});

    return ResponseSlideProducts.fromJson(jsonDecode(resp.body)).slideProducts;
  }

  Future<List<Categories>> listCategoriesHome() async {
    final token = await secureStorage.readToken();

    final resp = await http.get(
        Uri.parse('${URLS.urlApi}/category/get-all-categories'),
        headers: {'Accept': 'application/json', 'xxx-token': token!});
    return ResponseCategoriesHome.fromJson(jsonDecode(resp.body)).categories;
  }

  Future<List<ListProducts>> listProductsHome() async {
    final token = await secureStorage.readToken();

    final resp = await http.get(
        Uri.parse('${URLS.urlApi}/product/get-products-home'),
        headers: {'Accept': 'application/json', 'xxx-token': token!});
    return ResponseProductsHome.fromJson(jsonDecode(resp.body)).listProducts;
  }

  
}

final productServices = ProductServices();
