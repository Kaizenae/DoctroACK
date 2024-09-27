import 'dart:math';

import 'package:doctor_ack/core/utils/media_query_values.dart';
import 'package:doctor_ack/core/widgets/app_bar/app_bar_custom.dart';
import '../../../../core/widgets/cached_image/cached_network_image.dart';
import 'package:doctor_ack/core/widgets/scaffold_custom/scaffold_custom.dart';
import 'package:doctor_ack/core/widgets/shimmer_custom/shimmer_custom.dart';
import 'package:doctor_ack/languages/locale_keys.g.dart';
import 'package:doctor_ack/modules/categories/presentation/controllers/cubit/get_categories_cubit.dart';
import 'package:doctor_ack/modules/categories/presentation/controllers/cubit/get_categories_state.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/routes_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/component.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../../core/widgets/svg_pic/svg_pic.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../../../all_services/presentation/controllers/all_clinics_cubit/all_services_cubit.dart';
import '../../../../core/utils/packages_imprts.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
        appBarCustom: AppBarCustom(
          text: LocaleKeys.categories,
          actions: [
            Container(
              margin: EdgeInsets.only(right: AppPadding.p16),
              width: (AppSize.s20).w,
              height: AppSize.s20.h,
              decoration: BoxDecoration(
                color: ColorManager.white1,
                borderRadius: BorderRadius.circular(AppSize.s20.r),
              ),
              child: InkWell(
                  onTap: () {
                    navigator(context, Routes.searchRoute);
                  },
                  child: const SvgPictureCustom(assetsName: IconAssets.search)),
            ),
          ],
        ),
        body: SizedBox(
          width: context.width,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppPadding.p16, vertical: AppPadding.p20),
            child: BlocBuilder<GetCategoriesCubit, CategoriesStates>(
              builder: (context, state) {
                var categoriesCubit = GetCategoriesCubit.get(context);
                return switch (state) {
                  GetCategoriesSuccessState() => Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.center,
                      runAlignment: WrapAlignment.center,
                      runSpacing: AppSize.s16,
                      spacing: AppSize.s20,
                      children: List.generate(
                        state.categoriesEntity.resultEntity.response.length,
                        (index) => Container(
                          // margin: EdgeInsets.only(right: AppPadding.p20),
                          height: (AppSize.s100 * 1.76).h,
                          width: (AppSize.s100 * 1.61).w,
                          decoration: BoxDecoration(
                            color: ImageNetwork.categoryColor[Random()
                                .nextInt(ImageNetwork.categoryColor.length)],
                            borderRadius: BorderRadius.circular(AppSize.s20.r),
                          ),
                          child: InkWell(
                            onTap: () {
                              AllServicesCubit.get(context).categoryId = state
                                  .categoriesEntity
                                  .resultEntity
                                  .response[index]
                                  .id;
                              navigator(context, Routes.allServicesScreen);
                            },
                            child: Stack(
                              children: [
                                Positioned(
                                    bottom: -20,
                                    left: 20,
                                    // alignment: Alignment.bottomCenter,
                                    child: Container(
                                      width: 121,
                                      height: 119,
                                      decoration: const ShapeDecoration(
                                        color: Color(0xFFDEADAD),
                                        shape: OvalBorder(),
                                      ),
                                    )
                                    // SvgPictureCustom(
                                    //   assetsName: IconAssets.circle,
                                    //   color: null,
                                    //   height: AppSize.s80,
                                    //   width: AppSize.s80,
                                    // ),
                                    ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft:
                                            Radius.circular(AppSize.s20.r),
                                        bottomRight:
                                            Radius.circular(AppSize.s20.r)),
                                    child: CachedNetworkImageCustom(
                                        height: (AppSize.s100 * 1.38).h,
                                        // width: AppSize.s100.w,
                                        boxFit: BoxFit.fitHeight,
                                        boarder: AppSize.s0,
                                        url:
                                            state.categoriesEntity.resultEntity
                                                .response[index].icon),
                                  ),
                                ),
                                Positioned(
                                    top: AppSize.s20,
                                    left: AppSize.s10,
                                    child: TextCustom(
                                      textStyle: TextStyle(
                                        fontFamily: 'Gilroy',
                                        fontSize: FontSize.s14,
                                        fontWeight: FontWeightManager.regular,
                                      ),
                                      text: state.categoriesEntity.resultEntity
                                          .response[index].name,
                                      fontSize: FontSize.s14,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  GetCategoriesErrorState() => ErrorsWidget(
                      onPress: () => categoriesCubit.getCategories(),
                      text: state.message),
                  GetCategoriesLoadingState() => ShimmerCustom(
                        child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.center,
                      runAlignment: WrapAlignment.center,
                      runSpacing: AppSize.s16,
                      spacing: AppSize.s20,
                      children: List.generate(
                        4,
                        (index) => Container(
                          // margin: EdgeInsets.only(right: AppPadding.p20),
                          height: (AppSize.s100 * 1.76).h,
                          width: (AppSize.s100 * 1.61).w,
                          decoration: BoxDecoration(
                            color: ColorManager.lightGrey,
                            borderRadius: BorderRadius.circular(AppSize.s20.r),
                          ),
                        ),
                      ),
                    )),
                  _ => const SizedBox(),
                };
              },
            ),
          ),
        ));
  }
}
