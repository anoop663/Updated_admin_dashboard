import 'package:flatten/controllers/apps/ecommerce/invoice_controller.dart';
import 'package:flatten/helpers/theme/app_style.dart';
import 'package:flatten/helpers/utils/mixins/ui_mixin.dart';
import 'package:flatten/helpers/widgets/my_breadcrumb.dart';
import 'package:flatten/helpers/widgets/my_breadcrumb_item.dart';
import 'package:flatten/helpers/widgets/my_button.dart';
import 'package:flatten/helpers/widgets/my_container.dart';
import 'package:flatten/helpers/widgets/my_flex.dart';
import 'package:flatten/helpers/widgets/my_flex_item.dart';
import 'package:flatten/helpers/widgets/my_spacing.dart';
import 'package:flatten/helpers/widgets/my_text.dart';
import 'package:flatten/images.dart';
import 'package:flatten/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage({super.key});

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage>
    with SingleTickerProviderStateMixin, UIMixin {
  late InvoiceController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(InvoiceController());
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium(
                      "Invoice",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: "Extra Pages"),
                        MyBreadcrumbItem(name: "Invoice", active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing / 4),
                child: MyFlex(
                  wrapAlignment: WrapAlignment.start,
                  wrapCrossAlignment: WrapCrossAlignment.start,
                  children: [
                    MyFlexItem(
                      sizes: "md-12",
                      child: MyContainer(
                        paddingAll: 0,
                        child: Padding(
                          padding: MySpacing.all(24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        Images.logoIcon,
                                        height: 16,
                                      ),
                                      MySpacing.width(8),
                                      MyText.titleMedium("Flatten"),
                                    ],
                                  ),
                                  MyText.titleMedium("Invoice"),
                                ],
                              ),
                              MySpacing.height(40),
                              MyFlexItem(
                                sizes: "lg-6 md-12",
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    MyText.bodyMedium(
                                      "Hello, Denish Navadiya",
                                      fontWeight: 600,
                                    ),
                                    Wrap(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                MyText.bodySmall(
                                                  "Order Date :",
                                                  fontWeight: 600,
                                                ),
                                                MySpacing.height(8),
                                                MyText.bodySmall(
                                                  "Order Status :",
                                                  fontWeight: 600,
                                                ),
                                                MySpacing.height(8),
                                                MyText.bodySmall(
                                                  "Order No. :",
                                                  fontWeight: 600,
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                MyText.bodySmall(
                                                  "May 10, 2023",
                                                ),
                                                MySpacing.height(8),
                                                MyContainer(
                                                  paddingAll: 2,
                                                  color: contentTheme.primary,
                                                  child: MyText.bodySmall(
                                                    "Paid",
                                                    fontSize: 10,
                                                    color:
                                                        contentTheme.onPrimary,
                                                  ),
                                                ),
                                                MySpacing.height(8),
                                                MyText.bodySmall(
                                                  "#000047",
                                                  fontWeight: 600,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              MySpacing.height(30),
                              MyFlexItem(
                                sizes: "lg-6 md-12",
                                child: Wrap(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            MyText.bodyMedium(
                                              "Billing Address",
                                              fontWeight: 600,
                                            ),
                                            MySpacing.height(4),
                                            MyText.bodySmall("Apple Head"),
                                            MySpacing.height(4),
                                            MyText.bodySmall(
                                                "4006 S Lamar Blvd #650"),
                                            MySpacing.height(4),
                                            MyText.bodySmall(
                                                "Austin, Austin 78704"),
                                            MySpacing.height(4),
                                            MyText.bodySmall(
                                                "P: (512) 474-5433"),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            MyText.bodyMedium(
                                              "Shipping Address",
                                              fontWeight: 600,
                                            ),
                                            MySpacing.height(4),
                                            MyText.bodySmall("Denish Navadiya"),
                                            MySpacing.height(4),
                                            MyText.bodySmall("75 E Ramapo Ave"),
                                            MySpacing.height(4),
                                            MyText.bodySmall(
                                                "Mahwah, New Mexico 07430"),
                                            MySpacing.height(4),
                                            MyText.bodySmall(
                                                "P: (201) 512-1141"),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              MySpacing.height(40),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: MyContainer.none(
                                  borderRadiusAll: 0,
                                  child: DataTable(
                                    sortAscending: true,
                                    // dataRowHeight: 80,
                                    dataRowMaxHeight: 80,
                                    columns: [
                                      DataColumn(
                                        label: MyText.labelLarge(
                                          "#",
                                          color: contentTheme.primary,
                                        ),
                                      ),
                                      DataColumn(
                                        label: MyText.labelLarge(
                                          "Item",
                                          color: contentTheme.primary,
                                        ),
                                      ),
                                      DataColumn(
                                        label: MyText.labelLarge(
                                          "Hours",
                                          color: contentTheme.primary,
                                        ),
                                      ),
                                      DataColumn(
                                        label: MyText.labelLarge(
                                          "Hours Rate",
                                          color: contentTheme.primary,
                                        ),
                                      ),
                                      DataColumn(
                                        label: MyText.labelLarge(
                                          "Total",
                                          color: contentTheme.primary,
                                        ),
                                      ),
                                    ],
                                    rows: [
                                      DataRow(
                                        cells: [
                                          DataCell(
                                            MyText(
                                              "1",
                                            ),
                                          ),
                                          DataCell(
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                MyText.bodyMedium(
                                                  "Flutter Admin",
                                                  fontWeight: 600,
                                                ),
                                                MyText.bodySmall(
                                                    "2 Pages static website - flatten"),
                                              ],
                                            ),
                                          ),
                                          DataCell(
                                            MyText(
                                              "10",
                                            ),
                                          ),
                                          DataCell(
                                            MyText(
                                              "\$28",
                                            ),
                                          ),
                                          DataCell(
                                            MyText(
                                              "\$280",
                                            ),
                                          ),
                                        ],
                                      ),
                                      DataRow(
                                        cells: [
                                          DataCell(
                                            MyText(
                                              "2",
                                            ),
                                          ),
                                          DataCell(
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                MyText.bodyMedium(
                                                  "Flutter Development",
                                                  fontWeight: 600,
                                                ),
                                                MyText.bodySmall(
                                                    "It's invoice web"),
                                              ],
                                            ),
                                          ),
                                          DataCell(
                                            MyText(
                                              "45",
                                            ),
                                          ),
                                          DataCell(
                                            MyText(
                                              "\$12",
                                            ),
                                          ),
                                          DataCell(
                                            MyText(
                                              "\$540",
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              MySpacing.height(22),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MyText.bodySmall(
                                        "Sub Total:",
                                        fontWeight: 600,
                                      ),
                                      MySpacing.width(12),
                                      MyText.bodySmall(
                                        "Discount (20%):",
                                        fontWeight: 600,
                                      ),
                                    ],
                                  ),
                                  MySpacing.height(12),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      MyText.bodySmall(
                                        "\$820",
                                        fontWeight: 600,
                                      ),
                                      MySpacing.width(12),
                                      MyText.bodySmall(
                                        "\$164",
                                        fontWeight: 600,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              MySpacing.height(12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  MyText(
                                    "\$656 USD",
                                    fontWeight: 700,
                                    fontSize: 22,
                                  ),
                                ],
                              ),
                              MySpacing.height(22),
                              MyText.bodySmall(
                                "Notes:",
                                fontWeight: 600,
                              ),
                              Row(
                                children: [
                                  MyContainer.none(
                                    width: 250,
                                    child: MyText.bodySmall(
                                      controller.dummyTexts[1],
                                      maxLines: 2,
                                      muted: true,
                                    ),
                                  ),
                                ],
                              ),
                              MySpacing.height(22),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  MyButton(
                                    onPressed: () {},
                                    elevation: 0,
                                    padding: MySpacing.xy(20, 16),
                                    backgroundColor: contentTheme.primary,
                                    borderRadiusAll:
                                        AppStyle.buttonRadius.medium,
                                    child: Row(
                                      children: [
                                        Icon(
                                          LucideIcons.pencil,
                                          size: 14,
                                        ),
                                        MySpacing.width(8),
                                        MyText.bodySmall(
                                          'Print',
                                          color: contentTheme.onPrimary,
                                        ),
                                      ],
                                    ),
                                  ),
                                  MySpacing.width(8),
                                  MyButton(
                                    onPressed: () {},
                                    elevation: 0,
                                    padding: MySpacing.xy(20, 16),
                                    backgroundColor: contentTheme.success,
                                    borderRadiusAll:
                                        AppStyle.buttonRadius.medium,
                                    child: MyText.bodySmall(
                                      'Submit',
                                      color: contentTheme.onPrimary,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
