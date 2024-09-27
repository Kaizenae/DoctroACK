import '../../utils/color_manager.dart';
import '../../utils/values_manager.dart';
import 'package:flutter/material.dart';

import '../svg_pic/svg_pic.dart';

class IconButtonCustom extends StatelessWidget {
  final String iconName;
  final Function onPressed;
  final Color? color;
  final Color? btnColor;
  final double? radius;
  final double? iconSize;
  const IconButtonCustom({
    super.key,
    required this.iconName,
    required this.onPressed,
    this.color = ColorManager.black,
    this.btnColor = ColorManager.green,
    this.radius = AppSize.s8,
    this.iconSize = AppSize.s24,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: iconSize,
      onPressed: () {
        onPressed();
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(btnColor!),
        animationDuration: const Duration(milliseconds: 300),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius!)),
          ),
        ),
      ),
      color: btnColor,
      icon: SvgPictureCustom(
        height: iconSize,
        width: iconSize,
        assetsName: iconName,
        color: color,
      ),
    );
  }
}
