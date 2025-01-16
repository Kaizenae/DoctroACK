// ignore_for_file: file_names

import 'package:doctor_ack/core/utils/routes_manager.dart';
import 'package:doctor_ack/core/widgets/app_bar/app_bar_custom.dart';
import 'package:doctor_ack/core/widgets/component.dart';
import '../../../../core/widgets/cached_image/cached_network_image.dart';
import 'package:doctor_ack/core/widgets/scaffold_custom/scaffold_custom.dart';
import 'package:doctor_ack/core/widgets/shimmer_custom/shimmer_custom.dart';
import 'package:doctor_ack/core/widgets/svg_pic/svg_pic.dart';
import 'package:doctor_ack/languages/locale_keys.g.dart';
import 'package:doctor_ack/modules/service/presentation/controller/service_cubit.dart';
import 'package:doctor_ack/modules/special_offers/presentation/controllers/offer_cubit/offer_cubit.dart';
import 'package:doctor_ack/modules/special_offers/presentation/controllers/offer_cubit/offer_state.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/packages_imprts.dart';

import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/elevated_button/elevated_button_custom.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';

class SpecialOffersScreen extends StatelessWidget {
  const SpecialOffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      appBarCustom: AppBarCustom(
        text: LocaleKeys.featuredOffers,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const SvgPictureCustom(
                assetsName: IconAssets.search,
                color: ColorManager.caffe,
              ))
        ],
      ),
      body: BlocProvider.value(
        value: BlocProvider.of<OfferCubit>(context),
        child: BlocBuilder<OfferCubit, OfferState>(
          builder: (context, state) {
            var offerCubit = OfferCubit.get(context);
            return switch (state) {
              GetOfferSuccessState() => ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.offerEntity.resultEntity.response.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppPadding.p16, vertical: AppPadding.p4),
                      child: Container(
                        width: (AppSize.s100 * 3.4).w,
                        decoration: BoxDecoration(
                            color: ColorManager.caffe,
                            borderRadius: BorderRadius.circular(AppSize.s10.r)),
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
                                    ServiceCubit.get(context).serviceID = state
                                        .offerEntity
                                        .resultEntity
                                        .response[index]
                                        .serviceId;
                                    navigator(
                                        context, Routes.serviceClinicRoute);
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
                                      fontWeight: FontWeightManager.regular,
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
                        horizontal: AppPadding.p16, vertical: AppPadding.p4),
                    child: Container(
                      width: (AppSize.s100 * 3.4).w,
                      decoration: BoxDecoration(
                          color: ColorManager.lightGrey,
                          borderRadius: BorderRadius.circular(AppSize.s10.r)),
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
                        horizontal: AppPadding.p16, vertical: AppPadding.p4),
                    child: Container(
                      width: (AppSize.s100 * 3.4).w,
                      decoration: BoxDecoration(
                          color: ColorManager.lightGrey,
                          borderRadius: BorderRadius.circular(AppSize.s10.r)),
                    ),
                  ),
                )),
            };
          },
        ),
      ),
    );
  }
}
