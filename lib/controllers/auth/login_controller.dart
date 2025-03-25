// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flatten/controllers/my_controller.dart';
import 'package:flatten/data/api_provider.dart';
import 'package:flatten/helpers/services/storage/local_storage.dart';
import 'package:flatten/helpers/widgets/my_form_validator.dart';
import 'package:flatten/helpers/widgets/my_validators.dart';
import 'package:flatten/models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends MyController {
  MyFormValidator basicValidator = MyFormValidator();

  bool showPassword = false, loading = false;

  TextEditingController emailCtrl =
      TextEditingController(text: 'admin@ecommerce.alisonsgroup.com');
  TextEditingController passwordCtrl = TextEditingController(text: 'Admin@987');

  @override
  void onInit() {
    super.onInit();
    basicValidator.addField('email',
        required: true,
        label: "Email",
        validators: [MyEmailValidator()],
        controller: emailCtrl);

    basicValidator.addField('password',
        required: true,
        label: "Password",
        validators: [MyLengthValidator(min: 6, max: 10)],
        controller: passwordCtrl);
  }

  // UI
  void onChangeShowPassword() {
    showPassword = !showPassword;
    update();
  }

  static bool isLoggedIn = false;
  // Services
  Future<void> onLogin() async {
    loading = true;
    update();
    LoginModel loginModel = LoginModel(
      email: emailCtrl.text,
      password: passwordCtrl.text,
    );
    try {
      final response = await AuthService().loginUser(loginModel.toJson());
      print('responce iss---${response.statusCode}');
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print('responcedasdf iss---$responseData');
        if (responseData['status'] == 1) {
          // Store token in secure storage
          String token = responseData['token'];
          await LocalStorage().storeLoginDetails(token);

          // Use context.mounted to avoid issues with asynchronous navigation
          print('1111-----${ModalRoute.of(Get.context!)?.settings.name}');
          await LocalStorage.setLoggedInUser(true);
          String nextUrl =
              Uri.parse(ModalRoute.of(Get.context!)?.settings.name ?? "")
                      .queryParameters['next'] ??
                  "/dashboard";
          print('next url---$nextUrl');
          Get.toNamed(
           '/dashboard'
          );
          loading = false;
          update();
        } else {
          if (Get.context!.mounted) {
            ScaffoldMessenger.of(Get.context!).showSnackBar(
              SnackBar(
                  content: Text(responseData['message'] ?? 'Login failed')),
            );
          }
        }
      } else {
        if (Get.context!.mounted) {
          ScaffoldMessenger.of(Get.context!).showSnackBar(
            SnackBar(
                content: Text(
                    'Please check the Entered data: ${response.statusCode}')),
          );
        }
      }
    } catch (e) {
      loading = false;
      update();
      if (Get.context!.mounted) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text('Failed to login: $e')),
        );
      }
    }

    loading = false;
    update();
  }

  // Navigation
  void goToForgotPassword() {
    Get.toNamed('/auth/forgot_password');
  }

  void gotoRegister() {
    Get.toNamed('/auth/register');
  }
}
