import 'package:flatten/controllers/dashboard_controller.dart';
import 'package:flatten/helpers/extensions/string.dart';
import 'package:flatten/helpers/theme/app_style.dart';
import 'package:flatten/helpers/utils/mixins/ui_mixin.dart';
import 'package:flatten/helpers/utils/my_shadow.dart';
import 'package:flatten/helpers/widgets/my_breadcrumb.dart';
import 'package:flatten/helpers/widgets/my_breadcrumb_item.dart';
import 'package:flatten/helpers/widgets/my_card.dart';
import 'package:flatten/helpers/widgets/my_container.dart';
import 'package:flatten/helpers/widgets/my_flex.dart';
import 'package:flatten/helpers/widgets/my_flex_item.dart';
import 'package:flatten/helpers/widgets/my_spacing.dart';
import 'package:flatten/helpers/widgets/my_text.dart';

import 'package:flatten/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  DashboardPageState createState() => DashboardPageState();
}

class DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late DashboardController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(DashboardController());
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder<DashboardController>(
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
                      "dashboard".tr(),
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'ecommerce'.tr()),
                        MyBreadcrumbItem(name: 'dashboard'.tr(), active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing / 2),
                child: MyFlex(
                  wrapAlignment: WrapAlignment.start,
                  wrapCrossAlignment: WrapCrossAlignment.start,
                  children: [
                    MyFlexItem(
                      sizes: "xl-3 lg-6 sm-6 md-6",
                      child: MyCard(
                          shadow: MyShadow(
                              elevation: 0.5,
                              position: MyShadowPosition.bottom),
                          padding: MySpacing.xy(20, 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText.headlineSmall(
                                    "${controller.totalUsers}",
                                    fontWeight: 600,
                                  ),
                                  MySpacing.height(4),
                                  MyText.bodySmall(
                                    "Total Users:".tr().capitalizeWords,
                                    muted: true,
                                    fontWeight: 600,
                                  ),
                                ],
                              ),
                              MyContainer(
                                  color: contentTheme.primary.withAlpha(48),
                                  child: Icon(
                                    LucideIcons.users,
                                    color: contentTheme.primary,
                                    size: 24,
                                  ))
                            ],
                          )),
                    ),
                    MyFlexItem(
                      sizes: "xl-3 lg-6 sm-6 md-6",
                      child: MyCard(
                          shadow: MyShadow(
                              elevation: 0.5,
                              position: MyShadowPosition.bottom),
                          padding: MySpacing.xy(20, 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText.headlineSmall(
                                    "${controller.totalOrders}",
                                    fontWeight: 600,
                                  ),
                                  MySpacing.height(4),
                                  MyText.bodySmall(
                                    "Total Orders:".tr().capitalizeWords,
                                    muted: true,
                                    fontWeight: 600,
                                  ),
                                ],
                              ),
                              MyContainer(
                                  color: contentTheme.success.withAlpha(48),
                                  child: Icon(
                                    LucideIcons.shopping_cart,
                                    color: contentTheme.success,
                                    size: 24,
                                  ))
                            ],
                          )),
                    ),
                    MyFlexItem(
                      sizes: "xl-3 lg-6 sm-6 md-6",
                      child: MyCard(
                          shadow: MyShadow(
                              elevation: 0.5,
                              position: MyShadowPosition.bottom),
                          padding: MySpacing.xy(20, 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText.headlineSmall(
                                    "${controller.totalProducts}",
                                    fontWeight: 600,
                                  ),
                                  MySpacing.height(4),
                                  MyText.bodySmall(
                                    "Total Products:".tr().capitalizeWords,
                                    muted: true,
                                    fontWeight: 600,
                                  ),
                                ],
                              ),
                              MyContainer(
                                  color: contentTheme.secondary.withAlpha(48),
                                  child: Icon(
                                    LucideIcons.package,
                                    color: contentTheme.secondary,
                                    size: 24,
                                  ))
                            ],
                          )),
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
