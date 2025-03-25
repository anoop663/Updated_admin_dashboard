// ignore_for_file: deprecated_member_use, unused_import, unnecessary_import, avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flatten/controllers/apps/ecommerce/add_brand_controller.dart';
import 'package:flatten/controllers/apps/ecommerce/barnd_controler.dart';
import 'package:flatten/controllers/apps/ecommerce/edit_category_controller.dart';
import 'package:flatten/controllers/apps/ecommerce/category_controller.dart';
import 'package:flatten/helpers/extensions/string.dart';
import 'package:flatten/helpers/theme/app_style.dart';
import 'package:flatten/helpers/utils/mixins/ui_mixin.dart';
import 'package:flatten/helpers/utils/my_shadow.dart';
import 'package:flatten/helpers/widgets/my_breadcrumb.dart';
import 'package:flatten/helpers/widgets/my_breadcrumb_item.dart';
import 'package:flatten/helpers/widgets/my_button.dart';
import 'package:flatten/helpers/widgets/my_card.dart';
import 'package:flatten/helpers/widgets/my_container.dart';
import 'package:flatten/helpers/widgets/my_flex.dart';
import 'package:flatten/helpers/widgets/my_flex_item.dart';
import 'package:flatten/helpers/widgets/my_spacing.dart';
import 'package:flatten/helpers/widgets/my_text.dart';
import 'package:flatten/helpers/widgets/my_text_style.dart';
import 'package:flatten/models/edit_brand_response.dart';
import 'package:flatten/views/apps/ecommerce/network_image.dart';
import 'package:flatten/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:get/instance_manager.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';

class AddBrandPage extends StatefulWidget {
  const AddBrandPage({super.key});

  @override
  State<AddBrandPage> createState() => _AddBrandPageState();
}

class _AddBrandPageState extends State<AddBrandPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late AddBrandController controller;

  final formKey = GlobalKey<FormState>();
  late TextEditingController brandNameController;
  late TextEditingController descriptionsController;
  late TextEditingController seoUrlController;

  @override
  void initState() {
    super.initState();
    controller = Get.put(AddBrandController());
    controller.webImage = null;
    controller.webImage2 = null;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller = Get.put(AddBrandController());

    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    BrandEditData? data;
    final brandId = args?['id'];
    if (args != null && args['data'] != null) {
      data = args['data'];
    }

    if (brandId != null) {
      brandNameController =
          TextEditingController(text: data?.languages.first.name ?? '');
      descriptionsController =
          TextEditingController(text: data?.languages.first.description ?? '');
      seoUrlController = TextEditingController(text: data?.slug ?? '');
      controller.status = data?.status.toString();
    } else {
      brandNameController = TextEditingController();
      descriptionsController = TextEditingController();
      seoUrlController = TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    BrandEditData? data;
    final brandId = args?['id'];
    if (args != null && args['data'] != null) {
      data = args['data'];
    }
    Future<void> pickImage(bool isLogo) async {
      try {
        if (kIsWeb) {
          FilePickerResult? result = await FilePicker.platform.pickFiles(
            type: FileType.image,
          );

          if (result != null && result.files.single.bytes != null) {
            Uint8List imageBytes = result.files.single.bytes!; // Web-compatible
            if (isLogo) {
              controller.webImage2 = imageBytes; // Store for web
            } else {
              controller.webImage = imageBytes;
            }
            controller.update(); // Notify GetX UI update
          }
        }
      } catch (e) {
        debugPrint('Error picking image: $e');
      }
    }

    return Layout(
      child: GetBuilder<AddBrandController>(
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
                        'Add Brand',
                        fontSize: 18,
                        fontWeight: 600,
                      ),
                      MyBreadcrumb(
                        children: [
                          MyBreadcrumbItem(name: 'ecommerce'.tr()),
                          MyBreadcrumbItem(
                            name: 'Add Brand'.tr().capitalizeWords,
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
                                      'Brand name',
                                    ),
                                    MySpacing.height(8),
                                    TextFormField(
                                      controller: brandNameController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Brand name is required';
                                        } else {
                                          return null;
                                        }
                                      },
                                      // onChanged: (value) {
                                      //   controller.name = value;
                                      // },
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        hintText: "eg: Brand name",
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
                                    MyFlex(contentPadding: false, children: [
                                      MyFlexItem(
                                          sizes: 'lg-6 md-12',
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              MyText.labelMedium(
                                                'Status',
                                              ),
                                              MySpacing.height(8),
                                              DropdownButtonFormField<String>(
                                                value: controller.status,
                                                dropdownColor:
                                                    colorScheme.surface,
                                                menuMaxHeight: 200,
                                                isDense: true,
                                                items: [
                                                  DropdownMenuItem<String>(
                                                    value: '1',
                                                    child: Text('Active'),
                                                  ),
                                                  DropdownMenuItem<String>(
                                                    value: '0',
                                                    child: Text('Inactive'),
                                                  ),
                                                ],
                                                decoration: InputDecoration(
                                                  hintText: "Status",
                                                  hintStyle:
                                                      MyTextStyle.bodySmall(
                                                          xMuted: true),
                                                  border: outlineInputBorder,
                                                  enabledBorder:
                                                      outlineInputBorder,
                                                  focusedBorder:
                                                      focusedInputBorder,
                                                  contentPadding:
                                                      MySpacing.all(14),
                                                  isCollapsed: true,
                                                  floatingLabelBehavior:
                                                      FloatingLabelBehavior
                                                          .never,
                                                ),
                                                onChanged: (String? value) {
                                                  if (value != null) {
                                                    controller.status =
                                                        value; // Set the new value
                                                  }
                                                },
                                                validator: (value) {
                                                  return value == null ||
                                                          value.isEmpty
                                                      ? 'Status is required'
                                                      : null;
                                                },
                                              )
                                            ],
                                          )),
                                    ]),
                                    MySpacing.height(25),
                                    MyText.labelMedium(
                                      'Description',
                                    ),
                                    MySpacing.height(8),
                                    TextFormField(
                                      controller: descriptionsController,
                                      maxLines: 3,
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
                                        hintText: "",
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
                                      'SEO URL',
                                    ),
                                    MySpacing.height(8),
                                    TextFormField(
                                      controller: seoUrlController,
                                      // onChanged: (value) =>
                                      //     controller.seourl = value,
                                      // keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        hintText: "",
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
                                      'Brand Image',
                                    ),

                                    const SizedBox(height: 16),
                                    Card(
                                      elevation: 4,
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          children: [
                                            ListTile(
                                              title: const Text('Brand Image'),
                                              trailing: ElevatedButton(
                                                onPressed: () async =>
                                                    await pickImage(false),
                                                child:
                                                    const Text('Choose File'),
                                              ),
                                              subtitle: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    children: [
                                                      const SizedBox(height: 8),
                                                      (controller.webImage !=
                                                          null &&
                                                          controller
                                                              .webImage!
                                                              .isNotEmpty)
                                                          ? Image.memory(
                                                        controller
                                                            .webImage!,
                                                        width: 100,
                                                        height: 100,
                                                        fit: BoxFit.cover,
                                                      )
                                                          : (data?.image !=
                                                          null &&
                                                          data!.image
                                                              .isNotEmpty)
                                                          ? NetworkImageWidget(
                                                          imageUrl:
                                                          'https://swan.alisonsnewdemo.online/images/manufacturer/${data.image}')
                                                          : const Text(
                                                          'No image selected'),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            const Divider(),
                                            ListTile(
                                              title:
                                                  const Text('Brand 2nd Image'),
                                              trailing: ElevatedButton(
                                                onPressed: () async =>
                                                    await pickImage(true),
                                                child:
                                                    const Text('Choose File'),
                                              ),
                                              subtitle:  Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(height: 8),
                                                  (controller.webImage2 !=
                                                      null &&
                                                      controller
                                                          .webImage2!
                                                          .isNotEmpty)
                                                      ? Image.memory(
                                                    controller
                                                        .webImage2!,
                                                    width: 100,
                                                    height: 100,
                                                    fit: BoxFit.cover,
                                                  )
                                                      : (data?.brandLogo !=
                                                      null &&
                                                      data!.brandLogo
                                                          .isNotEmpty)
                                                      ? NetworkImageWidget(
                                                      imageUrl:
                                                      'https://swan.alisonsnewdemo.online/images/manufacturer/brandlogo/${data.brandLogo}')
                                                      : const Text(
                                                      'No image selected'),
                                                ],
                                              )
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
                                        brandId == null
                                            ? MyButton(
                                                onPressed: () async {
                                                  // print(controller.name);
                                                  if (formKey.currentState!
                                                      .validate()) {
                                                    print('create api');
                                                    final status = await controller.createBrandData1(
                                                        context: context,
                                                        brandName:
                                                            brandNameController
                                                                .text,
                                                        isFeatured:
                                                            AddBrandController()
                                                                .isfeatured,
                                                        brandStatus:
                                                            controller.status,
                                                        descriptions:
                                                            descriptionsController
                                                                .text,
                                                        seoUrl: seoUrlController
                                                            .text
                                                        // imageFile: controller
                                                        //     .webImage, // Web or Mobile image
                                                        // logoFile: controller
                                                        //     .webImage2, // Web or Mobile logo
                                                        );
                                                    if (status) {
                                                      brandNameController
                                                          .clear();
                                                      descriptionsController
                                                          .clear();
                                                      seoUrlController.clear();
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
                                                  // print(controller.name);
                                                  if (formKey.currentState!
                                                      .validate()) {

                                                    final status = await controller.updateBrand(
                                                      brandId: brandId,
                                                        context: context,
                                                        brandName:
                                                            brandNameController
                                                                .text,
                                                        isFeatured:
                                                            AddBrandController()
                                                                .isfeatured,
                                                        brandStatus:
                                                            controller.status,
                                                        descriptions:
                                                            descriptionsController
                                                                .text,
                                                        seoUrl: seoUrlController
                                                            .text

                                                        );
                                                    if (status) {

                                                      var ctrl=Get.put(EcommerceBrandController());
                                                    ctrl.fetchBrandData(page: ctrl.currentPage);
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
