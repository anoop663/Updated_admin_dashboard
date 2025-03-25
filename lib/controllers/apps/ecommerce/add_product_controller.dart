// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flatten/controllers/my_controller.dart';
import 'package:flatten/data/api_provider.dart';
import 'package:flatten/models/product_edit_response_model.dart';
// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum Status {
  online,
  offline,
  draft;

  const Status();
}

enum Category {
  fashion,
  grocery,
  vegetables,
  fruits,
  electronics,
  kids;

  const Category();
}

class AddProductController extends MyController {
  @override
  // ignore: unnecessary_overrides
  void onInit() {
    super.onInit();
  }

  /// Add Category
  String message = '';
  bool isLoading = false;




  void clearSelectedImages() {
    selectedImages.clear();
    update();
  }

  // Pagination-related fields
  int currentPage = 1;
  int lastPage = 1;

  List<Uint8List> selectedImages = [];

  final AuthService authService = AuthService();

  /// Method to create brand data
  Future<bool> createProductData(
      {required String? productName,
      BuildContext? context,
      required String? tag,
      required String? descriptions,
      required String? manufacturer,
      required String? mrp,
      required String? price,
      required String? stock,
      required String? isfeatured,
      required String? minqty,
      required String? returnPeriod,
      required List<dynamic>? imagedatas}) async {
    isLoading = true;
    update();

    try {
      final response = await authService.addProducts(
        productName: productName,
        tag: tag,
        manufacturer: '1',
        descriptions: descriptions,
        mrp: mrp,
        price: price,
        stock: stock,
        isFeatured: isfeatured,
        imagedatas: imagedatas,
        minQty: minqty,
        returnPeriod: returnPeriod,
      );

      if (response!.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;
        print('repomnce iss----$responseData');
        if (responseData['status'] == 1) {
          toastMsg(context!, responseData['message']);
          isLoading = false;
          selectedImages.clear();
          update();
          return true;
        } else {
          toastMsg(context!, responseData['message']);
          isLoading = false;
          update();
          return false;
        }
      } else {
        toastMsg(context!, 'Server error: ${response.statusCode}');
        isLoading = false;
        update();
        return false;
      }
    } catch (e) {
      isLoading = false;
      update();
      message = 'Error while creating product: $e';
    }
    isLoading = false;
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
  ProductEditResponse? productData;

  //Get product details for edit API
  Future<void> fetchEditProductData({int? productId,BuildContext? context}) async {
    isLoading = true;
    try {
      final response = await authService.loadEditProducts(productId!);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['success'] == 1) {
          final productEditResponse =
          ProductEditResponse.fromJson(responseData);

          productData = productEditResponse;
          Navigator.pushNamed(

            context!,
            '/apps/ecommerce/add_product',
            arguments: {'id':productId,"data":productData },
          );
          update();

          isLoading = false;
        } else {
          isLoading = false;
          message = 'Failed to load data';
        }
      } else {
        isLoading = false;
        message = 'Server error: ${response.statusCode}';
      }
    } catch (e) {
      isLoading = false;
      message = 'Error fetching data: $e';
    }
  }

  /// Method to create product data
  Future<bool> updateProductData(
      {required int productId,
        required String? productName,
        required String? tag,
        required String? descriptions,
        required String? manufacturer,
        required String? mrp,
        required String? price,
        required String? stock,
        required String? isfeatured,
        BuildContext? context,
        required String? minqty,
        required String? returnPeriod,
        required List<dynamic>? imagedatas}) async {
    isLoading = true;
    update();

    try {
      final response = await authService.updateProducts(
        productName: productName,
        tag: tag,
        manufacturer: '1',
        descriptions: descriptions,
        mrp: mrp,
        price: price,
        stock: stock,
        isfeatured: '1',
        imagedatas: imagedatas,
        minqty: '1',
        returnPeriod: '1',
        productId: productId,
      );

      if (response!.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;
        if (responseData['status'] == 1) {
          toastMsg(context!, responseData['message']);
          isLoading=false;
          update();
          selectedImages.clear();
          return true;
        } else {
          toastMsg(context!, responseData['message']);
          isLoading=false;
          update();
          return false;
        }
      } else {
        toastMsg(context!, 'Server error: ${response.statusCode}');
        isLoading=false;
        update();
        return false;
      }
    } catch (e) {
      message = 'Error while creating product: $e';
    }

    isLoading = false;
    update();

    return false;
  }

  String? removeImageId;
  removeProductImage({
    required int? productId,
    required int? productImageId,
  }) async {
    removeImageId = productImageId.toString();
    update();

    try {
      final response = await authService.removeProductImage(
        productId: productId.toString(),
        productImageId: productImageId.toString(),
      );

      if (response?.statusCode == 200 || response?.statusCode == 201) {
        final responseData = response!.data;
        if (responseData['success']) {
          productData?.images = List.from(
              productData!.images!.where((e) => e.id != productImageId));
          removeImageId = null;
          update();
        }
      } else {
        removeImageId = null;
        update();
      }
    } catch (e) {
      removeImageId = null;
      update();
      message = 'Error while creating product: $e';
    }
    await Future.delayed(Duration(milliseconds: 200));
    update();
  }

}
