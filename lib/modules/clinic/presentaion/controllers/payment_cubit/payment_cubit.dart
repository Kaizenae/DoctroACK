// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/utils/packages_imprts.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../../core/utils/constants_manager.dart';
import '../../../../../core/widgets/component.dart';
import '../../../../user/presentation/controllers/users_cubit/users_cubit.dart';
import '../create_reservation_order_cubit/create_reservation_order_cubit.dart';
part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());

  static PaymentCubit get(context) => BlocProvider.of(context);
  Map<String, dynamic>? paymentIntent;
  String paymentId = '';

  createPaymentIntent(String amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        "automatic_payment_methods[enabled]": "true",
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<void> makePayment(BuildContext context, String price) async {
    emit(PaymentIntentLoadingState());
    try {
      //STEP 1: Create Payment Intent
      paymentIntent = await createPaymentIntent(price, 'AED');
      paymentId = paymentIntent!["id"].toString();

      emit(PaymentIntentSuccessState());

      //STEP 2: Initialize Payment Sheet

      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  applePay: Platform.isIOS
                      ? const PaymentSheetApplePay(
                          merchantCountryCode: 'AE',
                          buttonType: PlatformButtonType.buy,
                        )
                      : null,
                  googlePay: PaymentSheetGooglePay(
                      merchantCountryCode: 'AE',
                      amount: price.toString(),
                      currencyCode: 'AED',
                      testEnv: true),
                  customFlow: false,
                  // billingDetails: const BillingDetails(
                  //     name: 'Ahmed Emad',
                  //     address: Address(
                  //         city: 'cairo',
                  //         country: 'Egypt',
                  //         line1: 'line1',
                  //         line2: 'line2',
                  //         postalCode: 'postalCode',
                  //         state: 'state'),
                  //     email: 'e.emad@kaizenae.com',
                  //     phone: '+201027702805'),
                  paymentIntentClientSecret: paymentIntent!['client_secret'],

                  //Gotten from payment intent

                  merchantDisplayName: 'DoctorAck'))
          .then((value) async {
        await displayPaymentSheet(context);
      }).catchError((onError) {
        showToast(context,
            message: onError.toString(), type: MessageType.error);
        emit(PaymentIntentErrorState());
      });
    } catch (err) {
      emit(PaymentIntentErrorState());

      throw Exception(err.toString());
    }
  }

  displayPaymentSheet(BuildContext context) async {
    try {
      await Stripe.instance
          .presentPaymentSheet(
              // options: const PaymentSheetPresentOptions(timeout: 1200000)
              )
          .then((value) async {
        // await Stripe.instance.confirmPaymentSheetPayment().then((value) {
        //   paymentIntent = null;
        //   // value!.copyWith();
        //
        //
        // });

        Future.delayed(
          const Duration(milliseconds: 10),
          () {
            CreateReservationOrderCubit.get(context).transId = paymentId;

            CreateReservationOrderCubit.get(context)
                .createReservationOrder(transID: paymentId);
            UsersCubit.get(context).sendNotification();
          },
        );
      }).onError((error, stackTrace) {
        AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
                  Text(error.toString()),
                ],
              ),
            ],
          ),
        );

        throw Exception(error);
      });
    } on StripeException {
      const AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                Text("Payment Failed"),
              ],
            ),
          ],
        ),
      );
    }
  }

  calculateAmount(int amount) {
    final int calculatedAmount = (amount) * 100;
    return calculatedAmount.toString();
  }
}
