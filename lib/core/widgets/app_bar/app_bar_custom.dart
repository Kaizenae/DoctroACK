import 'package:doctor_ack/core/utils/values_manager.dart';
import 'package:flutter/material.dart';

import '../../utils/assets_manager.dart';
import '../../utils/color_manager.dart';
import '../../utils/constants_manager.dart';
import '../../utils/routes_manager.dart';
import '../svg_pic/svg_pic.dart';
import '../text_custom/text_custom.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(AppSize.s50);

  final IconData? iconData;
  final String? text;
  final String? screenName;
  final Function? onPressed;
  final List<Widget>? actions;
  final bool? isNull;
  final bool isText;
  final TextAlign? textAlign;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool? centerTitle;
  final Widget? widget;
  final Widget? textWidget;
  final PreferredSizeWidget? bottomWidget;
  final Color? backgroundColor;

  const AppBarCustom({
    super.key,
    this.iconData = Icons.arrow_back_rounded,
    this.text = '',
    this.screenName = Routes.mainRoute,
    this.widget,
    this.textWidget,
    this.onPressed,
    this.bottomWidget,
    this.isNull = true,
    this.isText = false,
    this.centerTitle = true,
    this.textAlign = TextAlign.center,
    this.fontSize = 18,
    this.fontWeight = FontWeight.w600,
    this.backgroundColor = ColorManager.scaffoldColor,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      centerTitle: centerTitle,
      // systemOverlayStyle: const SystemUiOverlayStyle(
      //   statusBarIconBrightness: Brightness.dark,
      //   statusBarColor: Colors.white,
      // ),

      leading: isNull!
          ? InkWell(
              onTap: () {
                onPressed == null ? null : onPressed!();
                // navigatorAndRemove(context, screenName!);

                Navigator.pop(context);
              },
              child: SvgPictureCustom(
                boxFit: BoxFit.none,
                assetsName: AppConstants.language
                    ? IconAssets.arrowRight
                    : IconAssets.arrowLeft,
                color: null,
              ),
            )
          : widget,
      title: isText
          ? textWidget
          : TextCustom(
              textAlign: textAlign!,
              text: text!,
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: Colors.black,
            ),
      actions: actions,
      bottom: bottomWidget,
    );
  }
}
