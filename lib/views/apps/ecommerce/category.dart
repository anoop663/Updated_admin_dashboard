// ignore_for_file: unused_import, unused_local_variable, avoid_print

import 'dart:convert';

import 'package:flatten/controllers/apps/ecommerce/edit_category_controller.dart';
import 'package:flatten/controllers/apps/ecommerce/category_controller.dart';
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

class EcommerceCategoryPage extends StatefulWidget {
  const EcommerceCategoryPage({super.key});

  @override
  _EcommerceProductsPageState createState() => _EcommerceProductsPageState();
}

class _EcommerceProductsPageState extends State<EcommerceCategoryPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late EcommerceCategoryController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(EcommerceCategoryController());
  }

  @override
  Widget build(BuildContext context) {
    AddProductsController ctrl = Get.put(AddProductsController());
    return Layout(
        child: GetBuilder<EcommerceCategoryController>(
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
                          'Category',
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
                            onPressed: controller.goToCreateProduct,
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
                                  'Create Category',
                                  color: contentTheme.onPrimary,
                                ),
                              ],
                            ),
                          ),
                          MySpacing.height(16),
                          controller.isLoading == true
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : MyCard(
                                  shadow: MyShadow(
                                      elevation: 0.5,
                                      position: MyShadowPosition.bottom),
                                  margin: MySpacing.x(flexSpacing),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      MySpacing.height(16),
                                      SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: DataTable(
                                            sortAscending: true,
                                            onSelectAll: (_) => {},
                                            headingRowColor:
                                                WidgetStatePropertyAll(
                                                    contentTheme.primary
                                                        .withAlpha(40)),
                                            // dataRowHeight: 60,
                                            dataRowMaxHeight: 60,
                                            showBottomBorder: false,
                                            columns: [
                                              DataColumn(
                                                  label: MyText.labelLarge(
                                                'id'.tr(),
                                                color: contentTheme.primary,
                                              )),
                                              DataColumn(
                                                  label: MyText.labelLarge(
                                                'name'.tr(),
                                                color: contentTheme.primary,
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
                                            rows: controller.categoryData
                                                .map((category) {
                                              return DataRow(cells: [
                                                DataCell(
                                                    Text('${category.id}')),
                                                DataCell(Text(category
                                                    .languages.first.name)),
                                                DataCell(
                                                  NetworkImageWidget(
                                                      width: 45,
                                                      height: 45,
                                                      imageUrl:
                                                          'https://swan.alisonsnewdemo.online/images/category/${category.image}'),
                                                ),
                                                DataCell(IconButton(
                                                  icon: const Icon(Icons.edit,
                                                      color: Colors.blue),
                                                  onPressed: () async {
                                                    final categoryId = category
                                                        .id; // Get the category ID

                                                    await AddProductsController()
                                                        .editCategory(
                                                            context: context,
                                                            categoryId:
                                                                categoryId);
                                                  },
                                                )),
                                                DataCell(
                                                  IconButton(
                                                    icon: const Icon(
                                                        Icons.delete,
                                                        color: Colors.red),
                                                    onPressed: () async {
                                                      final confirmed =
                                                          await showDialog<
                                                              bool>(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title: const Text(
                                                                'Confirm Delete'),
                                                            content: const Text(
                                                                'Are you sure you want to delete this category?'),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop(
                                                                          false); // Return false
                                                                },
                                                                child:
                                                                    const Text(
                                                                        'No'),
                                                              ),
                                                              ElevatedButton(
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                        backgroundColor:
                                                                            Colors.red),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop(
                                                                          true); // Return true
                                                                },
                                                                child:
                                                                    const Text(
                                                                        'Yes'),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );

                                                      if (confirmed == true) {
                                                        // Execute delete if confirmed
                                                        final success =
                                                            await AddProductsController()
                                                                .deleteCategory(
                                                          context: context,
                                                          categoryId:
                                                              category.id,
                                                        );

                                                        print(
                                                            'success ---$success');
                                                        if (success) {
                                                          controller
                                                              .fetchCategoryData(page: controller.currentPage,needLoading: false);
                                                        }
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ]);
                                            }).toList(),
                                          )),
                                      _buildPaginationControls(controller),
                                    ],
                                  ),
                                )
                        ],
                      )),
                ],
              );
            }));
  }

  Widget _buildPaginationControls(
      EcommerceCategoryController categoryProvider) {
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
