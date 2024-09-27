import 'package:doctor_ack/core/utils/media_query_values.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/routes_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/cached_image/cached_network_image.dart';
import '../../../../core/widgets/component.dart';
import '../../../../core/widgets/rating_bar/rating_bar.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../../../../core/utils/packages_imprts.dart';

class CategoryBody extends StatelessWidget {
  const CategoryBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: AppSize.s4,
          ),
          CachedNetworkImageCustom(
              url: ImageNetwork.specialOffer1Image,
              // boarder: AppSize.s8,
              boxFit: BoxFit.fill,
              height: AppSize.s100 * 1.5,
              width: context.width,
              shimmerWidth: context.width),
          const SizedBox(
            height: AppSize.s4,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.p12),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(bottom: AppSize.s16.h),
                child: InkWell(
                  onTap: () {
                    navigator(context, Routes.clinicRoute);
                  },
                  child: Row(
                    children: [
                      CachedNetworkImageCustom(
                        url: ImageNetwork.clinicLogo,
                        width: AppSize.s80,
                        height: AppSize.s80,
                        boarder: AppSize.s24.r,
                        // boxFit: BoxFit.fill,
                      ),
                      SizedBox(
                        height: AppSize.s100,
                        width: context.width / 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextCustom(
                                text: 'Clinic 1',
                                fontSize: FontSize.s20,
                                fontWeight: FontWeightManager.bold,
                              ),
                              const TextCustom(
                                text: 'Lorem ipsum dolor sit amet consectetur.',
                                color: ColorManager.darkGrey,
                                maxLines: 2,
                                overflow: TextOverflow.clip,
                              ),
                              const RatingBarCustom(
                                  itemCount: 1, averageRating: '4.5'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              itemCount: 3,
            ),
          ),
          const SizedBox(
            height: AppSize.s8,
          ),
        ],
      ),
    );
  }
}
