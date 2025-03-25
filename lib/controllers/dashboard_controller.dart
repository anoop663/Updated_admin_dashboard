// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flatten/controllers/my_controller.dart';
import 'package:flatten/data/api_provider.dart';
import 'package:flatten/models/customer.dart';
import 'package:flatten/models/product.dart';
import 'package:get/get.dart';

class DashboardController extends MyController {
  DashboardController();

  List<Product> products = [];
  List<Customer> customers = [];

  DateTime now = DateTime(2023, 9);

  //Data

  @override
  void onInit() {
    super.onInit();
    fetchDashboardData();
    Product.dummyList.then((value) {
      products = value.sublist(0, 5);
      update();
    });

    Customer.dummyList.then((value) {
      customers = value.sublist(0, 5);
      update();
    });
  }



  void goToProducts() {
    Get.toNamed('/apps/ecommerce/products');
  }

  void goToCustomers() {
    Get.toNamed('/apps/ecommerce/customers');
  }


  int totalUsers = 0;
  int totalOrders = 0;
  int totalProducts = 0;
  String message = '';
  bool isLoading = true;
  bool isMenuOpen = false; // Added for managing menu state

  final AuthService authService = AuthService();

  Future<void> fetchDashboardData() async {
    isLoading = true;
    update();
    try {
      final response = await authService.loadDashboard();
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('data is--$data');
        if (data['status'] == 1) {
          totalUsers = data['totalUsers'];
          totalOrders = data['totalOrders'];
          totalProducts = data['totalProducts'];
          message = data['message'];
        } else {
          message = 'Failed to load dashboard data';
        }
      } else {
        message = 'Server error: ${response.statusCode}';
      }
    } catch (e) {
      message = 'Error fetching data: $e';
    }

    isLoading = false;
    update();
  }
}
