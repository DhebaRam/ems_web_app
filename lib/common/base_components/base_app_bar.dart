import 'package:flutter/material.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Widget backButtonWidget;
  final Color? contentColor, backgroundColor;
  final bool? showNotification, showBackButton, showDefaultAddress, centerTitle;
  final Function()? onBackPressed;
  final List<Widget>? actions;
  final Widget? bottomChild;
  final double? bottomWidgetHeight, appBarHeight, titleSize, titleSpacing;
  final FontWeight? fontWeight;
  final String? leadingIcon;
  final double? leadingPadding;

  const BaseAppBar(
      {super.key,
        this.title,
        this.backButtonWidget = const SizedBox.shrink(),
        this.onBackPressed,
        this.showNotification,
        this.bottomChild,
        this.bottomWidgetHeight,
        this.appBarHeight,
        this.contentColor,
        this.backgroundColor,
        this.titleSize,
        this.fontWeight,
        this.titleSpacing,
        this.showBackButton,
        this.leadingIcon,
        this.centerTitle = true,
        this.actions,
        this.showDefaultAddress,
        this.leadingPadding});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize, // Setting the preferred size to zero
      child: SizedBox(
          height: appBarHeight, // Setting the container height to zero
          child: AppBar(
            title: title ?? const SizedBox.shrink(),
            backgroundColor: backgroundColor ?? Colors.transparent,
            titleSpacing: titleSpacing ?? 0,
            elevation: 0.0,
            scrolledUnderElevation: 0,
            centerTitle: centerTitle,
            automaticallyImplyLeading: false,
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(bottomWidgetHeight ?? 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    bottomChild ?? const SizedBox.shrink(),
                    bottomChild != null
                        ? const SizedBox(height: 10, width: 5)
                        : const SizedBox.shrink(),
                  ],
                )),
            leadingWidth: 20,
            leading: Visibility(
              visible: showBackButton ?? true,
              child: backButtonWidget,
            ),
            actions: actions ?? [],
          )),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottomWidgetHeight ?? 0));
}