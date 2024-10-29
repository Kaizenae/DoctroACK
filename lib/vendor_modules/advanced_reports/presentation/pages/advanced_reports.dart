import 'package:doctor_ack/core/utils/color_manager.dart';
import 'package:doctor_ack/core/utils/media_query_values.dart';
import 'package:doctor_ack/core/utils/styles_manager.dart';
import 'package:doctor_ack/core/utils/values_manager.dart';
import 'package:doctor_ack/core/widgets/app_bar/app_bar_custom.dart';
import 'package:doctor_ack/core/widgets/error_widget.dart';
import 'package:doctor_ack/core/widgets/lock_role.dart';
import 'package:doctor_ack/core/widgets/scaffold_custom/scaffold_custom.dart';
import 'package:doctor_ack/core/widgets/shimmer_custom/shimmer_custom.dart';
import 'package:doctor_ack/core/widgets/shimmer_custom/shimmer_horizontal.dart';
import 'package:doctor_ack/languages/locale_keys.g.dart';
import 'package:doctor_ack/modules/all_services/domain/entities/all_services_entity.dart';
import 'package:doctor_ack/modules/all_services/presentation/controllers/all_clinics_cubit/all_services_cubit.dart';
import 'package:doctor_ack/vendor_modules/advanced_reports/presentation/manager/advanced_customers_cubit/advanced_customers_cubit.dart';
import 'package:doctor_ack/vendor_modules/advanced_reports/presentation/manager/advanced_sales_cubit/advanced_sales_cubit.dart';
import 'package:doctor_ack/vendor_modules/advanced_reports/presentation/manager/top_services_cubit/top_services_cubit.dart';
import 'package:doctor_ack/vendor_modules/advanced_reports/presentation/manager/top_services_cubit/top_services_state.dart';
import 'package:doctor_ack/vendor_modules/advanced_reports/presentation/widgets/customer_report_widget.dart';
import 'package:doctor_ack/vendor_modules/advanced_reports/presentation/widgets/sales_report_widget.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/packages_imprts.dart';

import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/constants_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/widgets/component.dart';
import '../../../../core/widgets/elevated_button/elevated_button_custom.dart';
import '../../../../core/widgets/icon_button/icon_button.dart';
import '../../../../core/widgets/select_widget_custom/select_widget_custom.dart';
import '../../../../core/widgets/svg_pic/svg_pic.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../../../../modules/my_appointment/presentation/widgets/summary_widget.dart';
import '../manager/filters_sorts_cubit/filters_sorts_cubit.dart';
import '../manager/filters_sorts_cubit/filters_sorts_state.dart';

class AdvancedReports extends StatelessWidget {
  const AdvancedReports({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      appBarCustom: AppBarCustom(
        text: LocaleKeys.advancedReports,
        isNull: false,
        actions: [
          IconButtonCustom(
              iconName: IconAssets.filter,
              onPressed: () {
                bottomSheet(context);
              },
              btnColor: ColorManager.white,
              color: null),
        ],
      ),
      body: AppConstants.role == 'admin' || AppConstants.type == 'clinic'
          ? Padding(
              padding: EdgeInsets.all(AppPadding.p10),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SaleReportWidget(),
                    const SizedBox(
                      height: AppSize.s14,
                    ),
                    const CustomerReportWidget(),
                    const RSizedBox.vertical(AppSize.s20),
                    BlocProvider.value(
                      value: BlocProvider.of<TopServicesCubit>(context)
                        ..getTopServicesFun(),
                      child: BlocBuilder<TopServicesCubit, TopServicesState>(
                        builder: (context, state) {
                          var topServicesCubit = TopServicesCubit.get(context);
                          return switch (state) {
                            GetTopServicesSuccessState() => Container(
                                // width: (AppSize.s100*3.43).w,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFF0FBFB),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(AppSize.s10),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: AppPadding.p18,
                                            vertical: AppPadding.p16),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextCustom(
                                              text: LocaleKeys.topRatedService,
                                              maxLines: 2,
                                              overflow: TextOverflow.clip,
                                              textStyle: getSemiBoldGilroyStyle(
                                                color: ColorManager.black,
                                                fontSize: FontSize.s18,
                                                height: 0,
                                              ),
                                            ),
                                            const RSizedBox.vertical(
                                                AppSize.s14),
                                            SizedBox(
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemCount: state
                                                    .topServicesEntity
                                                    .resultEntity
                                                    .response
                                                    .length,
                                                itemBuilder: (context, index) =>
                                                    SummaryWidget(
                                                        description: state
                                                            .topServicesEntity
                                                            .resultEntity
                                                            .response[index]
                                                            .name,
                                                        color: ColorManager
                                                            .divider,
                                                        height: AppSize.s6),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            GetTopServicesErrorState() => ErrorsWidget(
                                onPress: () =>
                                    topServicesCubit.getTopServicesFun(),
                              ),
                            GetTopServicesLoadingState() => ShimmerCustom(
                                  child: Container(
                                width: 343,
                                height: 198,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFF0FBFB),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(AppSize.s10),
                                  ),
                                ),
                              )),
                            _ => ShimmerCustom(
                                  child: Container(
                                width: 343,
                                height: 198,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFF0FBFB),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(AppSize.s10),
                                  ),
                                ),
                              )),
                          };
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          : const LockRoleWidget(
              back: false,
            ),
    );
  }

  bottomSheet(BuildContext context) {
    return bottomSheetCustom(
      height: 552,
      context: context,
      body: Material(
        borderRadius: BorderRadius.circular(AppSize.s30.r),
        child: BlocConsumer<FiltersSortsCubit, FiltersSortsState>(
          listener: (context, state) {},
          builder: (context, state) {
            var filterCubit = FiltersSortsCubit.get(context);
            return SizedBox(
              width: context.width,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPadding.p10),
                child: Column(
                  children: [
                    const RSizedBox.vertical(AppSize.s16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: TextCustom(
                              text: LocaleKeys.clear,
                              textStyle: getMediumGilroyStyle(
                                  color: ColorManager.black,
                                  fontSize: FontSize.s14),
                            )),
                        SizedBox(
                          height: AppSize.s30,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: TextCustom(
                              text: LocaleKeys.filter,
                              fontSize: FontSize.s18,
                              fontWeight: FontWeightManager.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Container(
                            // margin: EdgeInsets.only(top: AppPadding.p16,right: AppPadding.p16),
                            padding: EdgeInsets.all(AppPadding.p8),
                            width: AppSize.s30.h,
                            height: AppSize.s30.h,
                            decoration: const ShapeDecoration(
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
                      value: BlocProvider.of<AllServicesCubit>(context)
                        ..getAllServices(),
                      child: BlocBuilder<AllServicesCubit, AllServicesState>(
                        builder: (context, servicesState) {
                          servicesState is GetAllServicesSuccessState
                              ? servicesState
                                  .allClinicsEntity.resultEntity.response
                                  .add(const ResponseEntity(
                                      id: 0,
                                      name: LocaleKeys.all,
                                      clinicServiceEntity:
                                          ClinicServiceEntity(id: 0, name: ''),
                                      image: '',
                                      city: '',
                                      rate: 0.0,
                                      price: 0.0,
                                      description: ''))
                              : null;
                          return switch (servicesState) {
                            GetAllServicesSuccessState() => ListView.builder(
                                reverse: true,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return SelectWidgetCustom<int>(
                                    radius: AppSize.s20.r,
                                    selectedColor: ColorManager.secondary1,
                                    disabledColor: ColorManager.white1,
                                    index: index,
                                    value: servicesState.allClinicsEntity
                                        .resultEntity.response[index].id,
                                    groupValue: filterCubit.filterServiceValue,
                                    onChanged: (value) =>
                                        filterCubit.selectFilterService(value!),
                                    name: servicesState.allClinicsEntity
                                        .resultEntity.response[index].name,
                                  );
                                },
                                itemCount: servicesState.allClinicsEntity
                                    .resultEntity.response.length,
                              ),
                            GetAllServicesErrorState() => const ErrorsWidget(),
                            GetAllServicesLoadingState() =>
                              const ShimmerVertical(),
                            _ => const ShimmerVertical(),
                          };
                        },
                      ),
                    ),
                    const RSizedBox.vertical(AppSize.s30),
                    ElevatedButtonCustom(
                      onPressed: () {
                        AdvancedSalesCubit.get(context).serviceId =
                            filterCubit.filterServiceValue;
                        AdvancedCustomersCubit.get(context).serviceId =
                            filterCubit.filterServiceValue;
                        AdvancedSalesCubit.get(context).getAdvancedSalesFun();
                        AdvancedCustomersCubit.get(context)
                            .getAdvancedCustomersFun();
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
    );
  }
}
