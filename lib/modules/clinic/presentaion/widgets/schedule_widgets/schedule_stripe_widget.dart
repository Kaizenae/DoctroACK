// ignore_for_file: use_build_context_synchronously

import 'package:doctor_ack/core/utils/constants_manager.dart';
import 'package:doctor_ack/core/utils/font_manager.dart';
import 'package:doctor_ack/languages/locale_keys.g.dart';
import 'package:doctor_ack/modules/clinic/presentaion/controllers/create_reservation_order_cubit/create_reservation_order_state.dart';
import 'package:doctor_ack/modules/clinic/presentaion/controllers/payment_cubit/payment_cubit.dart';
import 'package:doctor_ack/modules/user/presentation/controllers/users_cubit/users_cubit.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/routes_manager.dart';
import '../../../../../core/utils/styles_manager.dart';
import '../../../../../core/utils/values_manager.dart';
import '../../../../../core/widgets/component.dart';
import '../../../../../core/widgets/elevated_button/elevated_button_custom.dart';
import '../../../../service/presentation/controller/service_cubit.dart';
import '../../../../service/presentation/controller/service_state.dart';
import '../../controllers/create_reservation_order_cubit/create_reservation_order_cubit.dart';
import '../../../../../core/utils/packages_imprts.dart';

class StripeWidget extends StatelessWidget {
  const StripeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateReservationOrderCubit,
        CreateReservationOrderState>(
      listener: (context, createState) {
        if (createState is CreateReservationOrderSuccessState) {
          navigatorAndRemove(context, Routes.paymentSuccessRoute);
          showToast(context,
              message: LocaleKeys.toastReservation.tr(),
              type: MessageType.success);
        } else if (createState is CreateReservationOrderErrorState) {
          showToast(context,
              message: createState.message, type: MessageType.error);
        } else if (createState is CreateReservationOrderLoadingState) {
          dialogProgressCustom(context: context);
        }
      },
      child: BlocBuilder<PaymentCubit, PaymentState>(
        builder: (context, paymentState) {
          return BlocBuilder<ServiceCubit, ServiceState>(
            builder: (context, state) {
              var serviceCubit = ServiceCubit.get(context);
              return paymentState is PaymentIntentLoadingState
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ElevatedButtonCustom(
                      radius: AppSize.s50,
                      text: LocaleKeys.payNow,
                      fontWeight: FontWeight.bold,
                      textStyle: getSemiBoldGilroyStyle(
                        color: Colors.white,
                        fontSize: FontSize.s18,
                      ),
                      onPressed: state is GetServiceSuccessState
                          ? () async {
                              CreateReservationOrderCubit.get(context)
                                      .serviceID =
                                  state.serviceEntity.resultEntity.response.id;
                              CreateReservationOrderCubit.get(context)
                                  .doctorId = serviceCubit.doctorID;
                              UsersCubit.get(context).title = state
                                  .serviceEntity.resultEntity.response.name;
                              UsersCubit.get(context).body =
                                  'New Treatment Appointment at ${CreateReservationOrderCubit.get(context).start}';
                              UsersCubit.get(context).toToken = state
                                  .serviceEntity
                                  .resultEntity
                                  .response
                                  .notification;

                              await PaymentCubit.get(context).makePayment(
                                  context,
                                  PaymentCubit.get(context).calculateAmount(
                                      state.serviceEntity.resultEntity.response
                                          .priceWithDiscount
                                          .round()));
                              Future.delayed(
                                const Duration(milliseconds: 20),
                                () => {
                                  CreateReservationOrderCubit.get(context)
                                          .transId =
                                      PaymentCubit.get(context).paymentId
                                },
                              );
                              // navigator(context, Routes.paymentMethodsRoute);
                            }
                          : null,
                    );
            },
          );
        },
      ),
    );
  }
}
