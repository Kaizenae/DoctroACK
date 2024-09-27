import 'package:doctor_ack/core/utils/color_manager.dart';
import 'package:doctor_ack/core/utils/media_query_values.dart';
import 'package:doctor_ack/core/widgets/app_widgets/service_card_widget.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/packages_imprts.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../../core/widgets/shimmer_custom/shimmer_custom.dart';
import '../controllers/all_clinics_cubit/all_services_cubit.dart';

class AllServicesWidget extends StatelessWidget {
  const AllServicesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    AllServicesCubit.get(context).clinicId = 0;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
      child: BlocProvider.value(
        value: BlocProvider.of<AllServicesCubit>(context)..getAllServices(),
        child: BlocBuilder<AllServicesCubit, AllServicesState>(
          builder: (context, state) {
            var allServicesCubit = AllServicesCubit.get(context);
            return switch (state) {
              GetAllServicesSuccessState() => GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 0.7,
                      // childAspectRatio: .8,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  itemBuilder: (context, index) => FadeIn(
                    // duration: const Duration(milliseconds: 250),

                    child: ServiceCardWidget(
                        id: state
                            .allClinicsEntity.resultEntity.response[index].id,
                        length:
                            state.allClinicsEntity.resultEntity.response.length,
                        network: true,
                        rate: state
                            .allClinicsEntity.resultEntity.response[index].rate
                            .toStringAsFixed(1),
                        name: state
                            .allClinicsEntity.resultEntity.response[index].name,
                        city: state
                            .allClinicsEntity.resultEntity.response[index].city,
                        clinicName: state.allClinicsEntity.resultEntity
                            .response[index].clinicServiceEntity.name,
                        imageUrl: state.allClinicsEntity.resultEntity
                            .response[index].image,
                        index: index,
                        key: const Key('AllServices')),
                  ),
                  itemCount:
                      state.allClinicsEntity.resultEntity.response.length,
                ),
              GetAllServicesErrorState() => ErrorsWidget(
                  onPress: () => allServicesCubit.getAllServices(),
                  text: state.message),
              GetAllServicesLoadingState() => ShimmerCustom(
                    child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.center,
                  runSpacing: AppSize.s16,
                  spacing: AppSize.s20,
                  children: List.generate(
                      8,
                      (index) => Container(
                            padding: EdgeInsets.symmetric(
                                vertical: AppPadding.p8,
                                horizontal: AppPadding.p10),
                            // margin: EdgeInsets.only(right: AppPadding.p20),
                            height: (AppSize.s100 * 1.73).h,
                            width: context.tablet
                                ? (AppSize.s100 * 1.61).w
                                : context.width / 2.4,
                            decoration: BoxDecoration(
                              color: ColorManager.lightGrey,
                              borderRadius:
                                  BorderRadius.circular(AppSize.s20.r),
                            ),
                          )),
                )),
              _ => ShimmerCustom(
                    child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.center,
                  runSpacing: AppSize.s16,
                  spacing: AppSize.s20,
                  children: List.generate(
                      8,
                      (index) => Container(
                            padding: EdgeInsets.symmetric(
                                vertical: AppPadding.p8,
                                horizontal: AppPadding.p10),
                            // margin: EdgeInsets.only(right: AppPadding.p20),
                            height: (AppSize.s100 * 1.73).h,
                            width: (AppSize.s100 * 1.61).w,
                            decoration: BoxDecoration(
                              color: ColorManager.lightGrey,
                              borderRadius:
                                  BorderRadius.circular(AppSize.s20.r),
                            ),
                          )),
                )),
            };
          },
        ),
      ),
    );
  }
}
