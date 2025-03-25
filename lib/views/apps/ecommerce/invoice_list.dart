// ignore_for_file: unused_import, unused_local_variable

import 'package:flatten/controllers/apps/ecommerce/add_brand_controller.dart';
import 'package:flatten/controllers/apps/ecommerce/barnd_controler.dart';
import 'package:flatten/controllers/apps/ecommerce/edit_category_controller.dart';
import 'package:flatten/controllers/apps/ecommerce/category_controller.dart';
import 'package:flatten/controllers/apps/ecommerce/ccommerce_invoice_controller.dart';
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
import 'package:flatten/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:provider/provider.dart';

class InvoiceList extends StatefulWidget {
  const InvoiceList({super.key});

  @override
  _InvoiceListState createState() => _InvoiceListState();
}

class _InvoiceListState extends State<InvoiceList>
    with SingleTickerProviderStateMixin, UIMixin {
  late EcommerceInvoiceController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(EcommerceInvoiceController());
  }

  @override
  Widget build(BuildContext context) {
    AddProductsController ctrl = Get.put(AddProductsController());
    return Layout(
        child: GetBuilder<EcommerceInvoiceController>(
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
                          'Orders ',
                          fontSize: 18,
                          fontWeight: 600,
                        ),
                        MyBreadcrumb(
                          children: [
                            MyBreadcrumbItem(name: 'ecommerce'.tr()),
                            MyBreadcrumbItem(
                                name: 'Invoice'.tr(), active: true),
                          ],
                        ),
                      ],
                    ),
                  ),
                  MySpacing.height(flexSpacing),
                  controller.isLoading == true
                      ? Center(
                    child: CircularProgressIndicator(),
                  ):    MyCard(
                    shadow: MyShadow(elevation: 0.5, position: MyShadowPosition.bottom),
                    margin: MySpacing.x(flexSpacing),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MySpacing.height(16),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            sortAscending: true,
                            headingRowColor: WidgetStatePropertyAll(
                                contentTheme.primary.withAlpha(40)),
                            dataRowMaxHeight: 60,
                            showBottomBorder: false,
                            columns: [
                              DataColumn(
                                label: MyText.labelLarge(
                                  'Order Number'.tr(),
                                  color: contentTheme.primary,
                                ),
                              ),
                              DataColumn(
                                label: MyText.labelLarge(
                                  'Customer Name'.tr(),
                                  color: contentTheme.primary,
                                ),
                              ),
                              DataColumn(
                                label: MyText.labelLarge(
                                  'Amount'.tr(),
                                  color: contentTheme.primary,
                                ),
                              ),
                              DataColumn(
                                label: MyText.labelLarge(
                                  'Order Status',
                                  color: contentTheme.primary,
                                ),
                              ),
                            ],
                            rows: controller.ordersData.map((orders) {
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

                              goToDetails() async {

                                bool? status = await controller.fetchOrdersDetails(orderId: orders.id);
                                if (status!) {
                                  Navigator.pushNamed(
                                    context,
                                    '/apps/ecommerce/InvoiceDetails',
                                  );
                                }
                              }

                              return DataRow(
                                cells: [
                                  DataCell(InkWell(
                                      onTap: goToDetails, child: Text(orders.invoiceNumber))),
                                  DataCell(InkWell(
                                      onTap: goToDetails, child: Text(orders.billingName))),
                                  DataCell(InkWell(
                                      onTap: goToDetails,
                                      child: Text(orders.orderNetTotalAmount))),
                                  DataCell(
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      child: DropdownButton<String>(
                                        value: orders.orderStatus,
                                        onChanged: (newStatus) {
                                          if (newStatus != null) {
                                            final statusId = statusOptions.firstWhere(
                                                  (status) => status['status_text'] == newStatus,
                                              orElse: () => {"status_id": -1},
                                            )['status_id'];

                                            if (statusId != -1) {
                                              setState(() {
                                                orders.orderStatus = newStatus;
                                              });

                                              controller.updateOrderStatus(
                                                orderId: orders.id,
                                                currentStatus: statusId as int,
                                              );
                                            } else {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(
                                                  content: Text("Invalid status selected."),
                                                ),
                                              );
                                            }
                                          }
                                        },
                                        items: statusOptions
                                            .map((status) => DropdownMenuItem<String>(
                                          value: status['status_text'].toString(),
                                          child: Text(status['status_text'].toString()),
                                        ))
                                            .toList(),
                                        dropdownColor: Colors.white,
                                        underline: const SizedBox(),
                                        isDense: true,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                        _buildPaginationControls(controller),
                      ],
                    ),
                  )

                ],
              );
            }));
  }

  Widget _buildPaginationControls(EcommerceInvoiceController categoryProvider) {
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
