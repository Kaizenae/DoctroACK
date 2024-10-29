import 'package:doctor_ack/core/utils/assets_manager.dart';
import 'package:doctor_ack/core/utils/color_manager.dart';
import 'package:doctor_ack/core/utils/font_manager.dart';
import 'package:doctor_ack/core/utils/styles_manager.dart';
import 'package:doctor_ack/core/widgets/svg_pic/svg_pic.dart';
import 'package:doctor_ack/core/widgets/text_custom/text_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/values_manager.dart';

class SummaryWidget extends StatelessWidget {
  final String description;
  final Color? color;
  final double? height;
  const SummaryWidget(
      {super.key,
      required this.description,
      this.color = ColorManager.black,
      this.height = AppSize.s20});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppPadding.p8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPictureCustom(
            height: height,
            assetsName: IconAssets.check,
            color: color!,
          ),
          const SizedBox(
            width: AppSize.s8,
          ),
          Expanded(
            child: TextCustom(
              text: description,
              textStyle:
                  getMediumGilroyStyle(color: color!, fontSize: FontSize.s14),
            ),
          ),
        ],
      ),
    );
  }
}
