import 'package:doctor_ack/core/utils/constants_manager.dart';
import 'package:doctor_ack/core/utils/font_manager.dart';
import 'package:doctor_ack/core/widgets/app_bar/app_bar_custom.dart';
import 'package:doctor_ack/core/widgets/scaffold_custom/scaffold_custom.dart';
import 'package:doctor_ack/core/widgets/text_custom/text_custom.dart';
import 'package:doctor_ack/languages/locale_keys.g.dart';
import 'package:doctor_ack/modules/clinic/presentaion/widgets/schedule_widgets/schedule_button_Widget.dart';
import 'package:doctor_ack/modules/clinic/presentaion/widgets/schedule_widgets/schedule_date_widget.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/color_manager.dart';
// import '../../../../core/utils/dynamic_link.dart';
// import '../../../../core/utils/routes_manager.dart';
import '../../../../core/utils/styles_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/refund_widget.dart';
import '../../../service/presentation/controller/service_cubit.dart';
import '../widgets/schedule_widgets/schedule_time_widget.dart';
import '../widgets/service_data_widget.dart';
import '../../../../core/utils/packages_imprts.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      appBarCustom: AppBarCustom(
        centerTitle: false,
        text: ServiceCubit.get(context).serviceName,
        actions: const [
          // BlocBuilder<ServiceCubit, ServiceState>(
          //   builder: (context, state) {
          //     return InkWell(
          //       // onTap: state is GetServiceSuccessState
          //       //     ? () {
          //       //         DynamicLinksHelper.createLink(
          //       //             '${Routes.serviceClinicRoute}/${state.serviceEntity.resultEntity.response.id.toString()}',
          //       //             state.serviceEntity.resultEntity.response.name,
          //       //             'https://i.ibb.co/JQ8Gp9X/logo-icon.png');
          //       //       }
          //       //     : null,
          //       child: Padding(
          //         padding: EdgeInsets.only(right: AppPadding.p16),
          //         child: SvgPictureCustom(
          //           assetsName: IconAssets.share,
          //           color: null,
          //           height: AppSize.s34.h,
          //           width: AppSize.s34.h,
          //         ),
          //       ),
          //     );
          //   },
          // )
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.p18),
          child: Center(
            child: Column(
              children: [
                // ServiceDataWidget
                const ServiceDataWidget(),

                const RefundWidget(),

                const ScheduleDateWidget(),

                SizedBox(
                  height: AppSize.s20.h,
                ),
                Align(
                  alignment: AppConstants.language
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: TextCustom(
                    text: LocaleKeys.availableTimes,
                    textStyle: getSemiBoldGilroyStyle(
                      color: ColorManager.primary,
                      fontSize: FontSize.s18,
                    ),
                  ),
                ),

                const SizedBox(
                  height: AppSize.s16,
                ),
                const ScheduleTimeWidget(),

                SizedBox(
                  height: AppSize.s20.h,
                ),
                const ScheduleButtonWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
