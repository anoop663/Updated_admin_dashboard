// ignore_for_file: deprecated_member_use, unused_local_variable, unnecessary_import


import 'package:file_picker/file_picker.dart';
import 'package:flatten/controllers/apps/ecommerce/add_product_controller.dart';
import 'package:flatten/controllers/apps/ecommerce/product_controller.dart';
import 'package:flatten/data/api_configs.dart';
import 'package:flatten/helpers/extensions/string.dart';
import 'package:flatten/helpers/theme/app_style.dart';
import 'package:flatten/helpers/utils/mixins/ui_mixin.dart';
import 'package:flatten/helpers/utils/my_shadow.dart';
import 'package:flatten/helpers/widgets/my_breadcrumb.dart';
import 'package:flatten/helpers/widgets/my_breadcrumb_item.dart';
import 'package:flatten/helpers/widgets/my_button.dart';
import 'package:flatten/helpers/widgets/my_card.dart';
import 'package:flatten/helpers/widgets/my_flex.dart';
import 'package:flatten/helpers/widgets/my_flex_item.dart';
import 'package:flatten/helpers/widgets/my_spacing.dart';
import 'package:flatten/helpers/widgets/my_text.dart';
import 'package:flatten/helpers/widgets/my_text_style.dart';
import 'package:flatten/models/product_edit_response_model.dart' as edit;
import 'package:flatten/views/apps/ecommerce/network_image.dart';
import 'package:flatten/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late AddProductController controller;

  final formKey = GlobalKey<FormState>();
  late TextEditingController productNameController;
  late TextEditingController descriptionsController;
  late TextEditingController tagController;
  late TextEditingController mrpController;
  late TextEditingController priceController;
  late TextEditingController stockController;
  late TextEditingController minqtyController;
  late TextEditingController returnperiodController;

  @override
  void initState() {
    super.initState();
    controller = Get.put(AddProductController());
    controller.selectedImages.clear();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller = Get.put(AddProductController());

    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    edit.ProductEditResponse? data;
    final productId = args?['id'];
    if (args != null && args['data'] != null) {
      data = args['data'];
    }

    if (productId != null) {
      productNameController =
          TextEditingController(text: data!.data!.languages.first.name);
      descriptionsController =
          TextEditingController(text: data.data!.languages.first.description);
      tagController = TextEditingController(
          text: data.data!.languages.first.tags ?? 'no tag');
      mrpController =
          TextEditingController(text: data.data!.stores.first.defaultPrice);
      priceController =
          TextEditingController(text: data.data!.stores.first.currentPrice);
      stockController =
          TextEditingController(text: data.data!.stores.first.stock);
      minqtyController =
          TextEditingController(text: data.data!.stores.first.minQuantity);
      returnperiodController = TextEditingController(
          text: data.data!.stores.first.returnPeriod.toString());
    } else {
      productNameController = TextEditingController();
      descriptionsController = TextEditingController();
      tagController = TextEditingController();
      mrpController = TextEditingController();
      priceController = TextEditingController();
      stockController = TextEditingController();
      minqtyController = TextEditingController();
      returnperiodController = TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    edit.ProductEditResponse? data;
    final productId = args?['id'];
    if (args != null && args['data'] != null) {
      data = args['data'];
    }

    Future<void> pickImage() async {
      try {
        if (kIsWeb) {
          FilePickerResult? result = await FilePicker.platform.pickFiles(
            type: FileType.image,
            allowMultiple: true,
          );

          if (result != null && result.files.isNotEmpty) {
            // Append new images instead of replacing the list
            controller.selectedImages
                .addAll(result.files.map((file) => file.bytes!).toList());
            controller.update();
          }
        }
      } catch (e) {
        debugPrint('Error picking image: $e');
      }
    }

    return Layout(
      child: GetBuilder<AddProductController>(
        init: controller,
        builder: (controller) {
          return Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: MySpacing.x(flexSpacing),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText.titleMedium(
                        'Add Product',
                        fontSize: 18,
                        fontWeight: 600,
                      ),
                      MyBreadcrumb(
                        children: [
                          MyBreadcrumbItem(name: 'ecommerce'.tr()),
                          MyBreadcrumbItem(
                            name: 'add_product'.tr().capitalizeWords,
                            active: true,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                MySpacing.height(flexSpacing),
                Padding(
                  padding: MySpacing.x(flexSpacing / 2),
                  child: MyFlex(
                    children: [
                      MyFlexItem(
                        sizes: "lg-8 md-12",
                        child: MyCard(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shadow: MyShadow(
                              elevation: 0.5,
                              position: MyShadowPosition.bottom),
                          paddingAll: 0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                // width: double.infinity,
                                color: colorScheme.primary.withOpacity(0.08),
                                padding: MySpacing.xy(16, 12),
                                child: Row(
                                  children: [
                                    Icon(
                                      LucideIcons.server,
                                      color: contentTheme.primary,
                                      size: 16,
                                    ),
                                    MySpacing.width(12),
                                    MyText.titleMedium(
                                      "general".tr(),
                                      fontWeight: 600,
                                      color: colorScheme.primary,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: MySpacing.xy(flexSpacing, 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyText.labelMedium(
                                      'Product Details',
                                    ),
                                    MySpacing.height(8),
                                    TextFormField(
                                      controller: productNameController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Product name is required';
                                        } else {
                                          return null;
                                        }
                                      },
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        hintText: "Product name",
                                        hintStyle:
                                            MyTextStyle.bodySmall(xMuted: true),
                                        border: outlineInputBorder,
                                        enabledBorder: outlineInputBorder,
                                        focusedBorder: focusedInputBorder,
                                        contentPadding: MySpacing.all(16),
                                        isCollapsed: true,
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                      ),
                                    ),
                                    MySpacing.height(8),
                                    TextFormField(
                                      controller: descriptionsController,
                                      maxLines: 2,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Description is required';
                                        } else {
                                          return null;
                                        }
                                      },
                                      // onChanged: (value) =>
                                      //     controller.discriptions = value,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        hintText: "Product Description",
                                        hintStyle:
                                            MyTextStyle.bodySmall(xMuted: true),
                                        border: outlineInputBorder,
                                        enabledBorder: outlineInputBorder,
                                        focusedBorder: focusedInputBorder,
                                        contentPadding: MySpacing.all(16),
                                        isCollapsed: true,
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                      ),
                                    ),
                                    MySpacing.height(8),
                                    TextFormField(
                                      controller: tagController,
                                      maxLines: 1,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Description is required';
                                        } else {
                                          return null;
                                        }
                                      },
                                      // onChanged: (value) =>
                                      //     controller.discriptions = value,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        hintText: "Product tag",
                                        hintStyle:
                                            MyTextStyle.bodySmall(xMuted: true),
                                        border: outlineInputBorder,
                                        enabledBorder: outlineInputBorder,
                                        focusedBorder: focusedInputBorder,
                                        contentPadding: MySpacing.all(16),
                                        isCollapsed: true,
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                      ),
                                    ),
                                    MySpacing.height(25),
                                    MyText.labelMedium(
                                      'Pricing And Stock',
                                    ),
                                    MySpacing.height(8),
                                    TextFormField(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Enter Maximum Price';
                                        } else {
                                          return null;
                                        }
                                      },
                                      keyboardType: TextInputType.number,
                                      controller: mrpController,
                                      decoration: InputDecoration(
                                        hintText: "Maximum Price",
                                        hintStyle:
                                            MyTextStyle.bodySmall(xMuted: true),
                                        border: outlineInputBorder,
                                        enabledBorder: outlineInputBorder,
                                        focusedBorder: focusedInputBorder,
                                        contentPadding: MySpacing.all(16),
                                        isCollapsed: true,
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                      ),
                                    ),
                                    MySpacing.height(8),
                                    TextFormField(
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Selling Price';
                                        } else {
                                          return null;
                                        }
                                      },
                                      controller: priceController,
                                      decoration: InputDecoration(
                                        hintText: "Enter Selling Price",
                                        hintStyle:
                                            MyTextStyle.bodySmall(xMuted: true),
                                        border: outlineInputBorder,
                                        enabledBorder: outlineInputBorder,
                                        focusedBorder: focusedInputBorder,
                                        contentPadding: MySpacing.all(16),
                                        isCollapsed: true,
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                      ),
                                    ),
                                    MySpacing.height(8),
                                    TextFormField(
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Enter Stock ';
                                        } else {
                                          return null;
                                        }
                                      },
                                      controller: stockController,
                                      decoration: InputDecoration(
                                        hintText: "Stock",
                                        hintStyle:
                                            MyTextStyle.bodySmall(xMuted: true),
                                        border: outlineInputBorder,
                                        enabledBorder: outlineInputBorder,
                                        focusedBorder: focusedInputBorder,
                                        contentPadding: MySpacing.all(16),
                                        isCollapsed: true,
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                      ),
                                    ),
                                    productId != null
                                        ? GetBuilder<AddProductController>(
                                          builder: (ctrl) {
                                            return Column(
                                                children: [
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  SizedBox(
                                                    height: 120,
                                                    child: ListView.separated(
                                                      separatorBuilder:
                                                          (context, index) =>
                                                              SizedBox(
                                                        width: 10,
                                                      ),
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      shrinkWrap: true,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Stack(
                                                          children: [
                                                            NetworkImageWidget(
                                                                width: 100,
                                                                imageUrl:
                                                                    '${ApiConfig.productImageUrl}${ctrl.productData?.images![index].image ?? ''}'),
                                                            // controller
                                                            //             .productData
                                                            //             ?.images![
                                                            //                 index]
                                                            //             .isDefault ==
                                                            //         1
                                                            //     ? SizedBox()
                                                            //     : Positioned(
                                                            //         right: 4,
                                                            //         top: -2,
                                                            //         child:
                                                            //             IconButton(
                                                            //           onPressed:
                                                            //               () {
                                                            //             var ctrl =
                                                            //                 AddProductController();
                                                            //             ctrl.removeProductImage(
                                                            //                 productImageId: ctrl
                                                            //                     .productData
                                                            //                     ?.images![
                                                            //                         index]
                                                            //                     .id,
                                                            //                 productId: ctrl
                                                            //                     .productData
                                                            //                     ?.data
                                                            //                     ?.id);
                                                            //           },
                                                            //           icon:
                                                            //               const Icon(
                                                            //             Icons.close,
                                                            //             color: Colors
                                                            //                 .red,
                                                            //           ),
                                                            //         ),
                                                            //       ),
                                                            // controller.removeImageId ==
                                                            //         controller
                                                            //             .productData!
                                                            //             .images![
                                                            //                 index]
                                                            //             .id
                                                            //             .toString()
                                                            //     ? Container(
                                                            //         height: 120,
                                                            //         width: 100,
                                                            //         decoration:
                                                            //             BoxDecoration(
                                                            //           color: Colors
                                                            //               .grey
                                                            //               .withOpacity(
                                                            //                   .8),
                                                            //           borderRadius:
                                                            //               BorderRadius
                                                            //                   .circular(
                                                            //                       10),
                                                            //         ),
                                                            //         child: Center(
                                                            //             child:
                                                            //                 CircularProgressIndicator()),
                                                            //       )
                                                            //     : const SizedBox(),
                                                          ],
                                                        );
                                                      },
                                                      itemCount: controller
                                                              .productData
                                                              ?.images
                                                              ?.length ??
                                                          0,
                                                    ),
                                                  ),
                                                ],
                                              );
                                          }
                                        )
                                        : SizedBox(),
                                    const SizedBox(height: 16),
                                    Card(
                                      elevation: 4,
                                      margin: const EdgeInsets.only(bottom: 16),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Product Images",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                            ElevatedButton.icon(
                                              onPressed: pickImage,
                                              icon: const Icon(
                                                  Icons.add_photo_alternate),
                                              label: const Text('Pick Images'),
                                              style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                            controller.selectedImages.isNotEmpty
                                                ? GridView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    gridDelegate:
                                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 3,
                                                      crossAxisSpacing: 8,
                                                      mainAxisSpacing: 8,
                                                    ),
                                                    itemCount: controller
                                                        .selectedImages.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Stack(
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            child: Image.memory(
                                                              controller
                                                                      .selectedImages[
                                                                  index],
                                                              fit: BoxFit.cover,
                                                              width: double
                                                                  .infinity,
                                                              height: double
                                                                  .infinity,
                                                            ),
                                                          ),
                                                          Positioned(
                                                            right: 4,
                                                            top: 4,
                                                            child: IconButton(
                                                              onPressed: () {
                                                                controller
                                                                    .selectedImages
                                                                    .removeAt(
                                                                        index);
                                                                controller
                                                                    .update(); // Call update to refresh UI
                                                              },
                                                              icon: const Icon(
                                                                Icons.close,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  )
                                                : const Center(
                                                    child: Text(
                                                      'No images selected.',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.grey),
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    MySpacing.height(20),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        MyButton.text(
                                          onPressed: () {},
                                          padding: MySpacing.xy(20, 16),
                                          splashColor: contentTheme.secondary
                                              .withOpacity(0.1),
                                          child: MyText.bodySmall(
                                            'cancel'.tr(),
                                          ),
                                        ),
                                        MySpacing.width(12),
                                        productId == null
                                            ? MyButton(
                                                onPressed: () async {
                                                  if (formKey.currentState!
                                                      .validate()) {
                                                    final status =
                                                        await controller
                                                            .createProductData(
                                                      context: context,
                                                      productName:
                                                          productNameController
                                                              .text,
                                                      descriptions:
                                                          descriptionsController
                                                              .text,
                                                      tag: tagController.text,
                                                      price:
                                                          priceController.text,
                                                      mrp: mrpController.text,
                                                      stock:
                                                          stockController.text,
                                                      returnPeriod:
                                                          returnperiodController
                                                              .text,
                                                      minqty:
                                                          minqtyController.text,
                                                      manufacturer: '1',
                                                      imagedatas: controller
                                                          .selectedImages,
                                                      isfeatured: '1',
                                                    );
                                                    if (status) {
                                                      productNameController
                                                          .clear();
                                                      descriptionsController
                                                          .clear();
                                                      tagController.clear();
                                                      mrpController.clear();
                                                      priceController.clear();
                                                      stockController.clear();
                                                      minqtyController.clear();
                                                      returnperiodController
                                                          .clear();
                                                      var ctrl = Get.put(
                                                          EcommerceProductController());
                                                      ctrl.fetchProductData(
                                                          page: 1);
                                                    }
                                                  }
                                                },
                                                elevation: 0,
                                                padding: MySpacing.xy(20, 16),
                                                backgroundColor:
                                                    contentTheme.primary,
                                                borderRadiusAll: AppStyle
                                                    .buttonRadius.medium,
                                                child: MyText.bodySmall(
                                                  controller.isLoading
                                                      ? 'Loading..'
                                                      : 'save'.tr(),
                                                  color: contentTheme.onPrimary,
                                                ),
                                              )
                                            : MyButton(
                                                onPressed: () async {
                                                  if (formKey.currentState!
                                                      .validate()) {
                                                    final status =
                                                        await controller
                                                            .updateProductData(
                                                      productId: productId,
                                                      context: context,
                                                      productName:
                                                          productNameController
                                                              .text,
                                                      descriptions:
                                                          descriptionsController
                                                              .text,
                                                      tag: tagController.text,
                                                      price:
                                                          priceController.text,
                                                      mrp: mrpController.text,
                                                      stock:
                                                          stockController.text,
                                                      returnPeriod:
                                                          returnperiodController
                                                              .text,
                                                      minqty:
                                                          minqtyController.text,
                                                      manufacturer: '1',
                                                      imagedatas: controller
                                                          .selectedImages,
                                                      isfeatured: '1',
                                                    );
                                                    if(status){
                                                      var ctrl=Get.put(EcommerceProductController());
                                                      ctrl.fetchProductData(page: ctrl.currentPage);
                                                    }
                                                  }
                                                },
                                                elevation: 0,
                                                padding: MySpacing.xy(20, 16),
                                                backgroundColor:
                                                    contentTheme.primary,
                                                borderRadiusAll: AppStyle
                                                    .buttonRadius.medium,
                                                child: MyText.bodySmall(
                                                  controller.isLoading
                                                      ? 'Loading..'
                                                      : 'Update'.tr(),
                                                  color: contentTheme.onPrimary,
                                                ),
                                              ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
