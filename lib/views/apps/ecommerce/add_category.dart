// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flatten/controllers/apps/ecommerce/edit_products_controller.dart';
import 'package:flatten/controllers/apps/ecommerce/products_controller.dart';
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
import 'package:flatten/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:get/instance_manager.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
class AddCategoryPage extends StatefulWidget {
  const AddCategoryPage({super.key});

  @override
  State<AddCategoryPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddCategoryPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late AddProductsController controller;

  final formKey = GlobalKey<FormState>();
  final categoryNameController = TextEditingController();
  final descriptionsController = TextEditingController();
  final seoUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller = Get.put(AddProductsController());
    controller.status = '1';
    controller.image=null;
    controller.image2=null;
    controller.webImage=null;
    controller.webImage2=null;

  }

  @override
  Widget build(BuildContext context) {
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
        } else {
          // Mobile file picker
          final picker = ImagePicker();
          final pickedFile = await picker.pickImage(source: ImageSource.gallery);

          if (pickedFile != null) {
            final selectedImage = File(pickedFile.path);
            if (isLogo) {
              controller.image2 = selectedImage;
            } else {
              controller.image = selectedImage;
            }
            controller.update(); // Notify GetX UI update
          }
        }
      } catch (e) {
        debugPrint('Error picking image: $e');
      }
    }
    return Layout(
      child: GetBuilder<AddProductsController>(
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
                        'Add Category',
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
                                      'Category name',
                                    ),
                                    MySpacing.height(8),
                                    TextFormField(
                                      controller: categoryNameController,
                                      validator: (value) => value!.isEmpty
                                          ? 'Category name is required'
                                          : null,
                                      onChanged: (value) {
                                        controller.name = value;
                                      },
                                      keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                        hintText: "eg: Category name",
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
                                      validator: (value) => value!.isEmpty
                                          ? 'Description is required'
                                          : null,
                                      onChanged: (value) =>
                                          controller.discriptions = value,
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
                                      onChanged: (value) =>
                                          controller.seourl = value,
                                      keyboardType: TextInputType.multiline,
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
                                      'Category Image',
                                    ),

                                    const SizedBox(height: 16),
                                    Card(
                                      elevation: 4,
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          children: [
                                            ListTile(
                                              title: const Text('Category Image'),
                                              trailing: ElevatedButton(
                                                onPressed: () async => await pickImage(false),
                                                child: const Text('Choose File'),
                                              ),
                                              subtitle: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  if (controller.image != null || controller.webImage != null)
                                                    Column(
                                                      children: [
                                                        Text(
                                                          'Selected: ${controller.image != null ? controller.image!.path.split('/').last : "Web Image"}',
                                                        ),
                                                        const SizedBox(height: 8),
                                                        controller.image != null
                                                            ? Image.file(
                                                          controller.image!,
                                                          width: 100,
                                                          height: 100,
                                                          fit: BoxFit.cover,
                                                        )
                                                            : Image.memory(
                                                          controller.webImage!,
                                                          width: 100,
                                                          height: 100,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ],
                                                    )
                                                  else
                                                    const Text('No image selected'),
                                                ],
                                              ),
                                            ),
                                            const Divider(),
                                            ListTile(
                                              title: const Text('Category 2nd Image'),
                                              trailing: ElevatedButton(
                                                onPressed: () async => await pickImage(true),
                                                child: const Text('Choose File'),
                                              ),
                                              subtitle: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  if (controller.image2 != null || controller.webImage2 != null)
                                                    Column(
                                                      children: [
                                                        Text(
                                                          'Selected: ${controller.image2 != null ? controller.image2!.path.split('/').last : "Web Image"}',
                                                        ),
                                                        const SizedBox(height: 8),
                                                        controller.image2 != null
                                                            ? Image.file(
                                                          controller.image2!,
                                                          width: 100,
                                                          height: 100,
                                                          fit: BoxFit.cover,
                                                        )
                                                            : Image.memory(
                                                          controller.webImage2!,
                                                          width: 100,
                                                          height: 100,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ],
                                                    )
                                                  else
                                                    const Text('No image selected'),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),


                                    // MyText.labelMedium(
                                    //   "status".tr(),
                                    // ),
                                    // MySpacing.height(4),
                                    // Row(
                                    //   children: [
                                    //     Expanded(
                                    //       child: Wrap(
                                    //           spacing: 16,
                                    //           children: Status.values
                                    //               .map(
                                    //                 (gender) => InkWell(
                                    //                   onTap: () => controller
                                    //                       .onChangeGender(
                                    //                           gender),
                                    //                   child: Row(
                                    //                     mainAxisSize:
                                    //                         MainAxisSize.min,
                                    //                     children: [
                                    //                       Radio<Status>(
                                    //                         value: gender,
                                    //                         activeColor: theme
                                    //                             .colorScheme
                                    //                             .primary,
                                    //                         groupValue: controller
                                    //                             .selectedGender,
                                    //                         onChanged: controller
                                    //                             .onChangeGender,
                                    //                         visualDensity:
                                    //                             getCompactDensity,
                                    //                         materialTapTargetSize:
                                    //                             MaterialTapTargetSize
                                    //                                 .shrinkWrap,
                                    //                       ),
                                    //                       MySpacing.width(8),
                                    //                       MyText.labelMedium(
                                    //                         gender.name
                                    //                             .capitalize!,
                                    //                       ),
                                    //                     ],
                                    //                   ),
                                    //                 ),
                                    //               )
                                    //               .toList()),
                                    //     )
                                    //   ],
                                    // ),
                                    // MySpacing.height(25),
                                    // MyText.labelMedium(
                                    //   "tags".tr(),
                                    // ),
                                    // MySpacing.height(8),
                                    // Container(
                                    //   alignment: Alignment.topLeft,
                                    //   child: TextFormField(
                                    //     maxLines: 3,
                                    //     validator: controller.basicValidator
                                    //         .getValidation('tags'),
                                    //     controller: controller.basicValidator
                                    //         .getController('tags'),
                                    //     keyboardType: TextInputType.multiline,
                                    //     decoration: InputDecoration(
                                    //       hintText:
                                    //           "fruits, vegetables, grocery, healthy, etc",
                                    //       hintStyle: MyTextStyle.bodySmall(
                                    //           xMuted: true),
                                    //       border: outlineInputBorder,
                                    //       enabledBorder: outlineInputBorder,
                                    //       focusedBorder: focusedInputBorder,
                                    //       contentPadding: MySpacing.all(16),
                                    //       isCollapsed: true,
                                    //       floatingLabelBehavior:
                                    //           FloatingLabelBehavior.never,
                                    //     ),
                                    //   ),
                                    // ),
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
                                        MyButton(
                                          onPressed: () async {
                                            print(controller.name);
                                            if (formKey.currentState!
                                                .validate()) {
                                              print('create api');
                                              final status = await controller
                                                  .createCateogryData(
                                                categoryName: categoryNameController.text,
                                                categoryStatus: controller.status,
                                                descriptions: descriptionsController.text,
                                                seoUrl: seoUrlController.text,
                                                imageFile: kIsWeb ? controller.webImage : controller.image, // Web or Mobile image
                                                logoFile: kIsWeb ? controller.webImage2 : controller.image2, // Web or Mobile logo
                                              );

                                              if (status && context.mounted) {
                                                Get.find<
                                                        EcommerceProductsController>()
                                                    .fetchCategoryData();
                                                Navigator.pop(context);
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                      content: Text(
                                                          controller.message)),
                                                );
                                              }
                                            }
                                          },
                                          elevation: 0,
                                          padding: MySpacing.xy(20, 16),
                                          backgroundColor: contentTheme.primary,
                                          borderRadiusAll:
                                              AppStyle.buttonRadius.medium,
                                          child: MyText.bodySmall(
                                            controller.createCategoryLoading
                                                ? 'Loading..'
                                                : 'save'.tr(),
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
