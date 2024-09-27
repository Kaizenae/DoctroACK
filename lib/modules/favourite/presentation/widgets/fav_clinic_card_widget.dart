import 'package:doctor_ack/core/utils/media_query_values.dart';
import '../../../../core/widgets/cached_image/cached_network_image.dart';
import 'package:doctor_ack/modules/clinic/presentaion/controllers/clinic_cubit/clinic_cubit.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/packages_imprts.dart';

import '../../../../core/api/end_points.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/constants_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/routes_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../../core/widgets/component.dart';
import '../../../../../core/widgets/svg_pic/svg_pic.dart';
import '../../../../../core/widgets/text_custom/text_custom.dart';
import '../../../../languages/locale_keys.g.dart';
import '../controllers/add_remove_favourite_cubit/add_remove_favourite_state.dart';
import '../controllers/add_remove_favourite_cubit/add_removefavourites_cubit.dart';
import '../controllers/favourites_cubit/favourites_cubit.dart';

class FavClinicCardWidget extends StatelessWidget {
  final int index;
  final int id;
  final int? length;
  final String? imageUrl;
  final String? name;
  final String? description;
  final String? city;
  final String? rate;
  final bool? network;

  const FavClinicCardWidget({
    required this.index,
    this.id = 0,
    this.length = 8,
    this.network = false,
    this.imageUrl = ImageNetwork.profile1Image,
    this.name = 'Maris Clinic',
    this.city = 'USA',
    this.rate = '4.5',
    this.description =
        'This clinic improve skin\'s health and This clinic improve skin\'s health and',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: AppPadding.p8, horizontal: AppPadding.p10),
      // margin: EdgeInsets.only(right: AppPadding.p20),
      // height: (AppSize.s100 * 1.73).h,
      width: context.tablet ? (AppSize.s100 * 1.61).w : context.width / 2.4,
      decoration: BoxDecoration(
        color: index % 2 == 0 ? ColorManager.primary : ColorManager.secondary,
        borderRadius: BorderRadius.circular(AppSize.s20.r),
      ),
      child: InkWell(
        onTap: () {
          ClinicCubit.get(context).clinicID = id;
          navigator(context, Routes.clinicRoute);
        },
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                network!
                    ? CachedNetworkImageCustom(
                        url: imageUrl!,
                        boarder: AppSize.s30.r,
                        height: AppSize.s60.h,
                        width: AppSize.s60.h,
                        boxFit: BoxFit.fill)
                    : CachedNetworkImageCustom(
                        boarder: AppSize.s30.r,
                        height: AppSize.s60.h,
                        width: AppSize.s60.h,
                        url: imageUrl!,
                        boxFit: BoxFit.fill),
                SizedBox(
                  height: AppSize.s6.h,
                ),
                TextCustom(
                  text: name!,
                  fontSize: FontSize.s16,
                  color: ColorManager.white,
                ),
                SizedBox(
                  height: AppSize.s6.h,
                ),
                SizedBox(
                  width: (AppSize.s100 * 1.4).w,
                  height: AppSize.s40.h,
                  child: TextCustom(
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    text: description!,
                    textStyle: TextStyle(
                      fontFamily: 'Gilroy',
                      fontSize: FontSize.s12,
                      color: ColorManager.white,
                      fontWeight: FontWeightManager.light,
                    ),
                  ),
                ),
                SizedBox(
                  height: AppSize.s6.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const SvgPictureCustom(
                          assetsName: IconAssets.locationIcon,
                          color: ColorManager.white,
                        ),
                        SizedBox(
                          width: AppSize.s4.w,
                        ),
                        TextCustom(
                          text: city!,
                          textStyle: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: FontSize.s12,
                            color: ColorManager.white,
                            fontWeight: FontWeightManager.semiBold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const SvgPictureCustom(
                          assetsName: IconAssets.star2,
                          color: null,
                        ),
                        SizedBox(
                          width: AppSize.s4.w,
                        ),
                        TextCustom(
                          text: rate!,
                          textStyle: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: FontSize.s12,
                            color: ColorManager.white,
                            fontWeight: FontWeightManager.semiBold,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            Positioned(
              top: AppSize.s10,
              right: AppSize.s0,
              child: BlocConsumer<AddRemoveFavouritesCubit,
                  AddRemoveFavouritesState>(
                listener: (context, state) {
                  if (state is AddRemoveFavouriteSuccessState) {
                    FavouritesCubit.get(context).getFavourite();
                    showToast(context,
                        message: LocaleKeys.toastRemoveFavourite.tr(),
                        type: MessageType.success);
                  } else if (state is AddRemoveFavouriteErrorState) {
                    showToast(context,
                        message: state.message, type: MessageType.error);
                  }
                },
                builder: (context, state) {
                  var removeFavCubit = AddRemoveFavouritesCubit.get(context);
                  return InkWell(
                    onTap: () {
                      removeFavCubit.id = id;
                      removeFavCubit.isClinic = true;
                      removeFavCubit.endpoint =
                          EndPoints.removeFavouriteEndpoint;
                      removeFavCubit.addRemoveFavourite();
                    },
                    child: Container(
                      width: AppSize.s24,
                      height: AppSize.s24,
                      padding: EdgeInsets.all(AppPadding.p4),
                      decoration: const ShapeDecoration(
                        color: Color(0xFF4A464A),
                        shape: OvalBorder(),
                      ),
                      child: const SvgPictureCustom(
                        assetsName: IconAssets.favorite,
                        color: ColorManager.red,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
