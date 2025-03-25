// ignore_for_file: unused_field, unnecessary_overrides

import 'dart:convert';
import 'dart:io';

import 'package:flatten/controllers/my_controller.dart';
import 'package:flatten/data/api_provider.dart';
import 'package:flatten/models/brand_response.dart';
import 'package:flatten/models/edit_brand_response.dart';
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

class AddBrandController extends MyController {
  @override
  void onInit() {
    super.onInit();
  }

  /// Add Category
  String message = '';
  bool isLoading = false;
  List<Brand> _brandData = [];
  String name = '';
  String? status;
  String discriptions = '';
  String seourl = '';
  String isfeatured = '0';
  File? _brandImage;
  File? _brandLogo;
  bool isMenuOpen = false;
  late BrandEditData brands;

  // Getters and Setters for data
  List<Brand> get brandData => _brandData;

  set brandData(List<Brand> value) {
    _brandData = value;
    update();
  }

  File? get brandImage => _brandImage;

  Uint8List? webImage;
  Uint8List? webImage2;
  // Pagination-related fields
  int currentPage = 1;
  int lastPage = 1;

  final AuthService authService = AuthService();

  /// Method to create brand data
  Future<bool> createBrandData1(
      {required String? brandName,
      required String? brandStatus,
      required String? seoUrl,
      required String? isFeatured,
      required String? descriptions,
      BuildContext? context}) async {
    isLoading = true;
    update();

    try {
      final response = await authService.addBrands(
          brandName: brandName,
          brandStatus: brandStatus,
          descriptions: descriptions,
          imageFile: webImage,
          isFeatured: isFeatured,
          logoFile: webImage2,
          seoUrl: seoUrl);

      if (response!.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;
        if (responseData['status'] == 1) {
          message = responseData['message'] ?? '';
          toastMsg(context!, responseData['message']);
          webImage = null;
          webImage2 = null;
          update();
          return true;
        } else {
          message = responseData['message'] ?? 'Failed to create brand';
          return false;
        }
      } else {
        message = 'Server error: ${response.statusCode}';
        return false;
      }
    } catch (e) {
      message = 'Error while creating brand: $e';
    }

    isLoading = false;
    update();

    return false;
  }

  Future<bool> editBrand({required int? brandId, BuildContext? context}) async {
    isLoading = true;
    update();

    try {
      final response = await authService.editBrands(
        brandId!,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = json.decode(response.body);
        if (responseData['status'] == 1) {
          final brandeditResponse = BrandEditResponse.fromJson(responseData);
          brands = brandeditResponse.data;
          Navigator.pushNamed(
            context!,
            '/apps/ecommerce/add_brand',
            arguments: {"id": brandId, "data": brands},
          );
          isLoading = false;
          update();
          return true;
        } else {
          message = responseData['message'] ?? 'Failed to create brand';
          isLoading = false;
          update();
          return false;
        }
      } else {
        message = 'Server error: ${response.statusCode}';
        isLoading = false;
        update();
        return false;
      }
    } catch (e) {
      message = 'Error while creating brand: $e';
    }

    isLoading = false;
    update();

    return false;
  }

  Future<bool> updateBrand({
    required int brandId,
    required String? brandName,
    required String? brandStatus,
    required String? isFeatured,
    required String? seoUrl,
    required String? descriptions,
    BuildContext? context
  }) async {
    isLoading = true;
    update();

    try {
      final response = await authService.updateBrands(
          brandId: brandId,
          categoryName: brandName,
          parentCategory: '0',
          categoryStatus: brandStatus,
          descriptions: descriptions,
          imageFile: webImage,
          imageFile2: webImage2,
          seoUrl: seoUrl);

      if (response!.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;
        if (responseData['status'] == 1) {
          toastMsg(context!, responseData['message']);
          isLoading = false;
          update();
          return true;
        } else {
          toastMsg(context!, responseData['message']);
          return false;
        }
      } else {
        toastMsg(context!, 'Server error: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      message = 'Error while creating brand: $e';
    }

    isLoading = false;
    update();

    return false;
  }

  Future<bool> deleteBrands(
      {required int? categoryId, BuildContext? context}) async {
    isLoading = true;
    update();

    try {
      final response = await authService.deleteBrand(categoryId!);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = json.decode(response.body);
        if (responseData['status'] == 1) {
          toastMsg(context!, responseData['message']);
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
