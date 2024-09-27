import 'package:doctor_ack/core/utils/assets_manager.dart';
import 'package:doctor_ack/core/utils/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/color_manager.dart';
import '../../utils/constants_manager.dart';
import '../text_custom/text_custom.dart';

class RatingBarCustom extends StatelessWidget {
  final int itemCount;
  final bool enable;
  final String averageRating;
  final bool showText;
  final double itemSize;
  final double minRate;
  final FontWeight fontWeight;
  final double fontSize;
  final Color color;
  final Function(double rate)? currentRate;

  const RatingBarCustom(
      {required this.itemCount,
      required this.averageRating,
      this.enable = false,
      this.showText = true,
      this.itemSize = 15,
      this.minRate = 0.5,
      this.fontSize = 14.0,
      this.fontWeight = FontWeight.normal,
      this.currentRate,
      this.color = ColorManager.grey,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        RatingBar.builder(
          minRating: minRate,
          ignoreGestures: !enable,
          itemSize: itemSize,
          initialRating: double.parse(averageRating),
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: itemCount,
          itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
          unratedColor: const Color(0xffECEFF1),
          itemBuilder: (context, _) => SvgPicture.asset(IconAssets.star2),
          onRatingUpdate: (rating) {
            // print(rating);
            currentRate == null ? null : currentRate!(rating);
          },
        ),
        if (showText)
          TextCustom(
            arabic: AppConstants.language,
            text: averageRating,
            color: color,
            fontSize: fontSize,
            fontWeight: fontWeight,
            textStyle: TextStyle(
              color: color,
              fontSize: FontSize.s16,
              fontFamily: 'SF Pro Text',
              fontWeight: FontWeight.w600,
              height: 0,
              letterSpacing: -0.32,
            ),
          )
      ],
    );
  }
}
