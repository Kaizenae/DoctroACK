import 'package:doctor_ack/core/general_controllers/location_controller/location_cubit.dart';
import 'package:doctor_ack/core/utils/media_query_values.dart';
import 'package:doctor_ack/core/utils/routes_manager.dart';
import 'package:doctor_ack/core/utils/styles_manager.dart';
import 'package:doctor_ack/core/widgets/app_bar/app_bar_custom.dart';
import 'package:doctor_ack/core/widgets/component.dart';
import 'package:doctor_ack/core/widgets/elevated_button/elevated_button_custom.dart';
import 'package:doctor_ack/core/widgets/select_widget_custom/select_widget_custom.dart';
import 'package:doctor_ack/core/widgets/shimmer_custom/shimmer_horizontal.dart';
import 'package:doctor_ack/injection_imports.dart';
import 'package:doctor_ack/languages/locale_keys.g.dart';
import 'package:doctor_ack/modules/all_clinics/domain/entities/tags_entity.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/packages_imprts.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/cached_image/cached_network_image.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../../../../core/widgets/shimmer_custom/shimmer_custom.dart';
import '../../../../core/widgets/svg_pic/svg_pic.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../../../special_offers/presentation/controllers/offer_cubit/offer_state.dart';
import '../widgets/all_clinics_widget.dart';

class AllClinicsScreen extends StatelessWidget {
  const AllClinicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      appBarCustom: AppBarCustom(
        text: LocaleKeys.allClinics,
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
                      bottomSheetCustom(
                        height: 552,
                        context: context,
                        body: Material(
                          borderRadius: BorderRadius.circular(AppSize.s30.r),
                          child: BlocProvider.value(
                            value: BlocProvider.of<AllClinicsCubit>(context),
                            child:
                                BlocConsumer<AllClinicsCubit, AllClinicsState>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                var clinicCubit = AllClinicsCubit.get(context);
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
                                                  clinicCubit.clearSort();
                                                },
                                                child: TextCustom(
                                                  text: LocaleKeys.clear,
                                                  textStyle:
                                                      getMediumGilroyStyle(
                                                          color: ColorManager
                                                              .black,
                                                          fontSize:
                                                              FontSize.s14),
                                                )),
                                            SizedBox(
                                              height: AppSize.s30,
                                              child: Align(
                                                alignment:
                                                    Alignment.bottomCenter,
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
                                                padding: EdgeInsets.all(
                                                    AppPadding.p8),
                                                width: AppSize.s30.h,
                                                height: AppSize.s30.h,
                                                decoration:
                                                    const ShapeDecoration(
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
                                        BlocProvider.value(
                                          value: BlocProvider.of<TagsCubit>(
                                              context)
                                            ..getTags(),
                                          child:
                                              BlocBuilder<TagsCubit, TagsState>(
                                            builder: (context, tagsState) {
                                              if (tagsState
                                                  is GetTagsSuccessState) {
                                                tagsState.allClinicsEntity
                                                    .resultEntity.response
                                                    .add(const ResponseEntity(
                                                        id: 0,
                                                        name: LocaleKeys.all));
                                                return ListView.builder(
                                                  reverse: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return SelectWidgetCustom<
                                                        int>(
                                                      radius: AppSize.s20.r,
                                                      selectedColor:
                                                          ColorManager
                                                              .secondary1,
                                                      disabledColor:
                                                          ColorManager.white1,
                                                      index: index,
                                                      value: tagsState
                                                          .allClinicsEntity
                                                          .resultEntity
                                                          .response[index]
                                                          .id,
                                                      groupValue: clinicCubit
                                                          .filterValue,
                                                      onChanged: (value) =>
                                                          clinicCubit
                                                              .selectFilter(
                                                                  value!),
                                                      name: tagsState
                                                          .allClinicsEntity
                                                          .resultEntity
                                                          .response[index]
                                                          .name,
                                                    );
                                                  },
                                                  itemCount: tagsState
                                                      .allClinicsEntity
                                                      .resultEntity
                                                      .response
                                                      .length,
                                                );
                                              } else {
                                                return const ShimmerVertical();
                                              }
                                            },
                                          ),
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
                                              return BlocProvider.value(
                                                value: BlocProvider.of<
                                                    LocationCubit>(context),
                                                child: BlocBuilder<
                                                    LocationCubit,
                                                    LocationState>(
                                                  builder: (context, state) {
                                                    return SelectWidgetCustom<
                                                        String>(
                                                      radius: AppSize.s30,
                                                      selectedColor:
                                                          ColorManager
                                                              .secondary1,
                                                      disabledColor:
                                                          ColorManager.white1,
                                                      width:
                                                          AppSize.s100.w * 1.2,
                                                      titleWidth:
                                                          AppSize.s100.w * 1.8,
                                                      index: index,
                                                      value: clinicCubit
                                                              .sortClinicModel[
                                                          index]['id'],
                                                      groupValue:
                                                          clinicCubit.sortValue,
                                                      onChanged: (value) {
                                                        if (value == 'nearby') {
                                                          LocationCubit.get(
                                                                  context)
                                                              .getLocation();

                                                          clinicCubit.lat =
                                                              double.parse(
                                                                  LocationCubit.get(
                                                                          context)
                                                                      .lat);
                                                          clinicCubit.long =
                                                              double.parse(
                                                                  LocationCubit.get(
                                                                          context)
                                                                      .long);
                                                          clinicCubit
                                                              .selectSort(
                                                                  value!);
                                                        } else if (value !=
                                                            'nearby') {
                                                          clinicCubit
                                                              .selectSort(
                                                                  value!);
                                                        } else {
                                                          return;
                                                        }
                                                      },
                                                      name: clinicCubit
                                                              .sortClinicModel[
                                                          index]['name'],
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                            itemCount: clinicCubit
                                                .sortClinicModel.length,
                                          ),
                                        ),
                                        const RSizedBox.vertical(AppSize.s30),
                                        ElevatedButtonCustom(
                                          onPressed: () {
                                            clinicCubit.getAllClinics();
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
        controller: AllClinicsCubit.get(context).refreshController,
        onRefresh: () => AllClinicsCubit.get(context).getAllClinics(),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocProvider.value(
                value: BlocProvider.of<OfferCubit>(context),
                child: BlocBuilder<OfferCubit, OfferState>(
                  builder: (context, state) {
                    var offerCubit = OfferCubit.get(context);
                    return switch (state) {
                      GetOfferSuccessState() => ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                              state.offerEntity.resultEntity.response.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: AppPadding.p16,
                                  vertical: AppPadding.p4),
                              child: Container(
                                width: (AppSize.s100 * 3.4).w,
                                decoration: BoxDecoration(
                                    color: ColorManager.caffe,
                                    borderRadius:
                                        BorderRadius.circular(AppSize.s10.r)),
                                child: Stack(
                                  children: [
                                    CachedNetworkImageCustom(
                                        boarder: AppSize.s10.r,
                                        // color: ColorManager.caffe,
                                        width: (AppSize.s100 * 3.4).w,
                                        height: (AppSize.s100 * 1.6).h,
                                        boxFit: BoxFit.cover,
                                        url: state.offerEntity.resultEntity
                                            .response[index].image),
                                    Positioned(
                                      top: AppSize.s30,
                                      right: AppSize.s12,
                                      child: TextCustom(
                                        text: state.offerEntity.resultEntity
                                            .response[index].title,
                                        textStyle: TextStyle(
                                          fontFamily: 'Quentin',
                                          fontSize: FontSize.s40,
                                          color: ColorManager.white,
                                          fontWeight: FontWeightManager.regular,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: AppSize.s80,
                                      right: AppSize.s20,
                                      child: TextCustom(
                                        text: state.offerEntity.resultEntity
                                            .response[index].description,
                                        textStyle: TextStyle(
                                          fontFamily: 'Gilroy',
                                          fontSize: FontSize.s16,
                                          color: ColorManager.white,
                                          fontWeight: FontWeightManager.regular,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: AppSize.s16,
                                      right: AppSize.s22,
                                      child: ElevatedButtonCustom(
                                          width: AppSize.s100.w,
                                          height: AppSize.s28.h,
                                          onPressed: () {
                                            ServiceCubit.get(context)
                                                    .serviceID =
                                                state.offerEntity.resultEntity
                                                    .response[index].serviceId;
                                            navigator(context,
                                                Routes.serviceClinicRoute);
                                          },
                                          borderColor: ColorManager.white,
                                          radius: AppSize.s0,
                                          colors: Colors.transparent,
                                          widget: TextCustom(
                                            text: LocaleKeys.getNow,
                                            textStyle: TextStyle(
                                              fontFamily: 'Gilroy',
                                              fontSize: FontSize.s12,
                                              color: ColorManager.white,
                                              fontWeight:
                                                  FontWeightManager.regular,
                                            ),
                                          )),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      GetOfferErrorState() => ErrorsWidget(
                          onPress: () => offerCubit.getOffer(),
                          text: state.message,
                        ),
                      GetOfferLoadingState() => ShimmerCustom(
                            child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 4,
                          itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: AppPadding.p16,
                                vertical: AppPadding.p4),
                            child: Container(
                              width: (AppSize.s100 * 3.4).w,
                              decoration: BoxDecoration(
                                  color: ColorManager.lightGrey,
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s10.r)),
                            ),
                          ),
                        )),
                      _ => ShimmerCustom(
                            child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 4,
                          itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: AppPadding.p16,
                                vertical: AppPadding.p4),
                            child: Container(
                              width: (AppSize.s100 * 3.4).w,
                              decoration: BoxDecoration(
                                  color: ColorManager.lightGrey,
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s10.r)),
                            ),
                          ),
                        )),
                    };
                  },
                ),
              ),
              const SizedBox(height: 20),
              const AllClinicsWidget()
            ],
          ),
        ),
      ),
    );
  }
}
