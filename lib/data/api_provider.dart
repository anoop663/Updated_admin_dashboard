// ignore_for_file: unused_import, depend_on_referenced_packages, avoid_print, await_only_futures

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flatten/data/api_configs.dart';
import 'package:flatten/data/api_constants.dart';
import 'package:flatten/data/storage_provider.dart';
import 'package:flatten/helpers/services/storage/local_storage.dart';
import 'package:flatten/models/orderdetasils_model.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static bool isLoggedIn = false;
  final LocalStorage storageProvider = LocalStorage();

  Future<http.Response> loginUser(Map<String, dynamic> userData) async {
    final url = Uri.parse('${ApiConfig.apiUrl}${ApiConstants.login}');
    final response = await http.post(
      url,
      headers: ApiConfig.headers,
      body: json.encode(userData),
    );
    isLoggedIn=true;
    return response;
  }

  Future<http.Response> loadDashboard() async {
    final token = await storageProvider.readLoginDetails();
    final url = Uri.parse('${ApiConfig.apiUrl}${ApiConstants.dashboard}');

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    return response;
  }

  Future<http.Response> loadCategories(int categoriesPage) async {
    final token = await storageProvider.readLoginDetails();
    if (token == null) {}
    final url = Uri.parse(
        '${ApiConfig.apiUrl}${ApiConstants.categories}?page=$categoriesPage');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    return response;
  }

  Future<Response?> addCategory({
    required String? parentCategory,
    required String? orderNumber,
    required String? categoryName,
    required String? categoryStatus,
    required String? seoUrl,
    required String? descriptions,
    required dynamic imageFile,
    required dynamic imageFile2,
  }) async {
    final token = await storageProvider.readLoginDetails();
    final url = '${ApiConfig.apiUrl}${ApiConstants.categoiresCreate}';
    print('url---$url');
    // Create Dio instance
    Dio dio = Dio();

    // Set headers
    dio.options.headers = {
      'Authorization': 'Bearer $token',
    };

    var formData = FormData.fromMap({
      'image': MultipartFile.fromBytes(
        imageFile!,
        filename: 'image1.png', // Change the filename as needed
      ),
      'image2': MultipartFile.fromBytes(
        imageFile2!,
        filename: 'image2.png', // Change the filename as needed
      ),
      'parent_category': parentCategory,
      'order_number': orderNumber,
      'names': categoryName,
      'descriptions': descriptions,
      'seo_url': seoUrl,
      'status': categoryStatus,
    });

    print(formData.fields);
    print(formData.files);

    Response response = await dio.post(
      url,
      data: formData,
    );
    print('retun responce is--$response');
    return response;
  }

  Future<http.Response> editCategories(int categoryId) async {
    final token = await storageProvider.readLoginDetails();
    if (token == null) {}
    final url = Uri.parse(
        '${ApiConfig.apiUrl}${ApiConstants.categoryEdit}/$categoryId');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    return response;
  }

  Future<Response?> updateCategory({
    required int? categoryId,
    required String? categoryName,
    required String? categoryStatus,
    required String? seoUrl,
    required String? descriptions,
    required String? parentCategory,
    required dynamic imageFile,
    required dynamic imageFile2,
  }) async {
    //  print('sc--$categoryStatus');
    final token = await storageProvider.readLoginDetails();
    final url = '${ApiConfig.apiUrl}${ApiConstants.categoryUpdate}/$categoryId';
    // print(url);
    // Create Dio instance
    Dio dio = Dio();
    var formData = FormData();
    // Set headers
    dio.options.headers = {
      'Authorization': 'Bearer $token',
    };

    if (imageFile == null && imageFile2 == null) {
      formData = FormData.fromMap({
        'parent_category': parentCategory,
        'order_number': 0,
        'names': categoryName,
        'descriptions': descriptions,
        'seo_url': seoUrl,
        'status': categoryStatus,
      });
    } else if (imageFile == null) {


      formData = FormData.fromMap({
        'image2': MultipartFile.fromBytes(
          imageFile2!,
          filename: 'image2.png', // Change the filename as needed
        ),
        'parent_category': parentCategory,
        'order_number': 0,
        'names': categoryName,
        'descriptions': descriptions,
        'seo_url': seoUrl,
        'status': categoryStatus,
      });
    } else if (imageFile2 == null) {
      formData = FormData.fromMap({

        'image': MultipartFile.fromBytes(
          imageFile!,
          filename: 'image2.png', // Change the filename as needed
        ),
        'parent_category': parentCategory,
        'order_number': 0,
        'names': categoryName,
        'descriptions': descriptions,
        'seo_url': seoUrl,
        'status': categoryStatus,
      });
    } else {
      formData = FormData.fromMap({
        'image': MultipartFile.fromBytes(
          imageFile!,
          filename: 'image1.png', // Change the filename as needed
        ),
        'image2': MultipartFile.fromBytes(
          imageFile2!,
          filename: 'image2.png', // Change the filename as needed
        ),
        'parent_category': parentCategory,
        'order_number': 0,
        'names': categoryName,
        'descriptions': descriptions,
        'seo_url': seoUrl,
        'status': categoryStatus,
      });
    }
    //print(formData.fields);
    //print(formData.files);
    try {
      Response response = await dio.post(
        url,
        data: formData,
      );
      // print('starus is ---${response.statusCode}');
      return response;
    } catch (e) {
      if (e is DioException) {
        //print('DioException caught: ${e.response?.data}');
        //print('Status Code: ${e.response?.statusCode}');
        //print('Error Message: ${e.message}');
        return null;
      } else {
        // print('Unexpected error: $e');
        return null; // Or handle the error appropriately
      }
    }
  }

  Future<http.Response> deleteCategories(int categoryId) async {
    final token = await storageProvider.readLoginDetails();
    if (token == null) {}
    final url = Uri.parse(
        '${ApiConfig.apiUrl}${ApiConstants.categoryDelete}/$categoryId');

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    return response;
  }

  Future<http.Response> loadBrands(int brandpage) async {
    final token = await storageProvider.readLoginDetails();
    if (token == null) {}
    final url =
        Uri.parse('${ApiConfig.apiUrl}${ApiConstants.brand}?page=$brandpage');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    return response;
  }

  Future<Response?> addBrands({
    required String? brandName,
    required String? brandStatus,
    required String? seoUrl,
    required String? isFeatured,
    required String? descriptions,
    required dynamic imageFile,
    required dynamic logoFile,
  }) async {
    final token = await storageProvider.readLoginDetails();
    final url = '${ApiConfig.apiUrl}${ApiConstants.brandCreate}';

    // Create Dio instance
    Dio dio = Dio();

    // Set headers
    dio.options.headers = {
      'Authorization': 'Bearer $token',
    };

    var formData = FormData.fromMap({
      'image': MultipartFile.fromBytes(
        imageFile!,
        filename: 'image1.png', // Change the filename as needed
      ),
      'brand_logo': MultipartFile.fromBytes(
        logoFile!,
        filename: 'image2.png', // Change the filename as needed
      ),
      'status': brandStatus,
      'names': brandName,
      'descriptions': descriptions,
      'seo_url': seoUrl,
      'is_featured': isFeatured
    });
  print(formData.fields);
  print(formData.files.first.value);
  print(formData.files.first.key);
  print(formData.files[1].value);
  print(formData.files[1].key);
    Response response = await dio.post(
      url,
      data: formData,
    );

    return response;
  }

  Future<http.Response> editBrands(int brandId) async {
    final token = await storageProvider.readLoginDetails();
    if (token == null) {}
    final url =
        Uri.parse('${ApiConfig.apiUrl}${ApiConstants.brandedit}/$brandId');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    return response;
  }

  Future<Response?> updateBrands({
    required int? brandId,
    required String? categoryName,
    required String? categoryStatus,
    required String? seoUrl,
    required String? descriptions,
    required String? parentCategory,
    required dynamic imageFile,
    required dynamic imageFile2,
  }) async {
    final token = await storageProvider.readLoginDetails();
    final url = '${ApiConfig.apiUrl}${ApiConstants.brandUpdate}/$brandId';

    // Create Dio instance
    Dio dio = Dio();
    var formData = FormData();
    // Set headers
    dio.options.headers = {
      'Authorization': 'Bearer $token',
    };
    if (imageFile == null && imageFile2 == null) {

      formData = FormData.fromMap({

        'names': categoryName,
        'description': descriptions,
        'seo_url': seoUrl,
        'status': categoryStatus,
        'is_featured': 1,
      });
    } else if (imageFile == null) {
      //  print('2222');
      formData = FormData.fromMap({

        'brand_logo': MultipartFile.fromBytes(
          imageFile2!,
          filename: 'image2.png', // Change the filename as needed
        ),
        'names': categoryName,
        'description': descriptions,
        'seo_url': seoUrl,
        'status': categoryStatus,
        'is_featured': 1,
      });
    } else if (imageFile2 == null) {
      //  print('33333');
      formData = FormData.fromMap({
        'image': MultipartFile.fromBytes(
          imageFile!,
          filename: 'image1.png', // Change the filename as needed
        ),
        'names': categoryName,
        'description': descriptions,
        'seo_url': seoUrl,
        'status': categoryStatus,
        'is_featured': 1,
      });
    } else {
      // print('44444');
      formData = FormData.fromMap({

        'image': MultipartFile.fromBytes(
          imageFile!,
          filename: 'image1.png', // Change the filename as needed
        ),
        'brand_logo': MultipartFile.fromBytes(
          imageFile2!,
          filename: 'image2.png', // Change the filename as needed
        ),
        'names': categoryName,
        'description': descriptions,
        'seo_url': seoUrl,
        'status': categoryStatus,
        'is_featured': 1,
      });
    }

    try {
      Response response = await dio.post(
        url,
        data: formData,
      );
      return response;
    } catch (e) {
      if (e is DioException) {
        //print('DioException caught: ${e.response?.data}');
        //print('Status Code: ${e.response?.statusCode}');
        //print('Error Message: ${e.message}');
        return null;
      } else {
        //   print('Unexpected error: $e');
        return null; // Or handle the error appropriately
      }
    }
  }

  Future<http.Response> deleteBrand(int brandId) async {
    final token = await storageProvider.readLoginDetails();
    if (token == null) {}
    final url =
        Uri.parse('${ApiConfig.apiUrl}${ApiConstants.brandDelete}/$brandId');

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    return response;
  }

  Future<Response?> addProducts({
    required String? productName,
    required String? tag,
    required String? descriptions,
    required String? manufacturer,
    required String? mrp,
    required String? price,
    required String? stock,
    required String? isFeatured,
    required String? minQty,
    required List<dynamic>? imagedatas,
    required String? returnPeriod,
  }) async {
    final token = await storageProvider.readLoginDetails();
    final url = '${ApiConfig.apiUrl}${ApiConstants.productsCreate}';

    Dio dio = Dio();
    dio.options.headers = {
      'Authorization': 'Bearer $token',
    };
    print(token);
    if (imagedatas == null || imagedatas.isEmpty) {
      throw Exception('No images provided for upload.');
    }
    var formData = FormData();

    for (var image in imagedatas) {
      formData.files.add(
        MapEntry(
          'imagedatas[]',
          await MultipartFile.fromBytes(
            image!,
            filename: 'image1.png',
          ),
        ),
      );
    }
    //   print('imaegs data is --${formData.files}');

    // Add other fields
    formData.fields.addAll([
      MapEntry('store', '3'),
      MapEntry('name', productName ?? ''),
      MapEntry('tags', tag ?? 'tag'),
      MapEntry('descriptions', descriptions ?? ''),
      MapEntry('manufacturer', manufacturer ?? ''),
      MapEntry('mrp', mrp ?? ''),
      MapEntry('price', price ?? ''),
      MapEntry('stock', stock ?? ''),
      MapEntry('is_featured', isFeatured ?? ''),
      MapEntry('return_period', returnPeriod ?? '5'),
      MapEntry('categories[0]', '1'),
      MapEntry('minqty', minQty ?? '1'),
    ]);
    print(formData.files);
    print(formData.fields);
    try {
      Response response = await dio.post(
        url,
        data: formData,
      );
      //  print(response.statusCode);
      return response;
    } catch (e) {
      //  print(',es--$e');
    }
    return null;
  }

  Future<http.Response?> loadProducts(int productPage) async {
    final token = await storageProvider.readLoginDetails();
    print(token);
    if (token == null) {}
    final url = Uri.parse(
        '${ApiConfig.apiUrl}${ApiConstants.products}?page=$productPage');
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      print(response.statusCode);
      return response;
    } catch (e) {
      print('error is--$e');
    }
    return null;
  }

  Future<http.Response> deleteProducts(productId) async {
    final token = await storageProvider.readLoginDetails();
    final url = Uri.parse(
        '${ApiConfig.apiUrl}${ApiConstants.productsDelete}/$productId');

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    return response;
  }

  Future<http.Response> loadEditProducts(int productId) async {
    final token = await storageProvider.readLoginDetails();
    if (token == null) {}
    final url = Uri.parse(
        '${ApiConfig.apiUrl}${ApiConstants.productsEditData}/$productId');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    return response;
  }

  Future<Response?> updateProducts({
    required int productId,
    required String? productName,
    required String? tag,
    required String? descriptions,
    required String? manufacturer,
    required String? mrp,
    required String? price,
    required String? stock,
    required String? isfeatured,
    required String? minqty,
    required List<dynamic>? imagedatas,
    required String? returnPeriod,
  }) async {
    final token = await storageProvider.readLoginDetails();
    final url = '${ApiConfig.apiUrl}${ApiConstants.productUpdate}/$productId';

    Dio dio = Dio();

    // Set headers
    dio.options.headers = {
      'Authorization': 'Bearer $token',
    };
    var formData = FormData();

    for (var image in imagedatas!) {
      formData.files.add(
        MapEntry(
          'imagedatas[]',
          await MultipartFile.fromBytes(
            image!,
            filename: 'image1.png',
          ),
        ),
      );
    }

    formData.fields.addAll([
      MapEntry('store', '3'),
      MapEntry(
        'name',
        productName!,
      ),
      MapEntry('tags', tag!),
      MapEntry('descriptions', descriptions!),
      MapEntry('manufacturer', manufacturer!),
      MapEntry('mrp', mrp!),
      MapEntry('price', price!),
      MapEntry('stock', stock!),
      MapEntry('is_featured', isfeatured!),
      MapEntry('return_period', returnPeriod!),
      MapEntry('is_show_in_list', '1'),
      MapEntry('categories[0]', '1'),
      MapEntry('minqty', minqty!),
    ]);

    Response response = await dio.post(
      url,
      data: formData,
    );
    //  print(response.statusCode);
    return response;
  }
  Future<http.Response> loadOrdersData(int productPage) async {
    final token = await storageProvider.readLoginDetails();
    if (token == null) {}
    //  print(token);
    final url = Uri.parse(
        '${ApiConfig.apiUrl}${ApiConstants.orders}?page=$productPage');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    return response;
  }

  Future<OrderDetails?> getOrderDetails({required int orderId}) async {
    final token = await storageProvider.readLoginDetails();
    if (token == null) {}
    final url =
    Uri.parse('${ApiConfig.apiUrl}${ApiConstants.orderView}$orderId');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      //  print(response.statusCode);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['status'] == 1) {
          return orderDetailsFromJson(response.body);
        }
      }
    } catch (e) {
      //  print(',es--$e');
    }

    return null;
  }

  Future<http.Response> updateOrders(int orderID, int orderStatus) async {
    final token = await storageProvider.readLoginDetails();
    if (token == null) {
      throw Exception("User not logged in");
    }

    // Construct the URL without query parameters
    final url =
    Uri.parse('${ApiConfig.apiUrl}${ApiConstants.orderStatusUpdate}');

    // Create the body for the POST request
    final body = {
      'order_id': orderID.toString(),
      'status': orderStatus.toString(),
      'reason': 'xyz',
      'type': 'order',
    };

    // Send the POST request
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },

      body: jsonEncode(body), // Encode the body as JSON
    );
    // print(response.statusCode);
    return response;
  }





  //
  Future<Response?> removeProductImage({
    required String? productId,
    required String? productImageId,
  }) async {
    final token = await storageProvider.readLoginDetails();
    final url =
        '${ApiConfig.apiUrl}${ApiConstants.removerProductImage}$productId?image_id=$productImageId';
    // print(url);
    Dio dio = Dio();

    dio.options.headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    try {
      Response response = await dio.post(url, options: Options());
      //print("Response Status Code: ${response.statusCode}");
      //print(response.statusCode);
      return response;
    } catch (e) {
      //  print(',es--$e');
    }
    return null;
  }


}
