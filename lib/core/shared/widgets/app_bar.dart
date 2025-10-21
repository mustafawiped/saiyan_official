import 'package:flutter/material.dart';
import 'package:suffadaemon/components/components.dart';
import 'package:suffadaemon/utils/resources/sizes.dart';
import '../../resources/app_assets.dart';
import '../../resources/app_colors.dart';

class AppDefaultComponent {
  AppBar getAppBar(
    BuildContext context, {
    bool? actionsState,
    IconData? icon,
    VoidCallback? actionOnClick,
    Color? actionColor,
    bool? leadingIconState,
    Color? leadingIconColor,
    IconData? leadingIcon,
    PreferredSizeWidget? bottom,
    VoidCallback? leadingIconClick,
    Color? centerTextColor,
    Color? bgColor,
    double? elevation,
    bool titleIsCenter = true,
    Function()? onTitleClick,
    List<Widget>? defActions,
    String? centerTitle,
  }) {
    return AppBar(
      backgroundColor: AppColors.backgroundDark(context),
      surfaceTintColor: AppColors.background(context),
      elevation: elevation,
      leading: leadingIconState is bool
          ? IconButton(
              onPressed: leadingIconClick,
              icon: Icon(
                leadingIcon ?? Icons.info_outlined,
                color: leadingIconColor ?? AppColors.backgroundDark(context),
              ),
            )
          : IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back,
                color: AppColors.surfaceLight(context),
              ),
            ),
      title: centerTitle is String
          ? GestureDetector(
              onTap: onTitleClick,
              child: SuffaText(
                title: centerTitle,
                textSize: SuffaSizes.xxLargeTextSize,
                textColor: centerTextColor ?? AppColors.surfaceCenter(context),
              ),
            )
          : Image.asset(AppAssets.app_logo_pr(context), width: 90, height: 45),
      centerTitle: titleIsCenter,
      actions: defActions is List<Widget>
          ? defActions
          : actionsState is bool
          ? [
              IconButton(
                onPressed: actionOnClick,
                icon: Icon(icon, color: actionColor),
              ),
            ]
          : [],
      bottom: bottom,
    );
  }
}
