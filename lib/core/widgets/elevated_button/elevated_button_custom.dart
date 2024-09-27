import 'package:doctor_ack/core/utils/styles_manager.dart';

import '../../utils/values_manager.dart';
import 'package:flutter/material.dart';

import '../../utils/color_manager.dart';
import '../text_custom/text_custom.dart';

class ElevatedButtonCustom extends StatelessWidget {
  final String? text;
  final Function? onPressed;
  final double? radius;
  final double? width;
  final double? height;
  final double? vPadding;
  final double? hPadding;
  final double? elevation;
  final Color? colors;
  final Color? textColor;
  final double? fontSize;
  final Widget? widget;
  final Color? borderColor;
  final FontWeight? fontWeight;
  final TextStyle? textStyle;

  const ElevatedButtonCustom({
    super.key,
    this.text,
    this.onPressed,
    this.radius = AppSize.s50,
    this.width = double.infinity,
    this.height = AppSize.s50,
    this.vPadding = AppSize.s4,
    this.hPadding = AppSize.s12,
    this.elevation = AppSize.s0,
    this.colors,
    this.fontSize = AppSize.s18,
    this.textColor = ColorManager.white,
    this.widget,
    this.borderColor,
    this.textStyle,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed!();
      },
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius!),
            side: BorderSide(color: borderColor ?? ColorManager.primary),
          ),
          backgroundColor: colors ?? ColorManager.primary,
          elevation: elevation,
          minimumSize: Size(width!, height!),
          padding:
              EdgeInsets.symmetric(horizontal: hPadding!, vertical: vPadding!),
          textStyle: Theme.of(context)
              .textTheme
              .headlineLarge!
              .copyWith(color: textColor)),
      child: widget ??
          TextCustom(
              text: text!,
              color: textColor,
              fontSize: fontSize,
              fontWeight: fontWeight,
              textStyle: textStyle ??
                  getSemiBoldGilroyStyle(
                      color: textColor!, fontSize: fontSize!),
              textAlign: TextAlign.center),
    );
  }
}
