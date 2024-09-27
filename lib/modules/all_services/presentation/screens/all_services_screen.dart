import 'package:doctor_ack/core/utils/media_query_values.dart';
import 'package:doctor_ack/core/utils/routes_manager.dart';
import 'package:doctor_ack/core/widgets/app_bar/app_bar_custom.dart';
import 'package:doctor_ack/core/widgets/component.dart';
import 'package:doctor_ack/core/widgets/elevated_button/elevated_button_custom.dart';
import 'package:doctor_ack/core/widgets/error_widget.dart';
import 'package:doctor_ack/core/widgets/select_widget_custom/select_widget_custom.dart';
import 'package:doctor_ack/core/widgets/shimmer_custom/shimmer_horizontal.dart';
import 'package:doctor_ack/languages/locale_keys.g.dart';
import 'package:doctor_ack/modules/all_services/presentation/controllers/all_clinics_cubit/all_services_cubit.dart';
import 'package:doctor_ack/modules/categories/presentation/controllers/cubit/get_categories_cubit.dart';
import 'package:doctor_ack/modules/categories/presentation/controllers/cubit/get_categories_state.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/styles_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../../../../core/widgets/svg_pic/svg_pic.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../widgets/all_services_widget.dart';
import '../../../../core/utils/packages_imprts.dart';

class AllServicesScreen extends StatelessWidget {
  const AllServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      appBarCustom: AppBarCustom(
        text: LocaleKeys.services,
        actions: [
          Container(
            margin: EdgeInsets.only(right: AppPadding.p16),
            width: (AppSize.s80 * 1.05).w,
            height: AppSize.s40.h,
            decoration: BoxDecoration(
              color: ColorManager.white1,
              borderRadius: BorderRadius.circular(AppSize.s20.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () {
                      AllServicesCubit.get(context).clinicId = 0;

                      bottomSheetCustom(
                        height: 552,
                        context: context,
                        body: Material(
                          color: ColorManager.white,
                          surfaceTintColor: ColorManager.white,
                          borderRadius: BorderRadius.circular(AppSize.s30.r),
                          child:
                              BlocConsumer<AllServicesCubit, AllServicesState>(
                            listener: (context, allServicesState) {},
                            builder: (context, allServicesState) {
                              var allServicesCubit =
                                  AllServicesCubit.get(context);
                              return SizedBox(
                                width: context.width,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: AppPadding.p10),
                                  child: Column(
                                    children: [
                                      const RSizedBox.vertical(AppSize.s16),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextButton(
                                              onPressed: () {
                                                allServicesCubit.clearFilter();
                                              },
                                              child: TextCustom(
                                                text: LocaleKeys.clear,
                                                textStyle: getMediumGilroyStyle(
                                                    color: ColorManager.black,
                                                    fontSize: FontSize.s14),
                                              )),
                                          SizedBox(
                                            height: AppSize.s30,
                                            child: Align(
                                              alignment: Alignment.bottomCenter,
                                              child: TextCustom(
                                                text: LocaleKeys.filter,
                                                fontSize: FontSize.s18,
                                                fontWeight:
                                                    FontWeightManager.bold,
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: Container(
                                              // margin: EdgeInsets.only(top: AppPadding.p16,right: AppPadding.p16),
                                              padding:
                                                  EdgeInsets.all(AppPadding.p8),
                                              width: AppSize.s30.h,
                                              height: AppSize.s30.h,
                                              decoration: const ShapeDecoration(
                                                color: ColorManager.white1,
                                                shape: OvalBorder(),
                                              ),
                                              child: const SvgPictureCustom(
                                                assetsName: IconAssets.close,
                                                color: null,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      BlocBuilder<GetCategoriesCubit,
                                          CategoriesStates>(
                                        builder: (context, state) {
                                          var categoriesCubit =
                                              GetCategoriesCubit.get(context);
                                          return switch (state) {
                                            GetCategoriesSuccessState() =>
                                              ListView.builder(
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) {
                                                  return SelectWidgetCustom<
                                                      int>(
                                                    radius: AppSize.s20.r,
                                                    selectedColor:
                                                        ColorManager.secondary1,
                                                    disabledColor:
                                                        ColorManager.white1,
                                                    index: index,
                                                    value: state
                                                        .categoriesEntity
                                                        .resultEntity
                                                        .response[index]
                                                        .id,
                                                    groupValue: allServicesCubit
                                                        .categoryId,
                                                    onChanged: (value) =>
                                                        allServicesCubit
                                                            .selectFilter(
                                                                value!),
                                                    name: state
                                                        .categoriesEntity
                                                        .resultEntity
                                                        .response[index]
                                                        .name,
                                                  );
                                                },
                                                itemCount: state
                                                    .categoriesEntity
                                                    .resultEntity
                                                    .response
                                                    .length,
                                              ),
                                            GetCategoriesErrorState() =>
                                              ErrorsWidget(
                                                text: state.message,
                                                onPress: () => categoriesCubit
                                                    .getCategories(),
                                              ),
                                            GetCategoriesLoadingState() =>
                                              const ShimmerVertical(),
                                            _ => const SizedBox(),
                                          };
                                        },
                                      ),
                                      const RSizedBox.vertical(AppSize.s24),
                                      TextCustom(
                                        text: LocaleKeys.sortBy,
                                        fontSize: FontSize.s18,
                                        fontWeight: FontWeightManager.bold,
                                      ),
                                      const RSizedBox.vertical(AppSize.s20),
                                      SizedBox(
                                        // width: context.width/1.1,
                                        height: AppSize.s60,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            return SelectWidgetCustom<String>(
                                              radius: AppSize.s30,
                                              selectedColor:
                                                  ColorManager.secondary1,
                                              disabledColor:
                                                  ColorManager.white1,
                                              width: AppSize.s100.w * 1.2,
                                              titleWidth: AppSize.s100.w * 1.8,
                                              index: index,
                                              value: allServicesCubit
                                                  .sortModel[index]['id'],
                                              groupValue:
                                                  allServicesCubit.sortBy,
                                              onChanged: (value) =>
                                                  allServicesCubit
                                                      .selectSort(value!),
                                              name: allServicesCubit
                                                  .sortModel[index]['name'],
                                            );
                                          },
                                          itemCount:
                                              allServicesCubit.sortModel.length,
                                        ),
                                      ),
                                      const RSizedBox.vertical(AppSize.s30),
                                      ElevatedButtonCustom(
                                        onPressed: () {
                                          allServicesCubit.getAllServices();
                                          Navigator.pop(context);
                                        },
                                        text: LocaleKeys.apply,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                    child: const SvgPictureCustom(
                      assetsName: IconAssets.filter,
                      color: ColorManager.secondary,
                    )),
                const VerticalDivider(
                    color: ColorManager.divider,
                    thickness: 0.8,
                    width: AppSize.s18,
                    indent: 6.0,
                    endIndent: 6),
                InkWell(
                    onTap: () {
                      navigator(context, Routes.searchRoute);
                    },
                    child:
                        const SvgPictureCustom(assetsName: IconAssets.search)),
              ],
            ),
          ),
        ],
      ),
      body: SmartRefresher(
        controller: AllServicesCubit.get(context).refreshController,
        onRefresh: () {
          AllServicesCubit.get(context).clinicId = 0;
          AllServicesCubit.get(context).categoryId = 0;
          AllServicesCubit.get(context).getAllServices();
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: AppPadding.p16),
            child: const Column(
              children: [AllServicesWidget()],
            ),
          ),
        ),
      ),
    );
  }
}
