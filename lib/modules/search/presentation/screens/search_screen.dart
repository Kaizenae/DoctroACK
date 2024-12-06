// ignore_for_file: library_prefixes

import 'package:doctor_ack/core/utils/media_query_values.dart';
import 'package:doctor_ack/core/utils/routes_manager.dart';
import 'package:doctor_ack/core/utils/styles_manager.dart';
import 'package:doctor_ack/core/widgets/component.dart';
import 'package:doctor_ack/core/widgets/error_widget.dart';
import '../../../../core/widgets/cached_image/cached_network_image.dart';
import 'package:doctor_ack/core/widgets/shimmer_custom/shimmer_custom.dart';
import 'package:doctor_ack/injection_imports.dart';
import 'package:doctor_ack/languages/locale_keys.g.dart';
import 'package:doctor_ack/modules/search/presentation/controllers/locale_search_cubit/local_search_state.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/packages_imprts.dart';
import 'package:speech_to_text/speech_to_text.dart' as speechToText;

import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/app_bar/app_bar_custom.dart';
import '../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../../../../core/widgets/svg_pic/svg_pic.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../../../../core/widgets/text_form_field/text_form_field_custom.dart';
import '../../../../injection_container.dart';
import '../controllers/locale_search_cubit/local_search_cubit.dart';

List<String> recentSearch = [
  'Mariska Clinic',
  'Skin & Hair Clinic',
  'Skin Glow Clinic',
  'Moil\'s clinic',
];

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late speechToText.SpeechToText speech;
  String textString = "Press The Button";
  bool isListen = false;
  double confidence = 1.0;

  void listen() async {
    if (!isListen) {
      bool avail = await speech.initialize();
      if (avail) {
        setState(() {
          isListen = true;
        });
        speech.listen(onResult: (value) {
          setState(() {
            SearchServicesCubit.get(context).searchController.text =
                value.recognizedWords;
            if (value.hasConfidenceRating && value.confidence > 0) {
              confidence = value.confidence;
              SearchServicesCubit.get(context).getSearchServices();
            }
          });
        });
      }
    } else {
      setState(() {
        isListen = false;
      });
      speech.stop();
    }
  }

  @override
  void initState() {
    super.initState();
    speech = speechToText.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: ScaffoldCustom(
        appBarCustom: const AppBarCustom(
          text: LocaleKeys.search,
          isNull: false,
          centerTitle: false,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.p20),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: BlocProvider(
              create: (context) => sl<SearchServicesCubit>(),
              child: BlocBuilder<SearchServicesCubit, SearchServicesState>(
                builder: (context, state) {
                  var searchServicesCubit = SearchServicesCubit.get(context);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormFieldCustom(
                          radius: AppSize.s24.r,
                          hint: LocaleKeys.searchFor.tr(),
                          controller: searchServicesCubit.searchController,
                          hintSize: FontSize.s12,
                          prefix: true,
                          prefixIcon: SvgPictureCustom(
                            assetsName: IconAssets.search,
                            height: AppSize.s18.h,
                            width: AppSize.s18.w,
                          ),
                          onSaved: (p0) {
                            LocalSearchCubit.get(context).addToSearch(
                                SavedSearchEntity(
                                    name: searchServicesCubit
                                        .searchController.text));

                            // searchServicesCubit.getSearchServices();
                          },
                          onTab: () {
                            searchServicesCubit.changeRecent(true);
                          },
                          onEditingComplete: () async {
                            await LocalSearchCubit.get(context).addToSearch(
                                SavedSearchEntity(
                                    id: 1,
                                    name: searchServicesCubit
                                        .searchController.text));
                            searchServicesCubit.changeRecent(false);

                            searchServicesCubit.getSearchServices();
                          },
                          suffix: true,
                          suffixColor: isListen
                              ? ColorManager.secondary
                              : ColorManager.grey,
                          suffixIcon: IconAssets.voice,
                          suffixOnPressed: () {
                            listen();
                          },
                          validate: (validate) {
                            return '';
                          }),
                      RSizedBox.vertical(AppSize.s16.h),
                      Visibility(
                        visible: searchServicesCubit.recent,
                        child: Container(
                          padding: EdgeInsets.all(AppPadding.p20),
                          width: AppSize.s100.w * 3.43,
                          // height: AppSize.s100.h * 1.86,
                          decoration: ShapeDecoration(
                            color: ColorManager.white1,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(AppSize.s14.r),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextCustom(
                                text: LocaleKeys.recentSearch,
                                textStyle: getSemiBoldGilroyStyle(
                                  color: ColorManager.primary,
                                  fontSize: FontSize.s22,
                                ),
                              ),
                              RSizedBox.vertical(AppSize.s8.w),
                              BlocProvider.value(
                                value:
                                    BlocProvider.of<LocalSearchCubit>(context)
                                      ..initDatabase()
                                      ..getSearchItems(),
                                child: BlocBuilder<LocalSearchCubit,
                                    LocalSearchState>(
                                  builder: (context, searchState) {
                                    return searchState is GetSearchSuccessState
                                        ? ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: searchState
                                                .savedSearchEntity.length,
                                            itemBuilder: (context, index) =>
                                                InkWell(
                                              onTap: () {
                                                searchServicesCubit
                                                        .searchController.text =
                                                    searchState
                                                        .savedSearchEntity[
                                                            index]
                                                        .name;
                                                searchServicesCubit
                                                    .changeRecent(false);
                                                searchServicesCubit
                                                    .getSearchServices();
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    top: AppPadding.p10),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      // margin: EdgeInsets.only(
                                                      //     top: AppMargin.m12),
                                                      width: AppSize.s8.h,
                                                      height: AppSize.s8.h,
                                                      decoration:
                                                          const ShapeDecoration(
                                                        color: ColorManager
                                                            .secondary1,
                                                        shape: OvalBorder(),
                                                      ),
                                                    ),
                                                    RSizedBox.horizontal(
                                                        AppSize.s8.w),
                                                    TextCustom(
                                                      text: searchState
                                                          .savedSearchEntity[
                                                              index]
                                                          .name,
                                                      textStyle:
                                                          getMediumGilroyStyle(
                                                        color: ColorManager
                                                            .primary,
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    InkWell(
                                                        onTap: () {
                                                          LocalSearchCubit.get(
                                                                  context)
                                                              .removeFromSearch(
                                                                  searchState
                                                                      .savedSearchEntity[
                                                                          index]
                                                                      .id!);
                                                        },
                                                        child:
                                                            const SvgPictureCustom(
                                                          assetsName:
                                                              IconAssets.delete,
                                                          color:
                                                              ColorManager.red,
                                                          height: AppSize.s18,
                                                          width: AppSize.s18,
                                                        ))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        : const SizedBox();
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      RSizedBox.vertical(AppSize.s16.h),
                      const Align(
                        alignment: AlignmentDirectional.topStart,
                        child: TextCustom(
                          text: LocaleKeys.services,
                        ),
                      ),
                      RSizedBox.vertical(AppSize.s16.h),
                      switch (state) {
                        GetSearchServicesSuccessState() => SizedBox(
                            width: context.width - 40,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.searchServicesEntity.resultEntity
                                  .response.services.length,
                              itemBuilder: (context, index) => Container(
                                padding: EdgeInsets.all(AppPadding.p12),
                                margin: EdgeInsets.only(bottom: AppMargin.m8),
                                width: AppSize.s100.w * 3.43,
                                height: AppSize.s100.h * 1.18,
                                decoration: ShapeDecoration(
                                  color: ColorManager.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    ServiceCubit.get(context).serviceID = state
                                        .searchServicesEntity
                                        .resultEntity
                                        .response
                                        .services[index]
                                        .id;
                                    ServiceCubit.get(context).serviceName =
                                        state.searchServicesEntity.resultEntity
                                            .response.services[index].name;
                                    navigator(
                                        context, Routes.serviceClinicRoute);
                                  },
                                  child: Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CachedNetworkImageCustom(
                                              boarder: AppSize.s30.r,
                                              height: AppSize.s60.h,
                                              width: AppSize.s60.h,
                                              url: state
                                                  .searchServicesEntity
                                                  .resultEntity
                                                  .response
                                                  .services[index]
                                                  .image,
                                              boxFit: BoxFit.fill),
                                          Row(
                                            children: [
                                              const SvgPictureCustom(
                                                assetsName:
                                                    IconAssets.locationIcon,
                                                color: ColorManager.white,
                                              ),
                                              SizedBox(
                                                width: AppSize.s4.w,
                                              ),
                                              TextCustom(
                                                text: state
                                                    .searchServicesEntity
                                                    .resultEntity
                                                    .response
                                                    .services[index]
                                                    .city,
                                                textStyle:
                                                    getSemiBoldGilroyStyle(
                                                  fontSize: FontSize.s12,
                                                  color: ColorManager.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      RSizedBox.horizontal(AppSize.s20.w),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                            width: (AppSize.s100 * 2.2).w,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: TextCustom(
                                                    text: state
                                                        .searchServicesEntity
                                                        .resultEntity
                                                        .response
                                                        .services[index]
                                                        .name,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontSize: FontSize.s16,
                                                    color: ColorManager.white,
                                                    fontWeight:
                                                        FontWeightManager
                                                            .medium,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    SvgPictureCustom(
                                                      assetsName:
                                                          IconAssets.star2,
                                                      height: AppSize.s18.h,
                                                      width: AppSize.s18.h,
                                                      color: null,
                                                    ),
                                                    SizedBox(
                                                      width: AppSize.s4.w,
                                                    ),
                                                    TextCustom(
                                                      text: state
                                                          .searchServicesEntity
                                                          .resultEntity
                                                          .response
                                                          .services[index]
                                                          .rate
                                                          .toStringAsFixed(1),
                                                      textStyle:
                                                          getSemiBoldGilroyStyle(
                                                        fontSize: FontSize.s12,
                                                        color:
                                                            ColorManager.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                (AppSize.s100 * 2.2).w,
                                            child: TextCustom(
                                              text: state
                                                  .searchServicesEntity
                                                  .resultEntity
                                                  .response
                                                  .services[index]
                                                  .description,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              textStyle: getSemiBoldGilroyStyle(
                                                fontSize: FontSize.s12,
                                                color: ColorManager.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        GetSearchServicesErrorState() =>
                          ErrorsWidget(text: state.message),
                        GetSearchServicesLoadingState() => ShimmerCustom(
                              child: Container(
                            width: AppSize.s100.w * 3.43,
                            height: AppSize.s100.h * 1.18,
                            decoration: ShapeDecoration(
                              color: ColorManager.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          )),
                        _ => const SizedBox()
                      },
                      RSizedBox.vertical(AppSize.s16.h),
                      const Align(
                        alignment: AlignmentDirectional.topStart,
                        child: TextCustom(
                          text: LocaleKeys.allClinics,
                        ),
                      ),
                      RSizedBox.vertical(AppSize.s16.h),
                      switch (state) {
                        GetSearchServicesSuccessState() => SizedBox(
                            width: context.width - 40,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.searchServicesEntity.resultEntity
                                  .response.clinics.length,
                              itemBuilder: (context, index) => Container(
                                padding: EdgeInsets.all(AppPadding.p12),
                                margin: EdgeInsets.only(bottom: AppMargin.m8),
                                width: AppSize.s100.w * 3.43,
                                height: AppSize.s100.h,
                                decoration: ShapeDecoration(
                                  color: ColorManager.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    ClinicCubit.get(context).clinicID = state
                                        .searchServicesEntity
                                        .resultEntity
                                        .response
                                        .clinics[index]
                                        .id;
                                    navigator(context, Routes.clinicRoute);
                                  },
                                  child: Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CachedNetworkImageCustom(
                                              boarder: AppSize.s30.r,
                                              height: AppSize.s60.h,
                                              width: AppSize.s60.h,
                                              url: state
                                                  .searchServicesEntity
                                                  .resultEntity
                                                  .response
                                                  .clinics[index]
                                                  .image,
                                              boxFit: BoxFit.fill),
                                        ],
                                      ),
                                      RSizedBox.horizontal(AppSize.s20.w),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                            width: (AppSize.s100 * 2.2).w,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: TextCustom(
                                                    text: state
                                                        .searchServicesEntity
                                                        .resultEntity
                                                        .response
                                                        .clinics[index]
                                                        .name,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontSize: FontSize.s16,
                                                    color: ColorManager.white,
                                                    fontWeight:
                                                        FontWeightManager
                                                            .medium,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    SvgPictureCustom(
                                                      assetsName:
                                                          IconAssets.star2,
                                                      height: AppSize.s18.h,
                                                      width: AppSize.s18.h,
                                                      color: null,
                                                    ),
                                                    SizedBox(
                                                      width: AppSize.s4.w,
                                                    ),
                                                    TextCustom(
                                                      text: state
                                                          .searchServicesEntity
                                                          .resultEntity
                                                          .response
                                                          .clinics[index]
                                                          .rate
                                                          .toStringAsFixed(1),
                                                      textStyle:
                                                          getSemiBoldGilroyStyle(
                                                        fontSize: FontSize.s12,
                                                        color:
                                                            ColorManager.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                (AppSize.s100 * 2.2).w,
                                            child: TextCustom(
                                              text: state
                                                  .searchServicesEntity
                                                  .resultEntity
                                                  .response
                                                  .clinics[index]
                                                  .description,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              textStyle: getSemiBoldGilroyStyle(
                                                fontSize: FontSize.s12,
                                                color: ColorManager.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        GetSearchServicesErrorState() =>
                          ErrorsWidget(text: state.message),
                        GetSearchServicesLoadingState() => ShimmerCustom(
                              child: Container(
                            width: AppSize.s100.w * 3.43,
                            height: AppSize.s100.h * 1.18,
                            decoration: ShapeDecoration(
                              color: ColorManager.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          )),
                        _ => const SizedBox()
                      },
                      Visibility(
                        visible: false,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RSizedBox.vertical(AppSize.s16.h),
                            Container(
                              padding: EdgeInsets.all(AppPadding.p20),
                              width: AppSize.s100.w * 3.43,
                              // height: AppSize.s100.h * 1.86,
                              decoration: ShapeDecoration(
                                color: ColorManager.white1,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s14.r),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextCustom(
                                    text: LocaleKeys.suggested,
                                    textStyle: getSemiBoldGilroyStyle(
                                      color: ColorManager.primary,
                                      fontSize: FontSize.s22,
                                    ),
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: 4,
                                    itemBuilder: (context, index) => Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: AppPadding.p20),
                                          width: AppSize.s8.h,
                                          height: AppSize.s8.h,
                                          decoration: const ShapeDecoration(
                                            color: ColorManager.secondary1,
                                            shape: OvalBorder(),
                                          ),
                                        ),
                                        RSizedBox.horizontal(AppSize.s8.w),
                                        TextCustom(
                                          text: recentSearch[index],
                                          textStyle: getMediumGilroyStyle(
                                            color: ColorManager.primary,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
