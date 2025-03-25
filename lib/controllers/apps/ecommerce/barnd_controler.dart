// ignore_for_file: unused_import

import 'dart:convert';

import 'package:flatten/controllers/apps/ecommerce/edit_category_controller.dart';
import 'package:flatten/controllers/my_controller.dart';
import 'package:flatten/data/api_provider.dart';
import 'package:flatten/models/brand_response.dart';
import 'package:flatten/models/category_list_response.dart' as category;
import 'package:flatten/models/product.dart';

import 'package:get/get.dart';

class EcommerceBrandController extends MyController {
  List<Product> products = [];

  EcommerceBrandController();

  @override
  void onInit() {
    super.onInit();
    fetchBrandData();

  }

  String message = '';
  bool isLoading = true;
  List<Brand> _brandData = [];
  bool isMenuOpen = false;

  List<Brand> get brandData => _brandData;

  set brandData(List<Brand> value) {
    _brandData = value;
    update();
  }

  int currentPage = 1;
  String page = '1';
  int lastPage = 1;

  final AuthService authService = AuthService();

  Future<void> fetchBrandData({int page = 1}) async {
    isLoading = true;
    update(); // Notify UI about the loading state

    try {
      final response = await authService.loadBrands(page);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['status'] == 1) {
          final brandResponse = BrandResponse.fromJson(responseData);

          // Clear previous data when changing the page
          brandData = [];

          // Set new data
          brandData = brandResponse.data!.brands!;
          message = responseData['message'] ?? 'Items viewing failed';
          currentPage = brandResponse.data!.currentPage!;
          lastPage = brandResponse.data!.lastPage!;
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
      fetchBrandData(page: page);
    }
  }
}
