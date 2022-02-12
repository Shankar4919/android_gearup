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

  Future<ResponseDefault> addOrDeleteProductFavorite(String uidProduct) async {
    final token = await secureStorage.readToken();

    final resp = await http.post(
        Uri.parse('${URLS.urlApi}/product/like-or-unlike-product'),
        headers: {'Accept': 'application/json', 'xxx-token': token!},
        body: {'uidProduct': uidProduct});
    return ResponseDefault.fromJson(jsonDecode(resp.body));
  }

  Future<List<Categories>> getAllCategories() async {
    final token = await secureStorage.readToken();

    final resp = await http.get(
        Uri.parse('${URLS.urlApi}/category/get-all-categories'),
        headers: {'Accept': 'application/json', 'xxx-token': token!});
    return ResponseCategoriesHome.fromJson(jsonDecode(resp.body)).categories;
  }

  Future<List<ListProducts>> allFavoriteProducts() async {
    final token = await secureStorage.readToken();

    final resp = await http.get(
      Uri.parse('${URLS.urlApi}/product/get-all-favorite'),
      headers: {'Accept': 'application/json', 'xxx-token': token!},
    );

    return ResponseProductsHome.fromJson(jsonDecode(resp.body)).listProducts;
  }

  Future<List<ListProducts>> getProductsForCategories(String id) async {
    final token = await secureStorage.readToken();

    final resp = await http.get(
      Uri.parse('${URLS.urlApi}/product/get-products-for-category/' + id),
      headers: {'Content-type': 'application/json', 'xxx-token': token!},
    );

    return ResponseProductsHome.fromJson(jsonDecode(resp.body)).listProducts;
  }

  Future<ResponseDefault> saveOrderBuyProductToDatabase(
      String receipt, String amount, List<ProductCart> products) async {
    final token = await secureStorage.readToken();

    Map<String, dynamic> data = {
      'receipt': receipt,
      'amount': amount,
      'products': products
    };

    final body = json.encode(data);

    final resp = await http.post(
        Uri.parse('${URLS.urlApi}/product/save-order-buy-product'),
        headers: {'Content-type': 'application/json', 'xxx-token': token!},
        body: body);

    return ResponseDefault.fromJson(jsonDecode(resp.body));
  }

  
}

final productServices = ProductServices();
