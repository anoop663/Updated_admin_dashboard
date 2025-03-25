// ignore_for_file: unused_import, unnecessary_import, avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:flatten/controllers/apps/ecommerce/category_controller.dart';
import 'package:flatten/controllers/my_controller.dart';
import 'package:flatten/data/api_provider.dart';
import 'package:flatten/helpers/widgets/my_form_validator.dart';
import 'package:flatten/models/category_edit_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

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

class AddProductsController extends MyController {
  MyFormValidator basicValidator = MyFormValidator();
  Status selectedGender = Status.online;

  @override
  void onInit() {
    super.onInit();
    basicValidator.addField(
      'name',
      label: "Product Name",
      required: true,
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'shop_name',
      label: "shop_name",
      required: true,
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'description',
      label: "description",
      required: true,
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'tags',
      label: "Tags",
      required: true,
      controller: TextEditingController(),
    );
  }

  bool showOnline = true;

  void setOnlineType(bool value) {
    showOnline = value;
    update();
  }

  final List<String> categories = [];

  void onChangeGender(Status? value) {
    selectedGender = value ?? selectedGender;
    update();
  }

  /// Add Category
  String message = '';
  bool isLoading = false;
  bool editCategoryLoading = false;
  bool createCategoryLoading = false;
  List<Category> _categoryData = [];
  CategoryEditData? categori;
  String parentCategory = '0';
  String orderNumber = '0';
  // String name = '';
  String? status;
  // String discriptions = '';
  // String seourl = '';
  String isfeatured = '0';

  bool isMenuOpen = false;

  // Getters and Setters for data
  List<Category> get categoryData => _categoryData;

  set categoryData(List<Category> value) {
    _categoryData = value;
    update();
  }

  Uint8List? webImage;
  Uint8List? webImage2;

  // Pagination-related fields
  int currentPage = 1;
  int lastPage = 1;

  final AuthService authService = AuthService();

  /// Method to create brand data
  Future<bool> createCateogryData({
    required String? categoryName,
    required String? categoryStatus,
    required String? seoUrl,
    required String? descriptions,
    BuildContext? context,
  }) async {
    createCategoryLoading = true;
    update();
    print('loding is--$createCategoryLoading');
    try {
      final response = await authService.addCategory(
          categoryName: categoryName,
          parentCategory: '0',
          orderNumber: '0',
          categoryStatus: categoryStatus,
          descriptions: descriptions,
          imageFile: webImage,
          imageFile2: webImage2,
          seoUrl: seoUrl);

      if (response!.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;
        print('category adding responce iss--$responseData');
        print('date ---$responseData');
        if (responseData['status'] == 1) {
          toastMsg(context!, responseData['message']);
          createCategoryLoading = false;
          status = '1';
          webImage = null;
          webImage2 = null;

          update();
          return true;
        } else {
          toastMsg(context!, responseData['message']);

          createCategoryLoading = false;
          update();
          return false;
        }
      } else {
        toastMsg(context!, 'Server error: ${response.statusCode}');
        createCategoryLoading = false;
        update();
        return false;
      }
    } catch (e) {
      createCategoryLoading = false;
      update();
      toastMsg(context!, 'Error while creating brand: $e');
    }
    createCategoryLoading = false;
    update();
    return false;
  }

  Future<bool> editCategory(
      {required int? categoryId, BuildContext? context}) async {
    isLoading = true;
    update();
    try {
      final response = await authService.editCategories(
        categoryId!,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = json.decode(response.body);
        if (responseData['status'] == 1) {
          categori = CategoryEditResponse.fromJson(responseData).data;

          status = 'Active';
          update();
          Navigator.pushNamed(
              // ignore: use_build_context_synchronously
              context!,
              '/apps/ecommerce/add_category',
              arguments: {'id': categoryId, 'data': categori});
          message = responseData['message'] ?? 'Items viewing failed';
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

  Future<bool> updateCategoryData({
    required int categoryId,
    required String? categoryName,
    required String? categoryStatus,
    required String? seoUrl,
    required String? descriptions,
    BuildContext? context,
  }) async {
    isLoading = true;
    update();

    try {
      final response = await authService.updateCategory(
          categoryId: categoryId,
          categoryName: categoryName,
          parentCategory: '0',
          categoryStatus: categoryStatus,
          descriptions: descriptions,
          imageFile: webImage,
          imageFile2: webImage2,
          seoUrl: seoUrl);
      if (response!.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;
        if (responseData['status'] == 1) {
          toastMsg(context!, responseData['message']);
          var ctrl=Get.put(EcommerceCategoryController());
          ctrl.fetchCategoryData(page:ctrl.currentPage );
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

  Future<bool> deleteCategory(
      {required int? categoryId, BuildContext? context}) async {
    isLoading = true;
    update();

    try {
      final response = await authService.deleteCategories(categoryId!);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = json.decode(response.body);
        print('delteded responce is ----$responseData');
        if (responseData['status'] == 1) {
          message = responseData['message'] ?? 'Category Deleted Successfully';
          isLoading = false; // Ensure loading is false
          ScaffoldMessenger.of(context!).showSnackBar(
            SnackBar(
              content: Text(
                message,
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              backgroundColor: Colors.blueAccent,
            ),
          );
          update();
          return true;
        } else {
          message = responseData['message'] ?? 'Failed to delete category';
          print('messasdasda-----_$message');
          update();
          ScaffoldMessenger.of(context!).showSnackBar(
            SnackBar(
              content: Text(
                message,
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              backgroundColor: Colors.blueAccent,
            ),
          );
        }
      } else {
        message = 'Server error: ${response.statusCode}';
        update();
        ScaffoldMessenger.of(context!).showSnackBar(
          SnackBar(
            content: Text(
              message,
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            backgroundColor: Colors.blueAccent,
          ),
        );
      }
    } catch (e) {
      message = 'Error while deleting category: $e';
      update();
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
