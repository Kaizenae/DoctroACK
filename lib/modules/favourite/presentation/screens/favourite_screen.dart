import 'package:doctor_ack/core/utils/color_manager.dart';
import 'package:doctor_ack/core/utils/font_manager.dart';
import 'package:doctor_ack/core/utils/media_query_values.dart';
import 'package:doctor_ack/core/utils/routes_manager.dart';
import 'package:doctor_ack/core/utils/styles_manager.dart';
import 'package:doctor_ack/core/widgets/component.dart';
import 'package:doctor_ack/core/widgets/elevated_button/elevated_button_custom.dart';
import 'package:doctor_ack/core/widgets/empty.dart';
import 'package:doctor_ack/core/widgets/error_widget.dart';
import 'package:doctor_ack/core/widgets/shimmer_custom/shimmer_horizontal.dart';
import 'package:doctor_ack/core/widgets/tab_bar_custom/tab_bar_custom.dart';
import 'package:doctor_ack/languages/locale_keys.g.dart';
import 'package:doctor_ack/modules/favourite/presentation/controllers/favourites_cubit/favourites_cubit.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/packages_imprts.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/app_bar/app_bar_custom.dart';
import '../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../widgets/fav_clinic_card_widget.dart';
import '../widgets/fav_service_card_widget.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      appBarCustom: const AppBarCustom(
        text: LocaleKeys.favorite,
        isNull: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            BlocProvider.value(
              value: BlocProvider.of<FavouritesCubit>(context)..getFavourite(),
              child: BlocBuilder<FavouritesCubit, FavouritesState>(
                builder: (context, state) {
                  var favCubit = FavouritesCubit.get(context);
                  return switch (state) {
                    GetFavouriteSuccessState() => TabBarCustom(
                        radius: AppSize.s24.r,
                        myTabs: [
                          Tab(
                            text: LocaleKeys.allClinics.tr(),
                          ),
                          Tab(
                            text: LocaleKeys.services.tr(),
                          )
                        ],
                        widgets: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: AppPadding.p20,
                              bottom: AppPadding.p4,
                              right: AppPadding.p16,
                              left: AppPadding.p16,
                            ),
                            child: SmartRefresher(
                              controller: favCubit.refreshController,
                              onRefresh: () => favCubit.getFavourite(),
                              child: SingleChildScrollView(
                                child: state.favouriteEntity.resultEntity
                                        .responseClinics.isEmpty
                                    ? SizedBox(
                                        height: context.height / 1.5,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const EmptyWidget(
                                                title: LocaleKeys
                                                    .emptyFavouriteClinic),
                                            SizedBox(
                                              height: AppSize.s90.h,
                                            ),
                                            ElevatedButtonCustom(
                                              width: (AppSize.s100 * 3).w,
                                              radius: AppSize.s50.r,
                                              onPressed: () {
                                                navigator(context,
                                                    Routes.allClinicsScreen);
                                              },
                                              text: LocaleKeys.addToFavorites,
                                              textStyle: getSemiBoldGilroyStyle(
                                                  color: ColorManager.white,
                                                  fontSize: FontSize.s16),
                                            )
                                          ],
                                        ),
                                      )
                                    : Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        alignment: WrapAlignment.start,
                                        runAlignment: WrapAlignment.center,
                                        runSpacing: AppSize.s16,
                                        spacing: AppSize.s20,
                                        children: List.generate(
                                            state.favouriteEntity.resultEntity
                                                .responseClinics.length,
                                            (index) => FadeIn(
                                                  // duration: const Duration(milliseconds: 250),

                                                  child: FavClinicCardWidget(
                                                      id: state
                                                          .favouriteEntity
                                                          .resultEntity
                                                          .responseClinics[
                                                              index]
                                                          .id,
                                                      description: state
                                                          .favouriteEntity
                                                          .resultEntity
                                                          .responseClinics[
                                                              index]
                                                          .description,
                                                      name: state
                                                          .favouriteEntity
                                                          .resultEntity
                                                          .responseClinics[
                                                              index]
                                                          .name,
                                                      city: state
                                                          .favouriteEntity
                                                          .resultEntity
                                                          .responseClinics[
                                                              index]
                                                          .city,
                                                      imageUrl: state
                                                          .favouriteEntity
                                                          .resultEntity
                                                          .responseClinics[
                                                              index]
                                                          .image,
                                                      length: state
                                                          .favouriteEntity
                                                          .resultEntity
                                                          .responseClinics
                                                          .length,
                                                      network: true,
                                                      rate: state
                                                          .favouriteEntity
                                                          .resultEntity
                                                          .responseClinics[
                                                              index]
                                                          .rate
                                                          .toStringAsFixed(1),
                                                      key: const Key(
                                                          'FavoritesClinics'),
                                                      index: index),
                                                )),
                                      ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: AppPadding.p20,
                              bottom: AppPadding.p4,
                              right: AppPadding.p16,
                              left: AppPadding.p16,
                            ),
                            child: SmartRefresher(
                              controller: favCubit.refreshFavServicesController,
                              onRefresh: () => favCubit.getFavourite(),
                              child: SingleChildScrollView(
                                child: state.favouriteEntity.resultEntity
                                        .responseServices.isEmpty
                                    ? SizedBox(
                                        height: context.height / 1.5,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const EmptyWidget(
                                                title: LocaleKeys
                                                    .emptyFavouriteService),
                                            SizedBox(
                                              height: AppSize.s90.h,
                                            ),
                                            ElevatedButtonCustom(
                                              width: (AppSize.s100 * 3).w,
                                              radius: AppSize.s50.r,
                                              onPressed: () {
                                                navigator(context,
                                                    Routes.allServicesScreen);
                                              },
                                              text: LocaleKeys.addToFavorites,
                                              textStyle: getSemiBoldGilroyStyle(
                                                  color: ColorManager.white,
                                                  fontSize: FontSize.s16),
                                            )
                                          ],
                                        ),
                                      )
                                    : Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        alignment: WrapAlignment.start,
                                        runAlignment: WrapAlignment.center,
                                        runSpacing: AppSize.s16,
                                        spacing: AppSize.s20,
                                        children: List.generate(
                                            state.favouriteEntity.resultEntity
                                                .responseServices.length,
                                            (index) => FadeIn(
                                                  // duration: const Duration(milliseconds: 250),

                                                  child: FavServiceCardWidget(
                                                      id: state
                                                          .favouriteEntity
                                                          .resultEntity
                                                          .responseServices[
                                                              index]
                                                          .id,
                                                      name: state
                                                          .favouriteEntity
                                                          .resultEntity
                                                          .responseServices[
                                                              index]
                                                          .name,
                                                      rate: state
                                                          .favouriteEntity
                                                          .resultEntity
                                                          .responseServices[
                                                              index]
                                                          .rate
                                                          .toStringAsFixed(1),
                                                      // city: state.favouriteEntity.resultEntity.responseServices[index].,
                                                      imageUrl: state
                                                          .favouriteEntity
                                                          .resultEntity
                                                          .responseServices[
                                                              index]
                                                          .image,
                                                      key: const Key(
                                                          'FavoritesServices'),
                                                      index: index),
                                                )),
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    GetFavouriteErrorState() =>
                      ErrorsWidget(onPress: () => favCubit.getFavourite()),
                    GetFavouriteLoadingState() => const ShimmerVertical(),
                    _ => const SizedBox(),
                  };
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
