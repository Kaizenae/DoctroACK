import 'package:carousel_slider/carousel_slider.dart';
import 'package:doctor_ack/core/utils/color_manager.dart';
import 'package:doctor_ack/core/utils/font_manager.dart';
import 'package:doctor_ack/core/utils/routes_manager.dart';
import 'package:doctor_ack/core/utils/values_manager.dart';
import 'package:doctor_ack/core/widgets/component.dart';
import 'package:doctor_ack/core/widgets/elevated_button/elevated_button_custom.dart';
import 'package:doctor_ack/core/widgets/svg_pic/svg_pic.dart';
import 'package:doctor_ack/core/widgets/text_custom/text_custom.dart';
import 'package:doctor_ack/languages/locale_keys.g.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/packages_imprts.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/constants_manager.dart';
import '../../../../core/widgets/cached_image/cached_network_image.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../../core/widgets/shimmer_custom/shimmer_custom.dart';
import '../../../service/presentation/controller/service_cubit.dart';
import '../../../special_offers/presentation/controllers/offer_cubit/offer_cubit.dart';
import '../../../special_offers/presentation/controllers/offer_cubit/offer_state.dart';

class Banners extends StatelessWidget {
  final String title;
  const Banners({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<OfferCubit>(context)..getOffer(),
      child: BlocBuilder<OfferCubit, OfferState>(
        builder: (context, state) {
          var offerCubit = OfferCubit.get(context);
          return switch (state) {
            GetOfferSuccessState() => Visibility(
                visible: state.offerEntity.resultEntity.response.isNotEmpty,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                            child: Divider(
                          thickness: 0.2,
                          height: AppSize.s40,
                          color: ColorManager.red,
                          endIndent: AppSize.s20,
                          indent: 0,
                        )),
                        Expanded(
                          flex: 3,
                          child: TextCustom(
                            text: title.tr(),
                            fontSize: FontSize.s18,
                            fontWeight: FontWeightManager.bold,
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              navigator(context, Routes.specialOffersRoute);
                            },
                            icon: SvgPictureCustom(
                              assetsName: AppConstants.language
                                  ? IconAssets.arrowLeft
                                  : IconAssets.arrowRight,
                            ))
                      ],
                    ),
                    SizedBox(
                      height: AppSize.s8.h,
                    ),
                    CarouselSlider(
                      options: CarouselOptions(
                        height: (AppSize.s100 * 1.6).h,
                        // viewportFraction: 0.6,
                        animateToClosest: true,
                        autoPlayCurve: Curves.decelerate,
                        pauseAutoPlayOnTouch: true,
                        pauseAutoPlayOnManualNavigate: true,
                        autoPlay: true,
                        enableInfiniteScroll: false,
                        onPageChanged: (index, reason) {},
                      ),
                      items: List.generate(
                        state.offerEntity.resultEntity.response.length,
                        (index) => Padding(
                          padding: EdgeInsets.only(right: AppPadding.p10),
                          child: Container(
                            width: (AppSize.s100 * 3).w,
                            decoration: BoxDecoration(
                                color: ColorManager.caffe,
                                borderRadius:
                                    BorderRadius.circular(AppSize.s10.r)),
                            child: Stack(
                              children: [
                                CachedNetworkImageCustom(
                                    boarder: AppSize.s10.r,
                                    // color: ColorManager.caffe,
                                    width: (AppSize.s100 * 3).w,
                                    height: (AppSize.s100 * 1.6).h,
                                    boxFit: BoxFit.cover,
                                    url: state
                                        .offerEntity
                                        .resultEntity
                                        .response[index]
                                        .image),
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
                                        ServiceCubit.get(context).serviceID =
                                            state.offerEntity.resultEntity
                                                .response[index].serviceId;
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
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            GetOfferErrorState() => HErrorsWidget(
                onPress: () => offerCubit.getOffer(), text: state.message),
            GetOfferLoadingState() => Center(
                child: ShimmerCustom(
                    child: Container(
                  height: AppSize.s100 * 1.6,
                  width: (AppSize.s100 * 3).w,
                  decoration: BoxDecoration(
                      color: ColorManager.lightGrey,
                      borderRadius: BorderRadius.circular(AppSize.s10.r)),
                )),
              ),
            _ => Center(
                child: ShimmerCustom(
                    child: Container(
                  height: AppSize.s100 * 1.6,
                  width: (AppSize.s100 * 3).w,
                  decoration: BoxDecoration(
                      color: ColorManager.lightGrey,
                      borderRadius: BorderRadius.circular(AppSize.s10.r)),
                )),
              ),
          };
        },
      ),
    );
  }
}
