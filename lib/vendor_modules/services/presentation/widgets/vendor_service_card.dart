import 'package:doctor_ack/core/utils/media_query_values.dart';
import 'package:doctor_ack/core/utils/routes_manager.dart';
import 'package:doctor_ack/core/utils/styles_manager.dart';
import 'package:doctor_ack/core/widgets/component.dart';
import 'package:doctor_ack/core/widgets/elevated_button/elevated_button_custom.dart';
import '../../../../core/widgets/cached_image/cached_network_image.dart';
import 'package:doctor_ack/languages/locale_keys.g.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/packages_imprts.dart';

import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/svg_pic/svg_pic.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../../../../modules/service/presentation/controller/service_cubit.dart';
import '../manager/services_cubit.dart';
import '../manager/services_state.dart';

class VendorServiceCardWidget extends StatelessWidget {
  final int index;

  final String? imageUrl;
  final String? name;
  final String? about;
  final String? rate;
  final String? price;
  final int? id;

  const VendorServiceCardWidget({
    required this.index,
    this.id = 0,
    this.imageUrl = '',
    this.about = '',
    this.price = '0',
    this.name = 'Hydra Facial',
    this.rate = '4.5',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServicesCubit, ServicesState>(
      listener: (context, state) {},
      builder: (context, state) {
        var serviceCubit = ServicesCubit.get(context);
        return Container(
          height: (AppSize.s100 * 2.3).h,
          width: context.tablet ? (AppSize.s100 * 1.61).w : context.width / 2.4,
          decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(AppSize.s20.r)),
          child: Stack(
            children: [
              Container(
                height: (AppSize.s100 * 1.75).h,
                width: (AppSize.s100 * 1.6).w,
                decoration: BoxDecoration(
                    color: index % 2 == 0
                        ? ColorManager.pink
                        : ColorManager.yellowL,
                    borderRadius: BorderRadius.circular(AppSize.s20.r)),
                child: Stack(
                  children: [
                    const Align(
                        alignment: Alignment.bottomCenter,
                        child: SvgPictureCustom(
                          assetsName: IconAssets.circle,
                          color: null,
                          height: AppSize.s80,
                          width: AppSize.s80,
                        )),
                    Align(
                        alignment: Alignment.center,
                        child: SvgPictureCustom(
                          assetsName: index % 2 == 0
                              ? IconAssets.lineB
                              : IconAssets.lineT,
                          color: null,
                          height: AppSize.s80,
                          width: AppSize.s80,
                        )),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(AppSize.s20.r),
                            bottomRight: Radius.circular(AppSize.s20.r)),
                        child: CachedNetworkImageCustom(
                            height: (AppSize.s100 * 1).h,
                            width: AppSize.s100.w,
                            boxFit: BoxFit.cover,
                            boarder: AppSize.s0,
                            url: imageUrl!),
                      ),
                    ),
                    Positioned(
                      top: AppSize.s16,
                      left: AppSize.s10,
                      child: TextCustom(
                        textStyle: getMediumGilroyStyle(
                            color: ColorManager.black, fontSize: FontSize.s12),
                        text: '${LocaleKeys.aED.tr()} $price',
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                // bottom:-10,
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.all(AppPadding.p6),
                  width: (AppSize.s100 * 1.35).w,
                  height: AppSize.s60.h * 1.5,
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.circular(AppSize.s10.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: AppSize.s100.w * 1.1,
                        child: TextCustom(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          textStyle: getMediumGilroyStyle(
                            color: ColorManager.black,
                            fontSize: FontSize.s12,
                          ),
                          text: name!,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButtonCustom(
                            width: AppSize.s60 - 2,
                            height: AppSize.s20,
                            colors: ColorManager.white,
                            borderColor: ColorManager.grey,
                            text: LocaleKeys.edit,
                            textStyle: getMediumGilroyStyle(
                              color: ColorManager.grey,
                              fontSize: FontSize.s12,
                            ),
                            onPressed: () {
                              serviceCubit.image = imageUrl!;
                              serviceCubit.nameController.text = name!;
                              serviceCubit.priceController.text = price!;
                              serviceCubit.aboutController.text = about!;
                              serviceCubit.serviceID = id!;
                              navigator(context, Routes.editServiceRoute);
                            },
                          ),
                          ElevatedButtonCustom(
                            width: AppSize.s60 - 2,
                            height: AppSize.s20,
                            colors: ColorManager.secondary1,
                            borderColor: ColorManager.secondary1,
                            text: LocaleKeys.show,
                            textStyle: getMediumGilroyStyle(
                              color: ColorManager.white,
                              fontSize: FontSize.s12,
                            ),
                            onPressed: () {
                              ServiceCubit.get(context).serviceID = id!;
                              navigator(context, Routes.serviceRoute);
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: AppSize.s70,
                right: AppSize.s20,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppPadding.p6, vertical: AppPadding.p2),
                  height: AppSize.s20.h,
                  width: AppSize.s50.w,
                  decoration: BoxDecoration(
                      color: ColorManager.primary,
                      borderRadius: BorderRadius.circular(AppSize.s30.r)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPictureCustom(
                        assetsName: IconAssets.star2,
                        color: null,
                        height: AppSize.s16.h,
                        width: AppSize.s16.w,
                      ),
                      TextCustom(
                        textStyle: TextStyle(
                          fontFamily: 'Gilroy',
                          fontSize: FontSize.s12,
                          color: ColorManager.white,
                          fontWeight: FontWeightManager.regular,
                        ),
                        text: '4.5',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
