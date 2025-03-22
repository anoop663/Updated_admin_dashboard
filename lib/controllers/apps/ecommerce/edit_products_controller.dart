import 'dart:convert';
import 'dart:io';

import 'package:flatten/controllers/my_controller.dart';
import 'package:flatten/data/api_provider.dart';
import 'package:flatten/helpers/widgets/my_form_validator.dart';
import 'package:flatten/models/category_edit_response.dart';
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
  late CategoryEditData categori;
  String parentCategory = '0';
  String orderNumber = '0';
  String name = '';
  String? status = '1';
  String discriptions = '';
  String seourl = '';
  String isfeatured = '0';
  File? image;
  File? image2;
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
    required dynamic imageFile,
    required dynamic logoFile,
  }) async {
    createCategoryLoading = true;
    update();
    try {
      final response = await authService.addCategory(
          categoryName: categoryName,
          parentCategory: '0',
          orderNumber: '0',
          categoryStatus: categoryStatus,
          descriptions: descriptions,
          imageFile: image,
          imageFile2: image2,
          seoUrl: seoUrl);

      if (response!.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;
        print('category adding responce iss--$responseData');
        print('date ---$responseData');
        if (responseData['status'] == 1) {
          message = responseData['message'] ?? '';
          createCategoryLoading=false;
          update();
          return true;
        } else {
          message = responseData['message'] ?? 'Failed to create brand';

          createCategoryLoading=false;
          update();
          return false;
        }
      } else {
        message = 'Server error: ${response.statusCode}';
        createCategoryLoading=false;
        update();
        return false;
      }
    } catch (e) {
      createCategoryLoading=false;
      update();
      message = 'Error while creating brand: $e';
    }

    createCategoryLoading=false;
    update();

    return false;
  }

  Future<bool> editCategory({
    required int? categoryId,
  }) async {
    isLoading = true;
    update();

    try {
      final response = await authService.editCategories(
        categoryId!,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = json.decode(response.body);
        if (responseData['status'] == 1) {
          final categoryeditResponse =
          CategoryEditResponse.fromJson(responseData);
          categori = categoryeditResponse.data;
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
    required File? imageFile,
    required File? logoFile,
    //required String? status,
  }) async {
    editCategoryLoading = true;
    // print(editCategoryLoading);
    update();

    try {

      final response = await authService.updateCategory(
          categoryId: categoryId,
          categoryName: categoryName,
          parentCategory: '0',
          categoryStatus: categoryStatus,
          descriptions: descriptions,
          imageFile: image,
          imageFile2: image2,
          seoUrl: seoUrl);
      if (response!.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;
        if (responseData['status'] == 1) {
          message = responseData['message'] ?? '';
          editCategoryLoading = false;
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

    editCategoryLoading = false;
    update();

    return false;
  }

  Future<bool> deleteCategory({
    required int? categoryId,
    BuildContext? context
  }) async {
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
          ScaffoldMessenger.of(context!)
              .showSnackBar(
            SnackBar(
              content: Text(
               message,style: TextStyle(color: Colors.white,fontSize: 25),),
              backgroundColor: Colors.blueAccent,
            ),
          );
          update();
          return true;
        } else {
          message = responseData['message'] ?? 'Failed to delete category';
          print('messasdasda-----_$message');
          update();
          ScaffoldMessenger.of(context!)
              .showSnackBar(
            SnackBar(
              content: Text(
                message,style: TextStyle(color: Colors.white,fontSize: 25),),
              backgroundColor: Colors.blueAccent,
            ),
          );
        }
      } else {
        message = 'Server error: ${response.statusCode}';
        update();
        ScaffoldMessenger.of(context!)
            .showSnackBar(
          SnackBar(
            content: Text(
              message,style: TextStyle(color: Colors.white,fontSize: 25),),
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
}
