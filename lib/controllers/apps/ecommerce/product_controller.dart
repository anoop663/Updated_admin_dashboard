// ignore_for_file: unused_import, avoid_print

import 'dart:convert';
import 'dart:developer';

import 'package:flatten/controllers/apps/ecommerce/edit_category_controller.dart';
import 'package:flatten/controllers/my_controller.dart';
import 'package:flatten/data/api_provider.dart';
import 'package:flatten/models/brand_response.dart';
import 'package:flatten/models/category_list_response.dart' as category;
import 'package:flatten/models/product.dart';
import 'package:flatten/models/product_reponse_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class EcommerceProductController extends MyController {


  @override
  void onInit() {
    super.onInit();
    fetchProductData();

  }
  String message = '';
  bool _isLoading = true;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  List<Datum> productData = [];
  bool isMenuOpen = false;



  int currentPage = 1;
  String page = '1';
  int lastPage = 1;

  final AuthService authService = AuthService();
  Future<void> fetchProductData({int page = 1}) async {
    print('Fetching product data for page: $page');
    isLoading = true;
    update(); // Notify UI about the loading state

    try {
      final response = await authService.loadProducts(page);

      if (response!.statusCode == 200) {
        final responseData = json.decode(response.body);
        print('Response data: $responseData');

        if (responseData['status'] == 1) {
          print('Success: Data fetched');

          final productResponse = ProductResponse.fromJson(responseData);

          // Clear previous data before updating the list
          productData = [];

          // Set new data
          productData = productResponse.data;
          log('Updated product data: ${jsonEncode(productData)}');

          message = responseData['message'] ?? 'Items viewing failed';
          currentPage = productResponse.meta.currentPage;
          lastPage = productResponse.meta.lastPage;
        } else {
          message = 'Failed to load data';
        }
      } else {
        message = 'Server error: ${response.statusCode}';
      }
    } catch (e) {
      message = 'Error fetching data: $e';
    }

    isLoading = false;
    update(); // Notify UI after data update
  }

  void goToPage(int page) {
    if (page > 0 && page <= lastPage) {
      fetchProductData(page: page);
    }
  }



  Future<bool> deleteProduct(
      {required int? productId, BuildContext? context}) async {
    isLoading = true;
    update();

    try {
      final response = await authService.deleteProducts(productId!);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = json.decode(response.body);
        if (responseData['status'] == 1) {
          toastMsg(context!, responseData['message']);

          productData.removeWhere((e)=>e.id==productId);
          isLoading = false;
          update();
          return true;
        } else {
          toastMsg(context!, responseData['message']);
        }
      } else {
        toastMsg(context!, 'Server error: ${response.statusCode}');
      }
    } catch (e) {
      message = 'Error while deleting category: $e';
    }

    isLoading = false; // Ensure loading is false
    update();
    return false;
  }
  void toastMsg(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}
