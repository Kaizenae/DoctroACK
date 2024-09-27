import 'package:doctor_ack/core/utils/color_manager.dart';
import 'package:doctor_ack/core/utils/font_manager.dart';
import 'package:doctor_ack/core/utils/routes_manager.dart';
import 'package:doctor_ack/core/utils/values_manager.dart';
import 'package:doctor_ack/core/widgets/component.dart';
import 'package:doctor_ack/core/widgets/text_custom/text_custom.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/packages_imprts.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/constants_manager.dart';
import '../../../../core/widgets/app_widgets/service_card_widget.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../../core/widgets/shimmer_custom/shimmer_custom.dart';
import '../../../../core/widgets/svg_pic/svg_pic.dart';
import '../../../all_services/presentation/controllers/all_clinics_cubit/all_services_cubit.dart';

class HomeServices extends StatelessWidget {
  final String title;

  const HomeServices({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    AllServicesCubit.get(context).clinicId = 0;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: Column(
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
                  text: title,
                  fontSize: FontSize.s18,
                  fontWeight: FontWeightManager.bold,
                ),
              ),
              IconButton(
                  onPressed: () {
                    navigator(context, Routes.allServicesScreen);
                  },
                  icon: SvgPictureCustom(
                    assetsName: AppConstants.language
                        ? IconAssets.arrowLeft
                        : IconAssets.arrowRight,
                  ))
            ],
          ),
          SizedBox(
            height: AppSize.s10.h,
          ),
          BlocProvider.value(
            value: BlocProvider.of<AllServicesCubit>(context)..getAllServices(),
            child: BlocBuilder<AllServicesCubit, AllServicesState>(
              builder: (context, state) {
                var allServicesCubit = AllServicesCubit.get(context);
                return switch (state) {
                  GetAllServicesSuccessState() => GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 0.7,
                              // childAspectRatio: .8,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20),
                      itemCount: state.allClinicsEntity.resultEntity.response
                                  .length >
                              4
                          ? 4
                          : state.allClinicsEntity.resultEntity.response.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return ServiceCardWidget(
                            id: state.allClinicsEntity.resultEntity
                                .response[index].id,
                            length: state
                                .allClinicsEntity.resultEntity.response.length,
                            network: true,
                            rate: state.allClinicsEntity.resultEntity
                                .response[index].rate
                                .toStringAsFixed(1),
                            name: state.allClinicsEntity.resultEntity
                                .response[index].name,
                            city: state.allClinicsEntity.resultEntity
                                .response[index].city,
                            clinicName: state.allClinicsEntity.resultEntity
                                .response[index].clinicServiceEntity.name,
                            imageUrl: state.allClinicsEntity.resultEntity
                                .response[index].image,
                            index: index,
                            key: const Key('AllServices'));
                      }),
                  GetAllServicesErrorState() => ErrorsWidget(
                      onPress: () => allServicesCubit.getAllServices(),
                      text: state.message),
                  GetAllServicesLoadingState() => ShimmerCustom(
                      child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  childAspectRatio: 0.7,
                                  // childAspectRatio: .8,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20),
                          itemCount: ImageNetwork.serviceItems.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return ServiceCardWidget(
                                index: index, key: const Key('AllServices'));
                          })),
                  _ => ShimmerCustom(
                      child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  childAspectRatio: 0.7,
                                  // childAspectRatio: .8,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20),
                          itemCount: ImageNetwork.serviceItems.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return ServiceCardWidget(
                                index: index, key: const Key('AllServices'));
                          })),
                };
              },
            ),
          ),
          SizedBox(
            height: AppSize.s10.h,
          ),
        ],
      ),
    );
  }
}
