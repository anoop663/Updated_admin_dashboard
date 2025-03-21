import 'package:flatten/controllers/crm_dashboard_controller.dart';
import 'package:flatten/helpers/theme/app_style.dart';
import 'package:flatten/helpers/utils/mixins/ui_mixin.dart';
import 'package:flatten/helpers/utils/utils.dart';
import 'package:flatten/helpers/widgets/my_breadcrumb.dart';
import 'package:flatten/helpers/widgets/my_breadcrumb_item.dart';
import 'package:flatten/helpers/widgets/my_container.dart';
import 'package:flatten/helpers/widgets/my_flex.dart';
import 'package:flatten/helpers/widgets/my_flex_item.dart';
import 'package:flatten/helpers/widgets/my_list_extension.dart';
import 'package:flatten/helpers/widgets/my_spacing.dart';
import 'package:flatten/helpers/widgets/my_text.dart';
import 'package:flatten/images.dart';
import 'package:flatten/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:flatten/helpers/extensions/string.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CrmDashboardScreen extends StatefulWidget {
  const CrmDashboardScreen({super.key});

  @override
  State<CrmDashboardScreen> createState() => _CrmDashboardScreenState();
}

class _CrmDashboardScreenState extends State<CrmDashboardScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  late CrmDashboardController controller;

  @override
  void initState() {
    controller = Get.put(CrmDashboardController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'crm_dashboard_controller',
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium(
                      "CRM Dashboard".tr(),
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'crm'.tr()),
                        MyBreadcrumbItem(name: 'dashboard'.tr(), active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
            ],
          );
        },
      ),
    );
  }

  Widget recentOrder() {
    return MyContainer(
      paddingAll: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.titleMedium("Recent Order", fontWeight: 600),
          MySpacing.height(20),
          if (controller.crmData.isNotEmpty)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                  sortAscending: true,
                  columnSpacing: 80,
                  onSelectAll: (_) => {},
                  headingRowColor: WidgetStatePropertyAll(
                      contentTheme.primary.withAlpha(40)),
                  dataRowMaxHeight: 64,
                  showBottomBorder: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  border: TableBorder.all(
                      borderRadius: BorderRadius.circular(4),
                      style: BorderStyle.solid,
                      width: .4,
                      color: Colors.grey),
                  columns: [
                    DataColumn(
                        label: MyText.labelLarge('No.',
                            color: contentTheme.primary)),
                    DataColumn(
                        label: MyText.labelLarge('Order Id',
                            color: contentTheme.primary)),
                    DataColumn(
                        label: MyText.labelLarge('Order Date',
                            color: contentTheme.primary)),
                    DataColumn(
                        label: MyText.labelLarge('Product Name',
                            color: contentTheme.primary)),
                    DataColumn(
                        label: MyText.labelLarge('Customer',
                            color: contentTheme.primary)),
                    DataColumn(
                        label: MyText.labelLarge('Total Amount',
                            color: contentTheme.primary)),
                    DataColumn(
                        label: MyText.labelLarge('Status',
                            color: contentTheme.primary)),
                  ],
                  rows: controller.crmData.mapIndexed(
                    (index, data) {
                      return DataRow(
                        cells: [
                          DataCell(SizedBox(
                            width: 50,
                            child: MyText.titleMedium(data.number.toString(),
                                fontWeight: 600),
                          )),
                          DataCell(SizedBox(
                            width: 80,
                            child: MyText.titleMedium("#${data.orderId}",
                                fontWeight: 600),
                          )),
                          DataCell(SizedBox(
                            width: 100,
                            child: MyText.titleMedium(
                                Utils.getDateStringFromDateTime(data.orderDate,
                                    showMonthShort: true),
                                fontWeight: 600,
                                maxLines: 1),
                          )),
                          DataCell(SizedBox(
                            width: 200,
                            child: MyText.titleMedium(data.productName,
                                fontWeight: 600),
                          )),
                          DataCell(SizedBox(
                            width: 200,
                            child: Row(
                              children: [
                                MyContainer.rounded(
                                  height: 32,
                                  width: 32,
                                  paddingAll: 0,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Image.asset(
                                      Images.avatars[
                                          index % Images.avatars.length],
                                      fit: BoxFit.cover),
                                ),
                                MySpacing.width(12),
                                MyText.bodyMedium(data.customerName,
                                    fontWeight: 600),
                              ],
                            ),
                          )),
                          DataCell(SizedBox(
                            width: 100,
                            child: MyText.bodyMedium("\$${data.totalAmount}",
                                fontWeight: 600),
                          )),
                          DataCell(SizedBox(
                            width: 100,
                            child: MyText.bodyMedium(data.status,
                                fontWeight: 600,
                                color: getStatusColor(data.status)),
                          )),
                        ],
                      );
                    },
                  ).toList()),
            )
        ],
      ),
    );
  }

  Color? getStatusColor(String? status) {
    switch (status) {
      case "Processing":
        return contentTheme.primary;
      case "Delivered":
        return contentTheme.secondary;
      case "Cancelled":
        return contentTheme.danger;
      case "Shipped":
        return contentTheme.warning;
      default:
        return null;
    }
  }

  MyFlexItem revenueChart() {
    return MyFlexItem(
      sizes: 'lg-8 md-8',
      child: MyContainer(
        paddingAll: 24,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText.titleMedium("Revenue",
                    wordSpacing: 0, height: .9, fontWeight: 600),
                PopupMenuButton(
                  onSelected: controller.onSelectRevenue,
                  itemBuilder: (BuildContext context) {
                    return [
                      "Today",
                      "Yesterday",
                      "Tomorrow",
                    ].map((behavior) {
                      return PopupMenuItem(
                        value: behavior,
                        height: 32,
                        child: MyText.bodySmall(behavior.toString(),
                            color: theme.colorScheme.onSurface,
                            fontWeight: 600),
                      );
                    }).toList();
                  },
                  color: theme.cardTheme.color,
                  child: MyContainer.bordered(
                    padding: MySpacing.xy(12, 4),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        MyText.labelMedium(controller.selectRevenue.toString(),
                            color: contentTheme.onBackground),
                        MySpacing.width(4),
                        Icon(LucideIcons.chevron_down,
                            size: 20, color: contentTheme.onBackground)
                      ],
                    ),
                  ),
                ),
              ],
            ),
            MySpacing.height(20),
          
          ],
        ),
      ),
    );
  }
}
