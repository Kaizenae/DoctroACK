import 'package:doctor_ack/core/utils/media_query_values.dart';
import 'package:doctor_ack/core/widgets/app_widgets/clinic_card_widget.dart';
import 'package:doctor_ack/core/widgets/error_widget.dart';
import 'package:doctor_ack/core/widgets/shimmer_custom/shimmer_custom.dart';
import 'package:doctor_ack/modules/all_clinics/presentation/controllers/all_clinics_cubit/all_clinics_cubit.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/packages_imprts.dart';
import '../../../../core/utils/values_manager.dart';

class AllClinicsWidget extends StatelessWidget {
  const AllClinicsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
      child: BlocProvider.value(
        value: BlocProvider.of<AllClinicsCubit>(context)..getAllClinics(),
        child: BlocBuilder<AllClinicsCubit, AllClinicsState>(
          builder: (context, state) {
            var allClinicCubit = AllClinicsCubit.get(context);
            return switch (state) {
              GetAllClinicsSuccessState() => Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.center,
                  runSpacing: AppSize.s16.w,
                  spacing: AppSize.s20.h,
                  children: List.generate(
                      state.allClinicsEntity.resultEntity.response.length,
                      (index) => FadeIn(
                            // duration: const Duration(milliseconds: 250),

                            child: ClinicCardWidget(
                              key: const Key('AllClinics'),
                              index: index,
                              id: state.allClinicsEntity.resultEntity
                                  .response[index].id,
                              favourite: state.allClinicsEntity.resultEntity
                                  .response[index].favourite,
                              length: state.allClinicsEntity.resultEntity
                                  .response.length,
                              network: true,
                              city: state.allClinicsEntity.resultEntity
                                  .response[index].city,
                              description: state.allClinicsEntity.resultEntity
                                  .response[index].description,
                              imageUrl: state.allClinicsEntity.resultEntity
                                  .response[index].image,
                              name: state.allClinicsEntity.resultEntity
                                  .response[index].name,
                              rate: state.allClinicsEntity.resultEntity
                                  .response[index].rate
                                  .toStringAsFixed(1),
                            ),
                          )),
                ),
              GetAllClinicsErrorState() => ErrorsWidget(
                  onPress: () => allClinicCubit.getAllClinics(),
                  text: state.message),
              GetAllClinicsLoadingState() => ShimmerCustom(
                    child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.center,
                  runSpacing: AppSize.s16,
                  spacing: AppSize.s20,
                  children: List.generate(
                      8,
                      (index) => FadeIn(
                            // duration: const Duration(milliseconds: 250),

                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: AppPadding.p8,
                                  horizontal: AppPadding.p10),
                              // margin: EdgeInsets.only(right: AppPadding.p20),
                              height: (AppSize.s100 * 1.73).h,
                              width: context.tablet
                                  ? (AppSize.s100 * 1.61).w
                                  : context.width / 2.4,
                              decoration: BoxDecoration(
                                color: index % 2 == 0
                                    ? ColorManager.primary
                                    : ColorManager.secondary,
                                borderRadius:
                                    BorderRadius.circular(AppSize.s20.r),
                              ),
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
                      (index) => FadeIn(
                            // duration: const Duration(milliseconds: 250),

                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: AppPadding.p8,
                                  horizontal: AppPadding.p10),
                              // margin: EdgeInsets.only(right: AppPadding.p20),
                              height: (AppSize.s100 * 1.73).h,
                              width: (AppSize.s100 * 1.61).w,
                              decoration: BoxDecoration(
                                color: index % 2 == 0
                                    ? ColorManager.primary
                                    : ColorManager.secondary,
                                borderRadius:
                                    BorderRadius.circular(AppSize.s20.r),
                              ),
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
