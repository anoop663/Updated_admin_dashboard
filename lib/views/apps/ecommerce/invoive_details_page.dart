// ignore_for_file: unused_import

import 'package:flatten/controllers/apps/ecommerce/ccommerce_invoice_controller.dart';
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
import 'package:intl/intl.dart';

class InvoiceDetailsPage extends StatefulWidget {
  const InvoiceDetailsPage({super.key});

  @override
  State<InvoiceDetailsPage> createState() => _InvoiceDetailsPageState();
}

class _InvoiceDetailsPageState extends State<InvoiceDetailsPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late EcommerceInvoiceController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(EcommerceInvoiceController());
  }

  @override
  Widget build(BuildContext context) {
    var data = controller.orderDetails?.data;
    final statusOptions = [
      {"status_id": 1, "status_text": "Order Placed"},
      {"status_id": 3, "status_text": "Cancelled"},
      {"status_id": 6, "status_text": "Returned"},
      {"status_id": 7, "status_text": "Delivered"},
      {"status_id": 8, "status_text": "Cancel Requested"},
      {"status_id": 10, "status_text": "Shipped"},
      {"status_id": 18, "status_text": "Out of stock"},
      {"status_id": 19, "status_text": "Ready for collection"},
      {"status_id": 20, "status_text": "Collected"},
      {"status_id": 50, "status_text": "Return Requested"},
    ];
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
                                        'assets/images/logo/logo.png',
                                        height:25,
                                      ),
                                      MySpacing.width(8),
                                      MyText.titleMedium("SoluStyle"),
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
                                      "Hello, ${data?.billingName}",
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

                                                  "${ DateFormat('dd MMM yyyy').format(DateTime.parse(data?.createdAt.toString() ?? ''))}",
                                                ),
                                                MySpacing.height(8),
                                                MyContainer(
                                                  paddingAll: 2,
                                                  color: Colors.white,
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8.0,
                                                    ), // Adjust padding
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors
                                                              .grey), // Adds a border
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0), // Rounds the border
                                                    ),
                                                    child:
                                                        DropdownButton<String>(
                                                      value: data?.orderStatus,
                                                      dropdownColor:
                                                          Colors.white,
                                                      onChanged: (newStatus) {
                                                        // print(newStatus);
                                                        if (newStatus != null) {
                                                          // Map newStatus (status_text) to its corresponding status_id
                                                          final statusId =
                                                              statusOptions
                                                                  .firstWhere(
                                                            (status) =>
                                                                status[
                                                                    'status_text'] ==
                                                                newStatus,
                                                            orElse: () => {
                                                              "status_id": -1
                                                            }, // Use a default value for 'status_id'
                                                          )['status_id'];

                                                          if (statusId != -1) {
                                                            // setState(() {
                                                            data?.orderStatus =
                                                                newStatus;
                                                            // });
                                                            controller
                                                                .updateOrderStatus(
                                                                    orderId: data
                                                                        ?.id,
                                                                    currentStatus:
                                                                        statusId
                                                                            as int, // Explicitly cast to int if needed
                                                                    isFromDetails:
                                                                        true);
                                                          } else {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              const SnackBar(
                                                                content: Text(
                                                                    "Invalid status selected."),
                                                              ),
                                                            );
                                                          }
                                                        }
                                                      },
                                                      items: statusOptions
                                                          .map((status) =>
                                                              DropdownMenuItem<
                                                                  String>(
                                                                value: status[
                                                                        'status_text']
                                                                    .toString(),
                                                                child: Text(status[
                                                                        'status_text']
                                                                    .toString()),
                                                              ))
                                                          .toList(),
                                                      underline:
                                                          const SizedBox(), // Removes the default underline
                                                      isDense:
                                                          true, // Reduces the internal height of the dropdown
                                                    ),
                                                  ),
                                                ),
                                                MySpacing.height(8),
                                                MyText.bodySmall(
                                                  "${data?.invoiceNumber}",
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
                                            MyText.bodySmall(
                                                data!.billingAddress??''),
                                            MySpacing.height(4),
                                            MyText.bodySmall(
                                                "${data.billingCity},${data.billingAreaNumber}"),
                                            MySpacing.height(4),
                                            MyText.bodySmall(
                                                data.billingCountry),
                                            MySpacing.height(4),
                                            MyText.bodySmall(
                                                "P: ${data.billingPhone}"),
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
                                            MyText.bodySmall(
                                                "${data.shippingName}"),
                                            MySpacing.height(4),
                                            MyText.bodySmall(
                                                "    ${data.shippingAddress}, ${data.shippingCity},${data.shippingAreaNumber}"),
                                            MySpacing.height(4),
                                            MyText.bodySmall(
                                                "${data.shippingCountry},${data.billingAreaNumber}"),
                                            MySpacing.height(4),
                                            MyText.bodySmall(
                                                "P: ${data.shippingPhone}"),
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
                                          "Name of Item",
                                          color: contentTheme.primary,
                                        ),
                                      ),
                                      DataColumn(
                                        label: MyText.labelLarge(
                                          "Quantity",
                                          color: contentTheme.primary,
                                        ),
                                      ),
                                      DataColumn(
                                        label: MyText.labelLarge(
                                          "Tax",
                                          color: contentTheme.primary,
                                        ),
                                      ),
                                      DataColumn(
                                        label: MyText.labelLarge(
                                          "Amount",
                                          color: contentTheme.primary,
                                        ),
                                      ),
                                    ],
                                    rows: data.items.map((item) {
                                      return DataRow(
                                        cells: [
                                          DataCell(Text(item.id.toString())),
                                          DataCell(Text(item.productName)),
                                          DataCell(Text(item.quantity)),
                                          DataCell(Text(item.taxAmount)),
                                          DataCell(Text(item.amount)),
                                          // DataCell(Text(item.quantity)),
                                        ],
                                      );
                                    }).toList(),
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
                                        "Shipping Charge:",
                                        fontWeight: 600,
                                      ),
                                    ],
                                  ),
                                  MySpacing.height(12),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      MyText.bodySmall(
                                        "\$${data.orderTotalAmount}",
                                        fontWeight: 600,
                                      ),
                                      MySpacing.width(12),
                                      MyText.bodySmall(
                                        "\$${data.orderShippingCharge}",
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
                                    "\$${data.orderNetTotalAmount} USD",
                                    fontWeight: 700,
                                    fontSize: 22,
                                  ),
                                ],
                              ),
                              MySpacing.height(22),
                              // MyText.bodySmall(
                              //   "Notes:",
                              //   fontWeight: 600,
                              // ),
                              // Row(
                              //   children: [
                              //     // MyContainer.none(
                              //     //   width: 250,
                              //     //   child: MyText.bodySmall(
                              //     //     controller.dummyTexts[1],
                              //     //     maxLines: 2,
                              //     //     muted: true,
                              //     //   ),
                              //     // ),
                              //   ],
                              // ),
                              // MySpacing.height(22),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.end,
                              //   children: [
                              //     MyButton(
                              //       onPressed: () {},
                              //       elevation: 0,
                              //       padding: MySpacing.xy(20, 16),
                              //       backgroundColor: contentTheme.primary,
                              //       borderRadiusAll:
                              //           AppStyle.buttonRadius.medium,
                              //       child: Row(
                              //         children: [
                              //           Icon(
                              //             LucideIcons.pencil,
                              //             size: 14,
                              //           ),
                              //           MySpacing.width(8),
                              //           MyText.bodySmall(
                              //             'Print',
                              //             color: contentTheme.onPrimary,
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //     MySpacing.width(8),
                              //     MyButton(
                              //       onPressed: () {},
                              //       elevation: 0,
                              //       padding: MySpacing.xy(20, 16),
                              //       backgroundColor: contentTheme.success,
                              //       borderRadiusAll:
                              //           AppStyle.buttonRadius.medium,
                              //       child: MyText.bodySmall(
                              //         'Submit',
                              //         color: contentTheme.onPrimary,
                              //       ),
                              //     ),
                              //   ],
                              // )
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
