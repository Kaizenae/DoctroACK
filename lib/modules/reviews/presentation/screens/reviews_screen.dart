import 'package:doctor_ack/core/utils/color_manager.dart';
import 'package:doctor_ack/core/utils/font_manager.dart';
import 'package:doctor_ack/core/utils/values_manager.dart';
import 'package:doctor_ack/core/widgets/app_bar/app_bar_custom.dart';
import 'package:doctor_ack/core/widgets/error_widget.dart';
import 'package:doctor_ack/core/widgets/scaffold_custom/scaffold_custom.dart';
import 'package:doctor_ack/core/widgets/shimmer_custom/shimmer_horizontal.dart';
import 'package:doctor_ack/core/widgets/text_custom/text_custom.dart';
import 'package:doctor_ack/modules/reviews/presentation/manager/controllers/reviews_cubit/reviews_cubit.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/packages_imprts.dart';

import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/styles_manager.dart';
import '../../../../core/widgets/svg_pic/svg_pic.dart';
import '../../../../languages/locale_keys.g.dart';
import '../widgets/review_card.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
        appBarCustom: AppBarCustom(
          centerTitle: false,
          text: ReviewsCubit.get(context).clinicName,
          actions: [
            Container(
              margin: EdgeInsets.only(
                right: AppPadding.p12,
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.p10, vertical: AppPadding.p8),
              height: AppSize.s40.h,
              width: AppSize.s90.w,
              decoration: ShapeDecoration(
                color: ColorManager.white1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s50.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPictureCustom(
                    assetsName: IconAssets.star2,
                    color: null,
                    height: AppSize.s24.h,
                    width: AppSize.s24.w,
                  ),
                  TextCustom(
                    textStyle: getMediumGilroyStyle(
                        color: ColorManager.primary, fontSize: FontSize.s20),
                    text: ReviewsCubit.get(context).clinicRate,
                  ),
                ],
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(AppPadding.p16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<ReviewsCubit, ReviewsState>(
                      builder: (context, state) {
                        return TextCustom(
                          text:
                              '${LocaleKeys.review.tr()} (${state is GetReviewsSuccessState ? state.reviewsEntity.resultEntity.response.length : ''})',
                          textStyle: getSemiBoldGilroyStyle(
                              color: ColorManager.primary,
                              fontSize: FontSize.s18,
                              height: 0.07),
                        );
                      },
                    ),
                    PopupMenuButton(
                      offset: const Offset(AppSize.s0, AppSize.s44),
                      // SET THE (X,Y) POSITION
                      // iconSize: 30,
                      color: ColorManager.white,
                      shadowColor: const Color(0x33A5A4A3),
                      icon: SvgPictureCustom(
                        assetsName: IconAssets.filter,
                        height: AppSize.s18.h,
                        width: AppSize.s18.h,
                      ),
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            // DISABLED THIS ITEM
                            child: Row(
                              children: [
                                TextCustom(
                                  text: '5 ${LocaleKeys.star.tr()}',
                                  textStyle: getSemiBoldGilroyStyle(
                                      color: ColorManager.primary,
                                      height: 0.07,
                                      fontSize: FontSize.s18),
                                ),
                                SizedBox(
                                  width: AppSize.s8.w,
                                ),
                                SvgPictureCustom(
                                  assetsName: IconAssets.star_5,
                                  color: null,
                                  height: AppSize.s24.h,
                                )
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            // DISABLED THIS ITEM
                            child: Row(
                              children: [
                                TextCustom(
                                  text: '4 ${LocaleKeys.star.tr()}',
                                  textStyle: getMediumGilroyStyle(
                                      color: ColorManager.grey,
                                      height: 0.07,
                                      fontSize: FontSize.s18),
                                ),
                                SizedBox(
                                  width: AppSize.s8.w,
                                ),
                                SvgPictureCustom(
                                  assetsName: IconAssets.star_4,
                                  color: null,
                                  height: AppSize.s24.h,
                                )
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            // DISABLED THIS ITEM
                            child: Row(
                              children: [
                                TextCustom(
                                  text: '3 ${LocaleKeys.star.tr()}',
                                  textStyle: getMediumGilroyStyle(
                                      color: ColorManager.grey,
                                      height: 0.07,
                                      fontSize: FontSize.s18),
                                ),
                                SizedBox(
                                  width: AppSize.s8.w,
                                ),
                                SvgPictureCustom(
                                  assetsName: IconAssets.star_3,
                                  color: null,
                                  height: AppSize.s24.h,
                                )
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            // DISABLED THIS ITEM
                            child: Row(
                              children: [
                                TextCustom(
                                  text: '2 ${LocaleKeys.star.tr()}',
                                  textStyle: getMediumGilroyStyle(
                                      color: ColorManager.grey,
                                      height: 0.07,
                                      fontSize: FontSize.s18),
                                ),
                                SizedBox(
                                  width: AppSize.s8.w,
                                ),
                                SvgPictureCustom(
                                  assetsName: IconAssets.star_2,
                                  color: null,
                                  height: AppSize.s24.h,
                                )
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            // DISABLED THIS ITEM
                            child: Row(
                              children: [
                                TextCustom(
                                  text: '1 ${LocaleKeys.star.tr()}',
                                  textStyle: getMediumGilroyStyle(
                                      color: ColorManager.grey,
                                      height: 0.07,
                                      fontSize: FontSize.s18),
                                ),
                                SizedBox(
                                  width: AppSize.s8.w,
                                ),
                                SvgPictureCustom(
                                  assetsName: IconAssets.star_1,
                                  color: null,
                                  height: AppSize.s24.h,
                                )
                              ],
                            ),
                          ),
                        ];
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: AppSize.s18.h,
                ),
                BlocProvider.value(
                  value: BlocProvider.of<ReviewsCubit>(context)..getReviews(),
                  child: BlocBuilder<ReviewsCubit, ReviewsState>(
                    builder: (context, state) {
                      var reviewCubit = ReviewsCubit.get(context);
                      return state is GetReviewsSuccessState
                          ? ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) => ReviewCard(
                                name: state.reviewsEntity.resultEntity
                                    .response[index].patient.name,
                                serviceName: state.reviewsEntity.resultEntity
                                    .response[index].service.name,
                                rate: state.reviewsEntity.resultEntity
                                    .response[index].reviewStar,
                                review: state.reviewsEntity.resultEntity
                                    .response[index].description,
                                date: '24/10/2023',
                              ),
                              itemCount: state
                                  .reviewsEntity.resultEntity.response.length,
                            )
                          : state is GetReviewsLoadingState
                              ? const ShimmerVertical()
                              : ErrorsWidget(
                                  onPress: () => reviewCubit.getReviews(),
                                );
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
