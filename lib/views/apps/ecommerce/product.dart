// ignore_for_file: unused_import, unused_local_variable

import 'package:flatten/controllers/apps/ecommerce/add_brand_controller.dart';
import 'package:flatten/controllers/apps/ecommerce/add_product_controller.dart';
import 'package:flatten/controllers/apps/ecommerce/barnd_controler.dart';
import 'package:flatten/controllers/apps/ecommerce/edit_category_controller.dart';
import 'package:flatten/controllers/apps/ecommerce/category_controller.dart';
import 'package:flatten/controllers/apps/ecommerce/product_controller.dart';
import 'package:flatten/helpers/extensions/string.dart';
import 'package:flatten/helpers/theme/app_style.dart';
import 'package:flatten/helpers/utils/mixins/ui_mixin.dart';
import 'package:flatten/helpers/utils/my_shadow.dart';
import 'package:flatten/helpers/utils/utils.dart';
import 'package:flatten/helpers/widgets/my_breadcrumb.dart';
import 'package:flatten/helpers/widgets/my_breadcrumb_item.dart';
import 'package:flatten/helpers/widgets/my_button.dart';
import 'package:flatten/helpers/widgets/my_card.dart';
import 'package:flatten/helpers/widgets/my_container.dart';
import 'package:flatten/helpers/widgets/my_list_extension.dart';
import 'package:flatten/helpers/widgets/my_spacing.dart';
import 'package:flatten/helpers/widgets/my_text.dart';
import 'package:flatten/images.dart';
import 'package:flatten/views/apps/ecommerce/network_image.dart';
import 'package:flatten/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:provider/provider.dart';

class EcommerceProductPage extends StatefulWidget {
  const EcommerceProductPage({super.key});

  @override
  _EcommerceProductPageState createState() => _EcommerceProductPageState();
}

class _EcommerceProductPageState extends State<EcommerceProductPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late EcommerceProductController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(EcommerceProductController());
  }

  @override
  Widget build(BuildContext context) {
    AddProductsController ctrl = Get.put(AddProductsController());
    return Layout(
        child: GetBuilder<EcommerceProductController>(
            init: controller,
            builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: MySpacing.x(flexSpacing),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText.titleMedium(
                          'Product',
                          fontSize: 18,
                          fontWeight: 600,
                        ),
                        MyBreadcrumb(
                          children: [
                            MyBreadcrumbItem(name: 'ecommerce'.tr()),
                            MyBreadcrumbItem(
                                name: 'products'.tr(), active: true),
                          ],
                        ),
                      ],
                    ),
                  ),
                  MySpacing.height(flexSpacing),
                  MyCard(
                      shadow: MyShadow(
                          elevation: 0.5, position: MyShadowPosition.bottom),
                      margin: MySpacing.x(flexSpacing),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          MyButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/apps/ecommerce/add_product');
                            },
                            elevation: 0,
                            padding: MySpacing.xy(20, 16),
                            backgroundColor: contentTheme.primary,
                            borderRadiusAll: AppStyle.buttonRadius.medium,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  LucideIcons.plus,
                                  size: 20,
                                  color: contentTheme.onPrimary,
                                ),
                                MySpacing.width(8),
                                MyText.labelMedium(
                                  'Create Product',
                                  color: contentTheme.onPrimary,
                                ),
                              ],
                            ),
                          ),
                          MySpacing.height(16),
                          controller.isLoading == true
                              ? Center(
                            child: CircularProgressIndicator(),
                          ):        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MyContainer.none(
                                borderRadiusAll: 4,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: DataTable(
                                  sortAscending: true,
                                  onSelectAll: (_) => {},
                                  headingRowColor: WidgetStatePropertyAll(
                                      contentTheme.primary.withAlpha(40)),
                                  // dataRowHeight: 60,
                                  dataRowMaxHeight: 60,
                                  showBottomBorder: false,
                                  columns: [
                                    DataColumn(
                                        label: Expanded(
                                          child: MyText.labelLarge(
                                            'Product id'.tr(),
                                            color: contentTheme.primary,
                                          ),
                                        )),
                                    DataColumn(
                                        label: Expanded(
                                          child: MyText.labelLarge(
                                            'Product Name'.tr(),
                                            color: contentTheme.primary,
                                          ),
                                        )),
                                    DataColumn(
                                        label: MyText.labelLarge(
                                          'Photo'.tr(),
                                          color: contentTheme.primary,
                                        )),
                                    DataColumn(
                                        label: MyText.labelLarge(
                                          'Edit'.tr(),
                                          color: contentTheme.primary,
                                        )),
                                    DataColumn(
                                        label: Flexible(
                                          child: MyText.labelLarge(
                                            'Delete',
                                            color: contentTheme.primary,
                                          ),
                                        )),
                                  ],
                                  rows: controller.productData.map((product) {
                                    return DataRow(cells: [
                                      DataCell(Text('${product.id}')),
                                      DataCell(Text(product.name)),
                                      DataCell(NetworkImageWidget(
                                          width: 45,
                                          height: 45,
                                          imageUrl:
                                          'https://swan.alisonsnewdemo.online//images/product/thumbnail/${product.image}'),),
                                      DataCell(IconButton(
                                        icon: const Icon(Icons.edit,
                                            color: Colors.blue),
                                        onPressed: () async {
                                            final productId = product.id;
                                            final ctrl =
                                            Get.put(AddProductController());
                                            final success = await ctrl
                                                .fetchEditProductData(productId: productId,context: context);

                                        },
                                      )),
                                      DataCell(
                                        IconButton(
                                          icon: const Icon(Icons.delete,
                                              color: Colors.red),
                                          onPressed: () async {
                                            final confirmed =
                                            await showDialog<bool>(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      'Confirm Delete'),
                                                  content: const Text(
                                                      'Are you sure you want to delete this Product?'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context).pop(
                                                            false);
                                                      },
                                                      child: const Text('No'),
                                                    ),
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                          backgroundColor:
                                                          Colors.red),
                                                      onPressed: () {
                                                        Navigator.of(context).pop(
                                                            true); // Return true
                                                      },
                                                      child: const Text('Yes'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );

                                            if (confirmed == true) {
                                              // Execute delete if confirmed

                                       await EcommerceProductController()
                                                  .deleteProduct(
                                                context: context,
                                               productId : product.id,
                                              );


                                            }
                                          },
                                        ),
                                      ),
                                    ]);
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                          controller.isLoading == true
                              ? SizedBox():    _buildPaginationControls(controller),
                        ],
                      )),
                ],
              );
            }));
  }

  Widget _buildPaginationControls(EcommerceProductController categoryProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.first_page),
            onPressed: categoryProvider.currentPage > 1
                ? () => categoryProvider.goToPage(1)
                : null,
          ),
          IconButton(
            icon: const Icon(Icons.navigate_before),
            onPressed: categoryProvider.currentPage > 1
                ? () =>
                categoryProvider.goToPage(categoryProvider.currentPage - 1)
                : null,
          ),
          Text(
            'Page ${categoryProvider.currentPage} of ${categoryProvider.lastPage}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: const Icon(Icons.navigate_next),
            onPressed: categoryProvider.currentPage < categoryProvider.lastPage
                ? () =>
                categoryProvider.goToPage(categoryProvider.currentPage + 1)
                : null,
          ),
          IconButton(
            icon: const Icon(Icons.last_page),
            onPressed: categoryProvider.currentPage < categoryProvider.lastPage
                ? () => categoryProvider.goToPage(categoryProvider.lastPage)
                : null,
          ),
        ],
      ),
    );
  }
}
