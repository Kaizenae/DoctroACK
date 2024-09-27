import 'package:doctor_ack/core/utils/color_manager.dart';
import 'package:doctor_ack/core/utils/font_manager.dart';
import 'package:doctor_ack/core/utils/media_query_values.dart';
import 'package:doctor_ack/core/utils/values_manager.dart';
import 'package:doctor_ack/core/widgets/app_bar/app_bar_custom.dart';
import 'package:doctor_ack/core/widgets/icon_button/icon_button.dart';
import 'package:doctor_ack/core/widgets/scaffold_custom/scaffold_custom.dart';
import 'package:doctor_ack/core/widgets/text_custom/text_custom.dart';
import 'package:doctor_ack/languages/locale_keys.g.dart';
import 'package:doctor_ack/vendor_modules/vendor_reviews/presentation/controllers/vendor_reviews_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/packages_imprts.dart';
// import 'package:rating_summary/rating_summary.dart';

import '../../../../core/utils/assets_manager.dart';
import '../../../../core/widgets/elevated_button/elevated_button_custom.dart';
import '../../../../core/widgets/select_widget_custom/select_widget_custom.dart';
import '../controllers/vendor_reviews_cubit.dart';
import '../widgets/review_card.dart';

class VendorReviewsScreen extends StatelessWidget {
  const VendorReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
        appBarCustom: AppBarCustom(
          text: LocaleKeys.reviews,
          actions: [
            IconButtonCustom(
              btnColor: ColorManager.scaffoldColor,
              onPressed: () {
                bottomSheetServices(context);
              },
              iconName: IconAssets.filter,
            ),
            IconButtonCustom(
              btnColor: ColorManager.scaffoldColor,
              onPressed: () {
                bottomSheet(context);
              },
              iconName: IconAssets.filter,
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(AppPadding.p12),
            child: Column(
              children: [
                // const RatingSummary(
                //   counter: 13,
                //   average: 3.846,
                //   counterFiveStars: 5,
                //   counterFourStars: 4,
                //   counterThreeStars: 2,
                //   counterTwoStars: 1,
                //   counterOneStars: 1,
                // ),
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.end,
                //   children: [
                //     TextCustom(
                //       text: 'Reviews',
                //       fontWeight: FontWeightManager.bold,
                //       fontSize: FontSize.s18,
                //     ),
                //     const Spacer(),
                //     RatingBarCustom(
                //       itemCount: 1,
                //       averageRating: '4.8',
                //       fontSize: FontSize.s18,
                //       color: ColorManager.black,
                //       itemSize: AppSize.s16,
                //     ),
                //     SizedBox(
                //       width: AppSize.s4.w,
                //     ),
                //     TextCustom(
                //       text: '280+ review',
                //       color: ColorManager.grey,
                //       fontSize: FontSize.s12,
                //     ),
                //   ],
                // ),
                SizedBox(
                  height: AppSize.s18.h,
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => const ReviewCard(),
                  itemCount: 10,
                )
              ],
            ),
          ),
        ));
  }

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
            child: Material(
              child: BlocProvider(
                create: (context) => VendorReviewsCubit(),
                child: BlocConsumer<VendorReviewsCubit, VendorReviewsState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    var clinicCubit = VendorReviewsCubit.get(context);
                    return SizedBox(
                      width: context.width,
                      child: Column(
                        children: [
                          TextCustom(
                            text: LocaleKeys.sortBy,
                            fontSize: FontSize.s18,
                            fontWeight: FontWeightManager.bold,
                          ),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return SelectWidgetCustom<int>(
                                value: clinicCubit.sortModel[index]['id'],
                                groupValue: clinicCubit.sortValue,
                                onChanged: (value) =>
                                    clinicCubit.selectSort(value!),
                                name: clinicCubit.sortModel[index]['name'],
                                index: index,
                              );
                            },
                            itemCount: clinicCubit.sortModel.length,
                          ),
                          const Spacer(),
                          ElevatedButtonCustom(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            text: LocaleKeys.sort,
                            fontWeight: FontWeightManager.bold,
                            fontSize: FontSize.s18,
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        });
  }

  bottomSheetServices(BuildContext context) {
    return showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.all(AppPadding.p10),
            height: AppSize.s100 * 4,
            decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppSize.s24.r),
                    topRight: Radius.circular(AppSize.s24.r))),
            child: Material(
              child: SingleChildScrollView(
                child: BlocProvider(
                  create: (context) => VendorReviewsCubit(),
                  child: BlocConsumer<VendorReviewsCubit, VendorReviewsState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      var cubit = VendorReviewsCubit.get(context);
                      return SizedBox(
                        width: context.width,
                        child: Column(
                          children: [
                            TextCustom(
                              text: LocaleKeys.filterBy,
                              fontSize: FontSize.s18,
                              fontWeight: FontWeightManager.bold,
                            ),
                            ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return SelectWidgetCustom<int>(
                                  value: cubit.serviceFilterModel[index]['id'],
                                  groupValue: cubit.sortValue,
                                  onChanged: (value) =>
                                      cubit.selectSort(value!),
                                  name: cubit.serviceFilterModel[index]['name'],
                                  // price: clinicCubit.sortModel[index]['price'],
                                  // rate: clinicCubit.sortModel[index]['rate'],
                                  index: index,
                                );
                              },
                              itemCount: ImageNetwork.serviceNames.length,
                            ),
                            const SizedBox(
                              height: AppSize.s16,
                            ),
                            ElevatedButtonCustom(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              text: LocaleKeys.filter,
                              fontWeight: FontWeightManager.bold,
                              fontSize: FontSize.s18,
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        });
  }
}
