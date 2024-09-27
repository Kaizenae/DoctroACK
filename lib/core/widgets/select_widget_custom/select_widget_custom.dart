import 'package:doctor_ack/core/utils/assets_manager.dart';
import 'package:doctor_ack/core/utils/styles_manager.dart';
import 'package:doctor_ack/core/widgets/elevated_button/elevated_button_custom.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/color_manager.dart';
import '../../utils/font_manager.dart';
import '../../utils/values_manager.dart';
import '../cached_image/cached_network_image.dart';
import '../rating_bar/rating_bar.dart';
import '../text_custom/text_custom.dart';

class SelectWidgetCustom<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final String? logo;
  final String? name;
  final String? title;
  final double? radius;
  final double? width;
  final double? titleWidth;
  final String? rate;
  final String? price;
  final Color? selectedColor;
  final Color? disabledColor;
  final int index;
  final ValueChanged<T?> onChanged;

  SelectWidgetCustom({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.index,
    this.logo,
    this.radius = AppSize.s10,
    this.selectedColor = ColorManager.primary,
    this.disabledColor = ColorManager.white,
    this.name,
    this.title,
    this.width,
    this.titleWidth = AppSize.s100 * 2.1,
    this.rate,
    this.price,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;

    return AnimatedContainer(
      // width: width!,
      padding: EdgeInsets.all(AppPadding.p8),
      margin: EdgeInsets.only(
          bottom: AppMargin.m8, right: width != null ? AppMargin.m8 : 0.0),
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        color: isSelected ? selectedColor : disabledColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius!),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: AppSize.s4,
            offset: Offset(AppSize.s0, AppSize.s4),
            spreadRadius: AppSize.s0,
          )
        ],
      ),
      duration: const Duration(milliseconds: 300),
      child: InkWell(
        onTap: () => onChanged(value),
        child: Row(
          children: [
            logo == null
                ? const SizedBox()
                : CachedNetworkImageCustom(
                    url: logo!,
                    width: AppSize.s50.h,
                    height: AppSize.s50.h,
                    boarder: AppSize.s40.r,
                  ),
            SizedBox(
              // height: AppSize.s100 ,
              width: titleWidth,
              child: Padding(
                padding: EdgeInsets.all(AppPadding.p4),
                child: Column(
                  mainAxisAlignment: selectedColor != null
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    name == null
                        ? const SizedBox()
                        : Align(
                            alignment: width != null
                                ? Alignment.center
                                : Alignment.centerLeft,
                            child: TextCustom(
                              text: name!.tr(),
                              fontSize: FontSize.s16,
                              color: isSelected
                                  ? ColorManager.white
                                  : ColorManager.black,
                              fontWeight: FontWeightManager.bold,
                              textStyle: selectedColor != null
                                  ? getMediumGilroyStyle(
                                      color: isSelected
                                          ? ColorManager.white
                                          : ColorManager.black,
                                      fontSize: FontSize.s14,
                                    )
                                  : null,
                            ),
                          ),
                    title != null
                        ? SizedBox(
                            height: AppSize.s6.h,
                          )
                        : const SizedBox(),
                    title == null
                        ? const SizedBox()
                        : TextCustom(
                            text: title!.tr(),
                            fontWeight: FontWeightManager.bold,
                            textStyle: getRegularGilroyStyle(
                              color: isSelected
                                  ? ColorManager.white
                                  : ColorManager.black,
                              fontSize: FontSize.s12,
                            )),
                    rate == null
                        ? const SizedBox()
                        : RatingBarCustom(itemCount: 1, averageRating: rate!),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final List<String> str = [
    "Lorem ipsum dolor sit amet consectetur",
    "Parturient dui consequat augue elit nibh ultricies urna egestas nunc. Ullamcorper ut ut enim consequat sed mollis volutpat elit tortor.",
    "At pulvinar accumsan nisl ac netus in.",
    "Lorem ipsum dolor sit amet consectetur"
  ];
  bottomSheet(BuildContext context) {
    return showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.all(AppPadding.p10),
            height: AppSize.s100.h * 4,
            decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppSize.s24.r),
                    topRight: Radius.circular(AppSize.s24.r))),
            child: Column(
              children: [
                CachedNetworkImageCustom(
                  url: ImageNetwork.clinicLogo,
                  width: AppSize.s100,
                  height: AppSize.s100,
                  boarder: AppSize.s24.r,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RatingBarCustom(
                      itemCount: 1,
                      averageRating: '4.7',
                      itemSize: AppSize.s20.sp,
                      fontSize: FontSize.s18,
                      fontWeight: FontWeightManager.bold,
                      color: ColorManager.black,
                    ),
                    const TextCustom(
                      text: '(17 reviews)',
                      color: ColorManager.darkGrey,
                    )
                  ],
                ),
                SizedBox(
                  height: AppSize.s18.h,
                ),
                TextCustom(
                  text: 'About the service',
                  fontSize: FontSize.s20,
                  fontWeight: FontWeightManager.bold,
                ),
                SizedBox(
                  height: AppSize.s10.h,
                ),
                Column(
                  children: str.map((strone) {
                    return Row(children: [
                      TextCustom(
                        text: "\u2022",
                        fontSize: FontSize.s16,
                        color: ColorManager.primary,
                      ),
                      //bullet text
                      SizedBox(
                        width: AppSize.s10.w,
                      ),
                      //space between bullet and text
                      Expanded(
                        child: TextCustom(
                          text: strone,
                          fontSize: FontSize.s16,
                        ), //text
                      )
                    ]);
                  }).toList(),
                ),
                SizedBox(
                  height: AppSize.s18.h,
                ),
                ElevatedButtonCustom(
                  text: 'Back',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          );
        });
  }
}
