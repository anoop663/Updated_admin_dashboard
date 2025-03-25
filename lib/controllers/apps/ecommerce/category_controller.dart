// ignore_for_file: unused_import, avoid_print

import 'dart:convert';

import 'package:flatten/controllers/apps/ecommerce/edit_category_controller.dart';
import 'package:flatten/controllers/my_controller.dart';
import 'package:flatten/data/api_provider.dart';
import 'package:flatten/models/category_list_response.dart' as category;
import 'package:flatten/models/product.dart';

import 'package:get/get.dart';

class EcommerceCategoryController extends MyController {
  List<Product> products = [];

  EcommerceCategoryController();

  @override
  void onInit() {
    super.onInit();
    fetchCategoryData();
    Product.dummyList.then((value) {
      products = value;
      update();
    });
  }

  void goToCreateProduct() {
    Get.toNamed('/apps/ecommerce/add_category');
  }

  /// fetch category
  String message = '';
  bool isLoading = true;
  List<category.Category> _categoryData = [];
  bool isMenuOpen = false;

  List<category.Category> get categoryData => _categoryData;

  set categoryData(List<category.Category> value) {
    _categoryData = value;
    update();
  }

  int currentPage = 1;
  String page = '1';
  int lastPage = 1;

  final AuthService authService = AuthService();

  Future<void> fetchCategoryData({int page = 1,bool needLoading=true}) async {
    isLoading = needLoading;
    update(); // Notify UI about the loading state

    try {
      final response = await authService.loadCategories(page);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print('Category response: $responseData');

        if (responseData['status'] == 1) {
          final categoryResponse = category.CategoryResponse.fromJson(responseData);

          // Clear previous data before updating the list
          categoryData = [];

          // Set new data
          categoryData = categoryResponse.data.data;
          message = responseData['message'] ?? 'Items viewing failed';
          currentPage = categoryResponse.data.currentPage;
          lastPage = categoryResponse.data.lastPage;
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
      fetchCategoryData(page: page);
    }
  }
}
