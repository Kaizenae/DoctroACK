import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:doctor_ack/core/utils/font_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../utils/color_manager.dart';
import '../../utils/constants_manager.dart';

class TextCustom extends StatelessWidget {
  final String text;
  final double? fontSize;

  final double? letterSpacing;
  final bool? softWrap;
  final Color? color;

  final Color? decorationColor;

  final FontWeight? fontWeight;

  final TextDecoration decoration;

  final TextOverflow? overflow;
  final int? maxLines;
  final TextAlign textAlign;
  final TextStyle? textStyle;
  final bool? arabic;

  const TextCustom({
    super.key,
    required this.text,
    this.fontSize = 14.0,
    this.color = ColorManager.black,
    this.decorationColor = ColorManager.black,
    this.fontWeight = FontWeightManager.regular,
    this.decoration = TextDecoration.none,
    this.overflow,
    this.textStyle,
    this.maxLines,
    this.softWrap = true,
    this.letterSpacing = 0.0,
    this.textAlign = TextAlign.start,
    this.arabic = false,
  });

  @override
  Widget build(BuildContext context) {
    ArabicNumbers arabicNumber = ArabicNumbers();
    return Text(
      // textDirection: TextDirection.rtl,
      AppConstants.language
          ? arabic!
              ? arabicNumber.convert(text.tr())
              : text.tr()
          : text.tr(),
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      softWrap: softWrap,

      style: textStyle ??
          Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontSize: fontSize,
                color: color,
                letterSpacing: letterSpacing,
                fontWeight: fontWeight,
                decoration: decoration,
                decorationColor: decorationColor,
              ),
    );
  }
}
