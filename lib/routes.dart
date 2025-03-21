import 'package:flatten/helpers/services/auth_service.dart';

import 'package:flatten/views/apps/ecommerce/add_product.dart';
import 'package:flatten/views/apps/ecommerce/customers.dart';
import 'package:flatten/views/apps/ecommerce/products.dart';

import 'package:flatten/views/auth/locked.dart';
import 'package:flatten/views/auth/login.dart';

import 'package:flatten/views/crm_dashboard_screen.dart';
import 'package:flatten/views/dashboard.dart';


import 'package:flatten/views/ui/buttons.dart';
import 'package:flatten/views/ui/cards.dart';
import 'package:flatten/views/ui/carousels.dart';
import 'package:flatten/views/ui/dialogs.dart';

import 'package:flatten/views/ui/drag_drop.dart';

import 'package:flatten/views/apps/ecommerce/invoice_page.dart';


import 'package:flatten/views/apps/ecommerce/product_detail.dart';
import 'package:flatten/views/ui/tabs.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';


class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    return AuthService.isLoggedIn ? null : RouteSettings(name: '/auth/login');
  }
}

getPageRoute() {
  var routes = [
    GetPage(
        name: '/',
        page: () => DashboardPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/dashboard',
        page: () => DashboardPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/crm/dashboard',
        page: () => CrmDashboardScreen(),
        middlewares: [AuthMiddleware()]),
   
    GetPage(name: '/auth/login', page: () => LoginPage()),

    GetPage(
        name: '/auth/locked',
        page: () => LockedPage(),
        middlewares: [AuthMiddleware()]),

    ///========== Apps =================///
    GetPage(
        name: '/apps/ecommerce/products',
        page: () => EcommerceProductsPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/apps/ecommerce/add_product',
        page: () => AddProductPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/apps/ecommerce/customers',
        page: () => CustomersPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/apps/ecommerce/product-detail',
        page: () => ProductDetailPage(),
        middlewares: [AuthMiddleware()]),
   
    GetPage(
        name: '/apps/ecommerce/invoice',
        page: () => InvoicePage(),
        middlewares: [AuthMiddleware()]),
    
   
   
    ///========== UI =================///

    GetPage(
        name: '/ui/buttons',
        page: () => ButtonsPage(),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: '/ui/cards',
        page: () => CardsPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/ui/tabs',
        page: () => TabsPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/ui/dialogs',
        page: () => DialogsPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/ui/carousels',
        page: () => CarouselsPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/ui/drag_drop',
        page: () => DragDropPage(),
        middlewares: [AuthMiddleware()]),

    ///========== Forms =================///

   
  
    
  ];

  return routes
      .map((e) => GetPage(
          name: e.name,
          page: e.page,
          middlewares: e.middlewares,
          transition: Transition.noTransition))
      .toList();
}
