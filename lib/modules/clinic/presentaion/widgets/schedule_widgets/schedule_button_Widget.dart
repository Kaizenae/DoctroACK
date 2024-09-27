// ignore_for_file: file_names

import 'package:doctor_ack/core/utils/constants_manager.dart';
import 'package:doctor_ack/core/utils/font_manager.dart';
import 'package:doctor_ack/core/widgets/shimmer_custom/shimmer_custom.dart';
import 'package:doctor_ack/core/widgets/text_custom/text_custom.dart';
import 'package:doctor_ack/languages/locale_keys.g.dart';
import 'package:doctor_ack/modules/clinic/presentaion/controllers/check_payment_cubit/check_payment_cubit.dart';
import 'package:doctor_ack/modules/clinic/presentaion/controllers/create_reservation_order_cubit/create_reservation_order_state.dart';
import 'package:doctor_ack/modules/clinic/presentaion/widgets/schedule_widgets/schedule_stripe_widget.dart';
import 'package:doctor_ack/modules/user/presentation/controllers/users_cubit/users_cubit.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/assets_manager.dart';
import '../../../../../core/utils/color_manager.dart';
import '../../../../../core/utils/routes_manager.dart';
import '../../../../../core/utils/styles_manager.dart';
import '../../../../../core/utils/values_manager.dart';
import '../../../../../core/widgets/component.dart';
import '../../../../../core/widgets/elevated_button/elevated_button_custom.dart';
import '../../../../../core/widgets/svg_pic/svg_pic.dart';
import '../../../../service/presentation/controller/service_cubit.dart';
import '../../controllers/create_reservation_order_cubit/create_reservation_order_cubit.dart';
import '../../../../../core/utils/packages_imprts.dart';

class ScheduleButtonWidget extends StatelessWidget {
  const ScheduleButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<CheckPaymentCubit>(context)..checkPaymentStatus(),
      child: BlocBuilder<CheckPaymentCubit, CheckPaymentState>(
        builder: (context, state) {
          return switch (state) {
            CheckPaymentSuccessState() => ElevatedButtonCustom(
                radius: AppSize.s50,
                text: state.checkPaymentEntity.resultEntity.paymentStatus
                    ? LocaleKeys.paymentMethod
                    : LocaleKeys.tryLater,
                fontWeight: FontWeight.bold,
                colors: state.checkPaymentEntity.resultEntity.paymentStatus
                    ? ColorManager.primary
                    : ColorManager.lightGrey,
                borderColor: state.checkPaymentEntity.resultEntity.paymentStatus
                    ? ColorManager.primary
                    : ColorManager.lightGrey,
                textStyle: getSemiBoldGilroyStyle(
                  color: state.checkPaymentEntity.resultEntity.paymentStatus
                      ? Colors.white
                      : ColorManager.primary,
                  fontSize: FontSize.s18,
                ),
                onPressed: state.checkPaymentEntity.resultEntity.paymentStatus
                    ? () {
                        if (CreateReservationOrderCubit.get(context)
                            .start
                            .isNotEmpty) {
                          bottomSheetCustom(
                              context: context,
                              body: Material(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: AppPadding.p10),
                                  child: SizedBox(
                                    height: AppSize.s100 * 3.5,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              height: AppSize.s30,
                                              child: Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: TextCustom(
                                                  text:
                                                      LocaleKeys.paymentMethod,
                                                  fontSize: FontSize.s18,
                                                  fontWeight:
                                                      FontWeightManager.bold,
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              icon: Container(
                                                // margin: EdgeInsets.only(top: AppPadding.p16,right: AppPadding.p16),
                                                padding: EdgeInsets.all(
                                                    AppPadding.p8),
                                                width: AppSize.s30.h,
                                                height: AppSize.s30.h,
                                                decoration:
                                                    const ShapeDecoration(
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
                                        const Spacer(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextCustom(
                                              text: LocaleKeys.youWillChargedBy,
                                              textAlign: TextAlign.start,
                                              textStyle: getRegularGilroyStyle(
                                                color: ColorManager.primary,
                                                fontSize: FontSize.s18,

                                                // height: 0.05,
                                              ),
                                            ),
                                            TextCustom(
                                              text:
                                                  '${CreateReservationOrderCubit.get(context).price} ${LocaleKeys.aED.tr()}',
                                              textAlign: TextAlign.start,
                                              textStyle: getSemiBoldGilroyStyle(
                                                color: ColorManager.primary,
                                                fontSize: FontSize.s16,

                                                // height: 0.05,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: AppSize.s30.sp,
                                        ),
                                        const WalletWidget(),
                                        const RSizedBox.vertical(AppSize.s20),
                                        const StripeWidget(),
                                        const RSizedBox.vertical(AppSize.s40),
                                      ],
                                    ),
                                  ),
                                ),
                              ));
                        } else {
                          showToast(context,
                              message: LocaleKeys.toastSelectTime.tr(),
                              type: MessageType.warning);
                        }
                      }
                    : () => (),
              ),
            CheckPaymentErrorState() => ElevatedButtonCustom(
                radius: AppSize.s50,
                text: LocaleKeys.tryLater,
                colors: ColorManager.lightGrey,
                borderColor: ColorManager.lightGrey,
                fontWeight: FontWeight.bold,
                textStyle: getSemiBoldGilroyStyle(
                  color: Colors.black,
                  fontSize: FontSize.s18,
                ),
              ),
            CheckPaymentLoadingState() => ShimmerCustom(
                  child: ElevatedButtonCustom(
                radius: AppSize.s50,
                text: LocaleKeys.tryLater,
                colors: ColorManager.lightGrey,
                borderColor: ColorManager.lightGrey,
                fontWeight: FontWeight.bold,
                textStyle: getSemiBoldGilroyStyle(
                  color: Colors.black,
                  fontSize: FontSize.s18,
                ),
              )),
            _ => const SizedBox()
          };
        },
      ),
    );
  }
}

class WalletWidget extends StatelessWidget {
  const WalletWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateReservationOrderCubit,
        CreateReservationOrderState>(
      listener: (context, createState) {
        if (createState is CreateAppointmentWalletSuccessState) {
          UsersCubit.get(context).title = ServiceCubit.get(context).serviceName;
          UsersCubit.get(context).body =
              'New Treatment Appointment at ${CreateReservationOrderCubit.get(context).start}';
          UsersCubit.get(context).sendNotification();
          navigatorAndRemove(context, Routes.paymentSuccessRoute);
        } else if (createState is CreateAppointmentWalletErrorState) {
          showToast(context,
              message: createState.message, type: MessageType.error);
        }
      },
      builder: (context, createState) {
        var createCubit = CreateReservationOrderCubit.get(context);
        return createState is CreateAppointmentWalletLoadingState
            ? const Center(child: CircularProgressIndicator())
            : ElevatedButtonCustom(
                radius: AppSize.s50,
                text: LocaleKeys.wallet,
                fontWeight: FontWeight.bold,
                colors: ColorManager.white,
                textStyle: getSemiBoldGilroyStyle(
                  color: Colors.black,
                  fontSize: FontSize.s18,
                ),
                onPressed: () async {
                  createCubit.serviceID = ServiceCubit.get(context).serviceID;
                  createCubit.doctorId = ServiceCubit.get(context).doctorID;
                  await createCubit.createAppointmentWallet();
                },
              );
      },
    );
  }
}
