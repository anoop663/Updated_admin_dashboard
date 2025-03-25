// ignore_for_file: unused_import

import 'dart:convert';
import 'dart:developer';

import 'package:flatten/controllers/apps/ecommerce/edit_category_controller.dart';
import 'package:flatten/controllers/my_controller.dart';
import 'package:flatten/data/api_provider.dart';
import 'package:flatten/models/brand_response.dart';
import 'package:flatten/models/category_list_response.dart' as category;
import 'package:flatten/models/order_response.dart';
import 'package:flatten/models/orderdetasils_model.dart';
import 'package:flatten/models/product.dart';
import 'package:flatten/models/product_reponse_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class EcommerceInvoiceController extends MyController {


  @override
  void onInit() {
    super.onInit();
    fetchOrdersData();

  }
  String message = '';
  bool isLoading = true;
  List<Orders> _ordersData = [];
  bool isMenuOpen = false;

  List<Orders> get ordersData => _ordersData;

  set ordersData(List<Orders> value) {
    _ordersData = value;
    update();
  }

  OrderDetails? orderDetails;
  int currentPage = 1;
  String page = '1';
  int lastPage = 1;

  final AuthService authService = AuthService();

  Future<void> fetchOrdersData({int page = 1}) async {
    isLoading = true;

    try {
      final response = await authService.loadOrdersData(page);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['status'] == 1) {
          final orderResponse = OrderResponse.fromJson(responseData);
          ordersData = orderResponse.data!.data1.toList();
          message = responseData['message'] ?? 'Order viewing failed';
          currentPage = orderResponse.data!.currentPage;
          lastPage = orderResponse.data!.lastPage;
        } else {
          message = 'Failed to load orders';
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

  bool isDetailsLoading = false;

  Future<bool>? fetchOrdersDetails({required int orderId,bool needLoading=true}) async {
    isDetailsLoading = needLoading;
    update();
    try {
      var responce = await authService.getOrderDetails(orderId: orderId);
      //  print(responce);
      if (responce != null) {
        orderDetails = responce;
        isDetailsLoading = false;
        update();
        return true;
        // print('order detyaiks is--${jsonEncode(orderDetails)}');
      } else {
        isDetailsLoading = false;
        update();
        return false;
        //  print('result  is--$responce');
      }
    } catch (e) {
      isDetailsLoading = false;
      update();
      message = 'Error fetching data: $e';

    }
    isDetailsLoading = false;
    update();
    return false;
  }

  void goToPage(int page) {
    if (page > 0 && page <= lastPage) {
      fetchOrdersData(page: page);
    }
  }



  Future<void> updateOrderStatus(
      {orderId, currentStatus, bool? isFromDetails}) async {
    isLoading = true;
    try {
      final response = await authService.updateOrders(orderId, currentStatus);
      if (response.statusCode == 200) {
        // ignore: unused_local_variable
        final responseData = json.decode(response.body);
        //  print(responseData['status']);
        await  fetchOrdersDetails(orderId: orderId,needLoading: false);
        if (isFromDetails == true) {
          Orders editedOrder =
          ordersData.firstWhere((element) => element.id == orderId);
          editedOrder.orderStatus = orderDetails!.statusLanguage
              .firstWhere(
                (element) => element.statusId == currentStatus,
          )
              .statusText;
          update();
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
