import 'package:doctor_ack/core/utils/assets_manager.dart';
import 'package:doctor_ack/core/utils/color_manager.dart';
import 'package:doctor_ack/core/utils/font_manager.dart';
import 'package:doctor_ack/core/utils/media_query_values.dart';
import 'package:doctor_ack/core/utils/values_manager.dart';
import 'package:doctor_ack/core/widgets/cached_image/cached_network_image.dart';
import 'package:doctor_ack/core/widgets/rating_bar/rating_bar.dart';
import 'package:doctor_ack/core/widgets/text_custom/text_custom.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/packages_imprts.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width / 1.1,
      // height: AppSize.s100,
      padding: EdgeInsets.all(AppPadding.p10),
      margin: EdgeInsets.only(bottom: AppPadding.p10),
      decoration: BoxDecoration(
          color: ColorManager.cardColor1,
          borderRadius: BorderRadius.circular(AppSize.s8),
          boxShadow: const [
            BoxShadow(
                color: ColorManager.cardShadow,
                blurRadius: AppSize.s8,
                offset: Offset(-2, 2),
                // spreadRadius: .2,
                blurStyle: BlurStyle.solid)
          ]),
      child: Row(
        children: [
          CachedNetworkImageCustom(
            url: ImageNetwork.profileImage,
            width: AppSize.s80,
            height: AppSize.s80,
            boarder: AppSize.s8.r,
          ),
          SizedBox(
            width: AppSize.s4.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // textDirection: TextDirection.rtl,
            children: [
              SizedBox(
                width: context.width / 1.7,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextCustom(
                      text: 'Ahmed Emad',
                      fontWeight: FontWeightManager.bold,
                      fontSize: FontSize.s16,
                    ),
                    RatingBarCustom(
                      itemCount: 5,
                      averageRating: '4.8',
                      itemSize: AppSize.s10.sp,
                      showText: false,
                      color: ColorManager.primary,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: context.width / 1.7,
                child: TextCustom(
                  text: 'Botox near problem areas',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  color: ColorManager.primary,
                  fontSize: FontSize.s10,
                  fontWeight: FontWeightManager.semiBold,
                ),
              ),
              SizedBox(
                height: AppSize.s4.h,
              ),
              SizedBox(
                width: context.width / 1.7,
                child: TextCustom(
                  text:
                      'Lorem ipsum dolor sit amet consectetur.Lorem ipsum dolor sit amet consectetur.',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  color: ColorManager.grey,
                  fontSize: FontSize.s12,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
