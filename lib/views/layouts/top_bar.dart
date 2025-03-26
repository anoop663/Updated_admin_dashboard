
import 'package:flatten/helpers/theme/app_style.dart';
import 'package:flatten/helpers/theme/theme_customizer.dart';
import 'package:flatten/helpers/utils/mixins/ui_mixin.dart';
import 'package:flatten/helpers/utils/my_shadow.dart';
import 'package:flatten/helpers/widgets/my_button.dart';
import 'package:flatten/helpers/widgets/my_card.dart';
import 'package:flatten/helpers/widgets/my_container.dart';
import 'package:flatten/helpers/widgets/my_spacing.dart';
import 'package:flatten/helpers/widgets/my_text.dart';
import 'package:flatten/images.dart';
import 'package:flatten/widgets/custom_pop_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class TopBar extends StatefulWidget {
  const TopBar({
    super.key, // this.onMenuIconTap,
  });

  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar>
    with SingleTickerProviderStateMixin, UIMixin {
  Function? languageHideFn;

  @override
  Widget build(BuildContext context) {
    return MyCard(
      shadow: MyShadow(position: MyShadowPosition.bottomRight, elevation: 0.5),
      height: 60,
      borderRadiusAll: 0,
      padding: MySpacing.x(24),
      color: topBarTheme.background.withAlpha(246),
      child: Row(
        children: [
          Row(
            children: [
              InkWell(
                  splashColor: colorScheme.onSurface,
                  highlightColor: colorScheme.onSurface,
                  onTap: () {
                    ThemeCustomizer.toggleLeftBarCondensed();
                  },
                  child: Icon(
                    Icons.menu,
                    color: topBarTheme.onBackground,
                  )),
              MySpacing.width(24),
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    ThemeCustomizer.setTheme(
                        ThemeCustomizer.instance.theme == ThemeMode.dark
                            ? ThemeMode.light
                            : ThemeMode.dark);
                  },
                  child: Icon(
                    ThemeCustomizer.instance.theme == ThemeMode.dark
                        ? LucideIcons.sun
                        : LucideIcons.moon,
                    size: 18,
                    color: topBarTheme.onBackground,
                  ),
                ),
                MySpacing.width(12),
                MySpacing.width(6),
                CustomPopupMenu(
                  backdrop: true,
                  onChange: (_) {},
                  offsetX: -60,
                  offsetY: 8,
                  menu: Padding(
                    padding: MySpacing.xy(8, 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MyContainer.rounded(
                            paddingAll: 0,
                            child: Image.asset(
                              Images.avatars[0],
                              height: 28,
                              width: 28,
                              fit: BoxFit.cover,
                            )),
                        MySpacing.width(8),
                        MyText.labelLarge("Admin")
                      ],
                    ),
                  ),
                  menuBuilder: (_) => buildAccountMenu(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildAccountMenu() {
    return MyContainer.bordered(
      paddingAll: 0,
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: MySpacing.xy(8, 8),
            //child: Column(
            //  crossAxisAlignment: CrossAxisAlignment.start,
            //  children: [
            //    MyButton(
            //      onPressed: () => {},
            //      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            //      borderRadiusAll: AppStyle.buttonRadius.medium,
            //      padding: MySpacing.xy(8, 4),
            //      splashColor: colorScheme.onSurface.withAlpha(20),
            //      backgroundColor: Colors.transparent,
            //      child: Row(
            //        children: [
            //          Icon(
            //            LucideIcons.user,
            //            size: 14,
            //            color: contentTheme.onBackground,
            //          ),
            //          MySpacing.width(8),
            //          MyText.labelMedium(
            //            "My Account",
            //            fontWeight: 600,
            //          )
            //        ],
            //      ),
            //    ),
            //    MySpacing.height(4),
            //    MyButton(
            //      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            //      onPressed: () => {},
            //      borderRadiusAll: AppStyle.buttonRadius.medium,
            //      padding: MySpacing.xy(8, 4),
            //      splashColor: colorScheme.onSurface.withAlpha(20),
            //      backgroundColor: Colors.transparent,
            //      child: Row(
            //        children: [
            //          Icon(
            //            LucideIcons.settings,
            //            size: 14,
            //            color: contentTheme.onBackground,
            //          ),
            //          MySpacing.width(8),
            //          MyText.labelMedium(
            //            "Settings",
            //            fontWeight: 600,
            //          )
            //        ],
            //      ),
            //    ),
            //  ],
            //),
          ),
          //Divider(
          //  height: 1,
          //  thickness: 1,
          //),
          Padding(
            padding: MySpacing.xy(8, 8),
            child: MyButton(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: () => {
              Navigator.pushNamed(context, '/auth/login')
              },
              borderRadiusAll: AppStyle.buttonRadius.medium,
              padding: MySpacing.xy(8, 4),
              splashColor: contentTheme.danger.withAlpha(28),
              backgroundColor: Colors.transparent,
              child: Row(
                children: [
                  Icon(
                    LucideIcons.log_out,
                    size: 14,
                    color: contentTheme.danger,
                  ),
                  MySpacing.width(8),
                  MyText.labelMedium(
                    "Log out",
                    fontWeight: 600,
                    color: contentTheme.danger,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
