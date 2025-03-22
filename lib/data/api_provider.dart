import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flatten/data/api_configs.dart';
import 'package:flatten/data/api_constants.dart';
import 'package:flatten/data/storage_provider.dart';
import 'package:flatten/helpers/services/storage/local_storage.dart';
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

    // Create Dio instance
    Dio dio = Dio();

    // Set headers
    dio.options.headers = {
      'Authorization': 'Bearer $token',
    };

    var formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(imageFile!.path,
          filename: imageFile.path),
      'image2': await MultipartFile.fromFile(imageFile2!.path,
          filename: imageFile2.path),
      'parent_category': parentCategory,
      'order_number': orderNumber,
      'names': categoryName,
      'descriptions': descriptions,
      'seo_url': seoUrl,
      'status': categoryStatus,
    });

    Response response = await dio.post(
      url,
      data: formData,
    );

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
    required File? imageFile,
    required File? imageFile2,
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
        'image2': await MultipartFile.fromFile(imageFile2!.path,
            filename: imageFile2.path),
        'parent_category': parentCategory,
        'order_number': 0,
        'names': categoryName,
        'descriptions': descriptions,
        'seo_url': seoUrl,
        'status': categoryStatus,
      });
    } else if (imageFile2 == null) {
      formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(imageFile.path,
            filename: imageFile.path),
        'parent_category': parentCategory,
        'order_number': 0,
        'names': categoryName,
        'descriptions': descriptions,
        'seo_url': seoUrl,
        'status': categoryStatus,
      });
    } else {
      formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(imageFile.path,
            filename: imageFile.path),
        'image2': await MultipartFile.fromFile(imageFile2.path,
            filename: imageFile2.path),
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

  // Future<http.Response> loadBrands(int brandpage) async {
  //   final token = await storageProvider.readLoginDetails();
  //   if (token == null) {}
  //   final url =
  //       Uri.parse('${ApiConfig.apiUrl}${ApiConstants.brand}?page=$brandpage');
  //
  //   final response = await http.get(
  //     url,
  //     headers: {
  //       'Authorization': 'Bearer $token',
  //     },
  //   );
  //
  //   return response;
  // }
  //
  // Future<Response?> addBrands({
  //   required String? brandName,
  //   required String? brandStatus,
  //   required String? seoUrl,
  //   required String? isFeatured,
  //   required String? descriptions,
  //   required File? imageFile,
  //   required File? logoFile,
  // }) async {
  //   final token = await storageProvider.readLoginDetails();
  //   final url = '${ApiConfig.apiUrl}${ApiConstants.brandCreate}';
  //
  //   // Create Dio instance
  //   Dio dio = Dio();
  //
  //   // Set headers
  //   dio.options.headers = {
  //     'Authorization': 'Bearer $token',
  //   };
  //
  //   var formData = FormData.fromMap({
  //     'image': await MultipartFile.fromFile(imageFile!.path,
  //         filename: imageFile.path),
  //     'brand_logo':
  //         await MultipartFile.fromFile(logoFile!.path, filename: logoFile.path),
  //     'status': brandStatus,
  //     'names': brandName,
  //     'descriptions': descriptions,
  //     'seo_url': seoUrl,
  //     'is_featured': isFeatured
  //   });
  //
  //   Response response = await dio.post(
  //     url,
  //     data: formData,
  //   );
  //
  //   return response;
  // }
  //
  // Future<http.Response> editBrands(int brandId) async {
  //   final token = await storageProvider.readLoginDetails();
  //   if (token == null) {}
  //   final url =
  //       Uri.parse('${ApiConfig.apiUrl}${ApiConstants.brandedit}/$brandId');
  //
  //   final response = await http.get(
  //     url,
  //     headers: {
  //       'Authorization': 'Bearer $token',
  //     },
  //   );
  //
  //   return response;
  // }
  //
  // Future<Response?> updateBrands({
  //   required int? brandId,
  //   required String? categoryName,
  //   required String? categoryStatus,
  //   required String? seoUrl,
  //   required String? descriptions,
  //   required String? parentCategory,
  //   required File? imageFile,
  //   required File? imageFile2,
  // }) async {
  //   final token = await storageProvider.readLoginDetails();
  //   final url = '${ApiConfig.apiUrl}${ApiConstants.brandUpdate}/$brandId';
  //
  //   // Create Dio instance
  //   Dio dio = Dio();
  //   var formData = FormData();
  //   // Set headers
  //   dio.options.headers = {
  //     'Authorization': 'Bearer $token',
  //   };
  //   //print(imageFile);
  //   //print(imageFile2);
  //   //print(categoryName);
  //   //print(descriptions);
  //   //print(seoUrl);
  //   //print(categoryStatus);
  //   //print(brandId);
  //
  //   if (imageFile == null && imageFile2 == null) {
  //     //  print('1111');
  //     formData = FormData.fromMap({
  //       // 'parent_category': parentCategory,
  //       // 'order_number': 0,
  //       'names': categoryName,
  //       'description': descriptions,
  //       'seo_url': seoUrl,
  //       'status': categoryStatus,
  //       'is_featured': 1,
  //     });
  //   } else if (imageFile == null) {
  //     //  print('2222');
  //     formData = FormData.fromMap({
  //       'brand_logo': await MultipartFile.fromFile(imageFile2!.path,
  //           filename: imageFile2.path),
  //       'names': categoryName,
  //       'description': descriptions,
  //       'seo_url': seoUrl,
  //       'status': categoryStatus,
  //       'is_featured': 1,
  //     });
  //   } else if (imageFile2 == null) {
  //     //  print('33333');
  //     formData = FormData.fromMap({
  //       'image': await MultipartFile.fromFile(imageFile.path,
  //           filename: imageFile.path),
  //       'names': categoryName,
  //       'description': descriptions,
  //       'seo_url': seoUrl,
  //       'status': categoryStatus,
  //       'is_featured': 1,
  //     });
  //   } else {
  //     // print('44444');
  //     formData = FormData.fromMap({
  //       'image': await MultipartFile.fromFile(imageFile.path,
  //           filename: imageFile.path),
  //       'brand_logo': await MultipartFile.fromFile(imageFile2.path,
  //           filename: imageFile2.path),
  //       'names': categoryName,
  //       'description': descriptions,
  //       'seo_url': seoUrl,
  //       'status': categoryStatus,
  //       'is_featured': 1,
  //     });
  //   }
  //
  //   try {
  //     Response response = await dio.post(
  //       url,
  //       data: formData,
  //     );
  //     return response;
  //   } catch (e) {
  //     if (e is DioException) {
  //       //print('DioException caught: ${e.response?.data}');
  //       //print('Status Code: ${e.response?.statusCode}');
  //       //print('Error Message: ${e.message}');
  //       return null;
  //     } else {
  //       //   print('Unexpected error: $e');
  //       return null; // Or handle the error appropriately
  //     }
  //   }
  // }
  //
  // Future<http.Response> deleteBrand(int brandId) async {
  //   final token = await storageProvider.readLoginDetails();
  //   if (token == null) {}
  //   final url =
  //       Uri.parse('${ApiConfig.apiUrl}${ApiConstants.brandDelete}/$brandId');
  //
  //   final response = await http.post(
  //     url,
  //     headers: {
  //       'Authorization': 'Bearer $token',
  //     },
  //   );
  //
  //   return response;
  // }
  //
  // Future<http.Response> loadCategories(int categoriesPage) async {
  //   final token = await storageProvider.readLoginDetails();
  //   if (token == null) {}
  //   final url = Uri.parse(
  //       '${ApiConfig.apiUrl}${ApiConstants.categories}?page=$categoriesPage');
  //
  //   final response = await http.get(
  //     url,
  //     headers: {
  //       'Authorization': 'Bearer $token',
  //     },
  //   );
  //
  //   return response;
  // }
  //
  // Future<Response?> addCategory({
  //   required String? parentCategory,
  //   required String? orderNumber,
  //   required String? categoryName,
  //   required String? categoryStatus,
  //   required String? seoUrl,
  //   required String? descriptions,
  //   required File? imageFile,
  //   required File? imageFile2,
  // }) async {
  //   final token = await storageProvider.readLoginDetails();
  //   final url = '${ApiConfig.apiUrl}${ApiConstants.categoiresCreate}';
  //
  //   // Create Dio instance
  //   Dio dio = Dio();
  //
  //   // Set headers
  //   dio.options.headers = {
  //     'Authorization': 'Bearer $token',
  //   };
  //
  //   var formData = FormData.fromMap({
  //     'image': await MultipartFile.fromFile(imageFile!.path,
  //         filename: imageFile.path),
  //     'image2': await MultipartFile.fromFile(imageFile2!.path,
  //         filename: imageFile2.path),
  //     'parent_category': parentCategory,
  //     'order_number': orderNumber,
  //     'names': categoryName,
  //     'descriptions': descriptions,
  //     'seo_url': seoUrl,
  //     'status': categoryStatus,
  //   });
  //
  //   Response response = await dio.post(
  //     url,
  //     data: formData,
  //   );
  //
  //   return response;
  // }
  //
  // Future<http.Response> editCategories(int categoryId) async {
  //   final token = await storageProvider.readLoginDetails();
  //   if (token == null) {}
  //   final url = Uri.parse(
  //       '${ApiConfig.apiUrl}${ApiConstants.categoryEdit}/$categoryId');
  //
  //   final response = await http.get(
  //     url,
  //     headers: {
  //       'Authorization': 'Bearer $token',
  //     },
  //   );
  //
  //   return response;
  // }
  //
  // Future<Response?> updateCategory({
  //   required int? categoryId,
  //   required String? categoryName,
  //   required String? categoryStatus,
  //   required String? seoUrl,
  //   required String? descriptions,
  //   required String? parentCategory,
  //   required File? imageFile,
  //   required File? imageFile2,
  // }) async {
  //   //  print('sc--$categoryStatus');
  //   final token = await storageProvider.readLoginDetails();
  //   final url = '${ApiConfig.apiUrl}${ApiConstants.categoryUpdate}/$categoryId';
  //   // print(url);
  //   // Create Dio instance
  //   Dio dio = Dio();
  //   var formData = FormData();
  //   // Set headers
  //   dio.options.headers = {
  //     'Authorization': 'Bearer $token',
  //   };
  //
  //   if (imageFile == null && imageFile2 == null) {
  //     formData = FormData.fromMap({
  //       'parent_category': parentCategory,
  //       'order_number': 0,
  //       'names': categoryName,
  //       'descriptions': descriptions,
  //       'seo_url': seoUrl,
  //       'status': categoryStatus,
  //     });
  //   } else if (imageFile == null) {
  //     formData = FormData.fromMap({
  //       'image2': await MultipartFile.fromFile(imageFile2!.path,
  //           filename: imageFile2.path),
  //       'parent_category': parentCategory,
  //       'order_number': 0,
  //       'names': categoryName,
  //       'descriptions': descriptions,
  //       'seo_url': seoUrl,
  //       'status': categoryStatus,
  //     });
  //   } else if (imageFile2 == null) {
  //     formData = FormData.fromMap({
  //       'image': await MultipartFile.fromFile(imageFile.path,
  //           filename: imageFile.path),
  //       'parent_category': parentCategory,
  //       'order_number': 0,
  //       'names': categoryName,
  //       'descriptions': descriptions,
  //       'seo_url': seoUrl,
  //       'status': categoryStatus,
  //     });
  //   } else {
  //     formData = FormData.fromMap({
  //       'image': await MultipartFile.fromFile(imageFile.path,
  //           filename: imageFile.path),
  //       'image2': await MultipartFile.fromFile(imageFile2.path,
  //           filename: imageFile2.path),
  //       'parent_category': parentCategory,
  //       'order_number': 0,
  //       'names': categoryName,
  //       'descriptions': descriptions,
  //       'seo_url': seoUrl,
  //       'status': categoryStatus,
  //     });
  //   }
  //   //print(formData.fields);
  //   //print(formData.files);
  //   try {
  //     Response response = await dio.post(
  //       url,
  //       data: formData,
  //     );
  //     // print('starus is ---${response.statusCode}');
  //     return response;
  //   } catch (e) {
  //     if (e is DioException) {
  //       //print('DioException caught: ${e.response?.data}');
  //       //print('Status Code: ${e.response?.statusCode}');
  //       //print('Error Message: ${e.message}');
  //       return null;
  //     } else {
  //       // print('Unexpected error: $e');
  //       return null; // Or handle the error appropriately
  //     }
  //   }
  // }
  //
  // Future<http.Response> deleteCategories(int categoryId) async {
  //   final token = await storageProvider.readLoginDetails();
  //   if (token == null) {}
  //   final url = Uri.parse(
  //       '${ApiConfig.apiUrl}${ApiConstants.categoryDelete}/$categoryId');
  //
  //   final response = await http.post(
  //     url,
  //     headers: {
  //       'Authorization': 'Bearer $token',
  //     },
  //   );
  //
  //   return response;
  // }
  //
  // Future<http.Response?> loadProducts(int productPage) async {
  //   final token = await storageProvider.readLoginDetails();
  //   print(token);
  //   if (token == null) {}
  //   final url = Uri.parse(
  //       '${ApiConfig.apiUrl}${ApiConstants.products}?page=$productPage');
  //   try {
  //     final response = await http.get(
  //       url,
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //       },
  //     );
  //     print(response.statusCode);
  //     return response;
  //   } catch (e) {
  //     print('error is--$e');
  //   }
  //   return null;
  // }
  //
  // Future<Response?> addProducts({
  //   required String? productName,
  //   required String? tag,
  //   required String? descriptions,
  //   required String? manufacturer,
  //   required String? mrp,
  //   required String? price,
  //   required String? stock,
  //   required String? isFeatured,
  //   required String? minQty,
  //   required List<XFile>? imagedatas,
  //   required String? returnPeriod,
  // }) async {
  //   final token = await storageProvider.readLoginDetails();
  //   final url = '${ApiConfig.apiUrl}${ApiConstants.productsCreate}';
  //
  //   Dio dio = Dio();
  //
  //   dio.options.headers = {
  //     'Authorization': 'Bearer $token',
  //   };
  //
  //   if (imagedatas == null || imagedatas.isEmpty) {
  //     throw Exception('No images provided for upload.');
  //   }
  //   var formData = FormData();
  //
  //   for (var image in imagedatas) {
  //     formData.files.add(
  //       MapEntry(
  //         'imagedatas[]',
  //         await MultipartFile.fromFile(image.path, filename: image.name),
  //       ),
  //     );
  //   }
  //   //   print('imaegs data is --${formData.files}');
  //
  //   // Add other fields
  //   formData.fields.addAll([
  //     MapEntry('store', '3'),
  //     MapEntry('name', productName ?? ''),
  //     MapEntry('tags', tag ?? 'tag'),
  //     MapEntry('descriptions', descriptions ?? ''),
  //     MapEntry('manufacturer', manufacturer ?? ''),
  //     MapEntry('mrp', mrp ?? ''),
  //     MapEntry('price', price ?? ''),
  //     MapEntry('stock', stock ?? ''),
  //     MapEntry('is_featured', isFeatured ?? ''),
  //     MapEntry('return_period', returnPeriod ?? ''),
  //     MapEntry('categories[0]', '1'),
  //     MapEntry('minqty', minQty ?? ''),
  //   ]);
  //   //print(formData.fields);
  //   //print(formData.files);
  //
  //   try {
  //     Response response = await dio.post(
  //       url,
  //       data: formData,
  //     );
  //     //  print(response.statusCode);
  //     return response;
  //   } catch (e) {
  //     //  print(',es--$e');
  //   }
  //   return null;
  // }
  //
  // // Future<Response?> addProductsNewOne({
  // //   required String? productName,
  // //   required String? tag,
  // //   required String? descriptions,
  // //   required String? manufacturer,
  // //   required String? mrp,
  // //   required String? price,
  // //   required String? stock,
  // //   required String? isFeatured,
  // //   required String? minQty,
  // //   required List<XFile>? imagedatas,
  // //   required String? returnPeriod,
  // // }) async {
  // //   final token = await storageProvider.readLoginDetails();
  // //   final url = '${ApiConfig.apiUrl}${ApiConstants.productsCreate}';
  //
  // //   if (imagedatas == null || imagedatas.isEmpty) {
  // //     throw Exception('No images provided for upload.');
  // //   }
  //
  // //   // Prepare headers
  // //   final headers = {'Authorization': 'Bearer $token'};
  //
  // //   // Prepare form data
  // //   var formData = FormData();
  //
  // //   // Add files to FormData
  // //   for (var image in imagedatas) {
  // //     formData.files.add(
  // //       MapEntry(
  // //         'imagedatas[]',
  // //         await MultipartFile.fromFile(image.path, filename: image.name),
  // //       ),
  // //     );
  // //   }
  //
  // //   // Add other fields
  // //   formData.fields.addAll([
  // //     MapEntry('store', '3'),
  // //     MapEntry('name', productName ?? ''),
  // //     MapEntry('tags', tag ?? ''),
  // //     MapEntry('descriptions', descriptions ?? ''),
  // //     MapEntry('manufacturer', manufacturer ?? ''),
  // //     MapEntry('mrp', mrp ?? ''),
  // //     MapEntry('price', price ?? ''),
  // //     MapEntry('stock', stock ?? ''),
  // //     MapEntry('is_featured', isFeatured ?? ''),
  // //     MapEntry('return_period', returnPeriod ?? ''),
  // //     MapEntry('categories[0]', '1'),
  // //     MapEntry('minqty', minQty ?? ''),
  // //   ]);
  //
  // //   // Initialize Dio
  // //   var dio = Dio();
  //
  // //   try {
  // //     // Send the request
  // //     final response = await dio.post(
  // //       url,
  // //       data: formData,
  // //       options: Options(
  // //         method: 'POST',
  // //         headers: headers,
  // //       ),
  // //     );
  //
  // //     if (response.statusCode == 200 || response.statusCode == 201) {
  // //       print('Upload successful!');
  // //       return response;
  // //     } else {
  // //       print('Failed to upload: ${response.statusMessage}');
  // //     }
  // //   } catch (e) {
  // //     print('Error during upload: $e');
  // //   }
  //
  // //   return null; // Return null if upload fails
  // // }
  //
  // Future<http.Response> deleteProducts(productId) async {
  //   final token = await storageProvider.readLoginDetails();
  //   final url = Uri.parse(
  //       '${ApiConfig.apiUrl}${ApiConstants.productsDelete}/$productId');
  //
  //   final response = await http.post(
  //     url,
  //     headers: {
  //       'Authorization': 'Bearer $token',
  //     },
  //   );
  //
  //   return response;
  // }
  //
  // Future<http.Response> loadEditProducts(int productId) async {
  //   final token = await storageProvider.readLoginDetails();
  //   if (token == null) {}
  //   final url = Uri.parse(
  //       '${ApiConfig.apiUrl}${ApiConstants.productsEditData}/$productId');
  //
  //   final response = await http.get(
  //     url,
  //     headers: {
  //       'Authorization': 'Bearer $token',
  //     },
  //   );
  //   return response;
  // }
  //
  // Future<Response?> updateProducts({
  //   required int productId,
  //   required String? productName,
  //   required String? tag,
  //   required String? descriptions,
  //   required String? manufacturer,
  //   required String? mrp,
  //   required String? price,
  //   required String? stock,
  //   required String? isfeatured,
  //   required String? minqty,
  //   required List<XFile>? imagedatas,
  //   required String? returnPeriod,
  // }) async {
  //   final token = await storageProvider.readLoginDetails();
  //   final url = '${ApiConfig.apiUrl}${ApiConstants.productUpdate}/$productId';
  //
  //   Dio dio = Dio();
  //
  //   // Set headers
  //   dio.options.headers = {
  //     'Authorization': 'Bearer $token',
  //   };
  //   var formData = FormData();
  //
  //   for (var image in imagedatas!) {
  //     formData.files.add(
  //       MapEntry(
  //         'imagedatas[]',
  //         await MultipartFile.fromFile(image.path, filename: image.name),
  //       ),
  //     );
  //   }
  //
  //   formData.fields.addAll([
  //     MapEntry('store', '3'),
  //     MapEntry(
  //       'name',
  //       productName!,
  //     ),
  //     MapEntry('tags', tag!),
  //     MapEntry('descriptions', descriptions!),
  //     MapEntry('manufacturer', manufacturer!),
  //     MapEntry('mrp', mrp!),
  //     MapEntry('price', price!),
  //     MapEntry('stock', stock!),
  //     MapEntry('is_featured', isfeatured!),
  //     MapEntry('return_period', returnPeriod!),
  //     MapEntry('is_show_in_list', '1'),
  //     MapEntry('categories[0]', '1'),
  //     MapEntry('minqty', minqty!),
  //   ]);
  //   // var formData = FormData.fromMap({
  //   //   'files': [
  //   //     // ignore: unnecessary_null_comparison
  //   //     if (imagedatas != null)
  //   //       await MultipartFile.fromFile(imagedatas.path,
  //   //           filename: imagedatas.path),
  //   //   ],
  //   //   'store': '3',
  //   //   'name': productName,
  //   //   'tags': tag,
  //   //   'descriptions': descriptions,
  //   //   'manufacturer': manufacturer,
  //   //   'mrp': mrp,
  //   //   'price': price,
  //   //   'stock': stock,
  //   //   'is_featured': isfeatured,
  //   //   'return_period': returnPeriod,
  //   //   'is_show_in_list': '1',
  //   //   'categories[0]': '1',
  //   //   'minqty': minqty,
  //   // });
  //   //print(formData.fields);
  //   //print(formData.files);
  //   Response response = await dio.post(
  //     url,
  //     data: formData,
  //   );
  //   //  print(response.statusCode);
  //   return response;
  // }
  //
  // Future<http.Response> loadOrdersData(int productPage) async {
  //   final token = await storageProvider.readLoginDetails();
  //   if (token == null) {}
  //   //  print(token);
  //   final url = Uri.parse(
  //       '${ApiConfig.apiUrl}${ApiConstants.orders}?page=$productPage');
  //
  //   final response = await http.get(
  //     url,
  //     headers: {
  //       'Authorization': 'Bearer $token',
  //     },
  //   );
  //
  //   return response;
  // }
  //
  // Future<OrderDetails?> getOrderDetails({required int orderId}) async {
  //   final token = await storageProvider.readLoginDetails();
  //   if (token == null) {}
  //   final url =
  //       Uri.parse('${ApiConfig.apiUrl}${ApiConstants.orderView}$orderId');
  //
  //   try {
  //     final response = await http.get(
  //       url,
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //       },
  //     );
  //     //  print(response.statusCode);
  //     if (response.statusCode == 200) {
  //       final responseData = json.decode(response.body);
  //       if (responseData['status'] == 1) {
  //         return orderDetailsFromJson(response.body);
  //       }
  //     }
  //   } catch (e) {
  //     //  print(',es--$e');
  //   }
  //
  //   return null;
  // }
  //
  // Future<http.Response> updateOrders(int orderID, int orderStatus) async {
  //   final token = await storageProvider.readLoginDetails();
  //   if (token == null) {
  //     throw Exception("User not logged in");
  //   }
  //
  //   // Construct the URL without query parameters
  //   final url =
  //       Uri.parse('${ApiConfig.apiUrl}${ApiConstants.orderStatusUpdate}');
  //
  //   // Create the body for the POST request
  //   final body = {
  //     'order_id': orderID.toString(),
  //     'status': orderStatus.toString(),
  //     'reason': 'xyz',
  //     'type': 'order',
  //   };
  //
  //   // Send the POST request
  //   final response = await http.post(
  //     url,
  //     headers: {
  //       'Authorization': 'Bearer $token',
  //       'Content-Type': 'application/json',
  //     },
  //
  //     body: jsonEncode(body), // Encode the body as JSON
  //   );
  //   // print(response.statusCode);
  //   return response;
  // }
  //
  // //
  // Future<Response?> removeProductImage({
  //   required String? productId,
  //   required String? productImageId,
  // }) async {
  //   final token = await storageProvider.readLoginDetails();
  //   final url =
  //       '${ApiConfig.apiUrl}${ApiConstants.removerProductImage}$productId?image_id=$productImageId';
  //   // print(url);
  //   Dio dio = Dio();
  //
  //   dio.options.headers = {
  //     'Authorization': 'Bearer $token',
  //     'Content-Type': 'application/json',
  //   };
  //
  //   try {
  //     Response response = await dio.post(url, options: Options());
  //     //print("Response Status Code: ${response.statusCode}");
  //     //print(response.statusCode);
  //     return response;
  //   } catch (e) {
  //     //  print(',es--$e');
  //   }
  //   return null;
  // }

  // Future<http.Response?> removeProductImage({
  //   required String? productId,
  //   required String? productImageId,
  // }) async {
  //   final token = await storageProvider.readLoginDetails();
  //   if (token == null) {
  //     throw Exception("User not logged in");
  //   }
  //
  //   // Construct the URL without query parameters
  //   final url = Uri.parse(
  //       '${ApiConfig.apiUrl}${ApiConstants.removerProductImage}$productId?image_id=$productImageId');
  //   print(url);
  //   // Send the POST request
  //   try {
  //     final response = await http.post(
  //       url,
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //         'Content-Type': 'application/json',
  //       },
  //     );
  //     print(response.statusCode);
  //     return response;
  //   } catch (e) {
  //     print('error is ---$e');
  //   }
  //   return null;
  // }
}
