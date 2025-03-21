import 'package:flatten/controllers/my_controller.dart';
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
}
