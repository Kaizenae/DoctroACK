import 'package:doctor_ack/core/utils/color_manager.dart';
import 'package:doctor_ack/core/utils/font_manager.dart';
import 'package:doctor_ack/core/utils/styles_manager.dart';
import 'package:doctor_ack/core/utils/values_manager.dart';
import 'package:doctor_ack/core/widgets/app_bar/app_bar_custom.dart';
import 'package:doctor_ack/core/widgets/scaffold_custom/scaffold_custom.dart';
import 'package:doctor_ack/core/widgets/text_custom/text_custom.dart';
import 'package:doctor_ack/languages/locale_keys.g.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/packages_imprts.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
        appBarCustom: const AppBarCustom(
          text: LocaleKeys.privacyPolicy,
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppPadding.p16, vertical: AppPadding.p24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextCustom(
                  text: 'App Usage',
                  textStyle: getSemiBoldGilroyStyle(
                    color: ColorManager.black1,
                    fontSize: FontSize.s18,
                  ),
                ),
                const RSizedBox.vertical(AppSize.s10),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Eligibility: ',
                        style: getSemiBoldGilroyStyle(
                          color: ColorManager.greyL,
                          fontSize: FontSize.s14,
                        ),
                      ),
                      TextSpan(
                        text:
                            'You must be at least [Age] years old to use this App. By using the App, you represent and warrant that you meet the age requirement.',
                        style: getRegularGilroyStyle(
                          color: ColorManager.greyL,
                          fontSize: FontSize.s14,
                        ),
                      ),
                    ],
                  ),
                ),
                const RSizedBox.vertical(AppSize.s6),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Account: ',
                        style: getSemiBoldGilroyStyle(
                          color: ColorManager.greyL,
                          fontSize: FontSize.s14,
                        ),
                      ),
                      TextSpan(
                        text:
                            'Some features of the App may require you to create an account. You are responsible for maintaining the confidentiality of your account information and for all activities that occur under your account. You agree to notify us immediately of any unauthorized use of your account',
                        style: getRegularGilroyStyle(
                          color: ColorManager.greyL,
                          fontSize: FontSize.s14,
                        ),
                      ),
                    ],
                  ),
                ),
                const RSizedBox.vertical(AppSize.s16),
                TextCustom(
                  text: 'Services Provided',
                  textStyle: getSemiBoldGilroyStyle(
                    color: ColorManager.black1,
                    fontSize: FontSize.s18,
                  ),
                ),
                const RSizedBox.vertical(AppSize.s10),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Appointment Booking: ',
                        style: getSemiBoldGilroyStyle(
                          color: ColorManager.greyL,
                          fontSize: FontSize.s14,
                        ),
                      ),
                      TextSpan(
                        text:
                            'The App provides a platform for users to book appointments for skincare services offered by [Clinic Name]. All appointments are subject to availability.',
                        style: getRegularGilroyStyle(
                          color: ColorManager.greyL,
                          fontSize: FontSize.s14,
                        ),
                      ),
                    ],
                  ),
                ),
                const RSizedBox.vertical(AppSize.s6),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Health Information: ',
                        style: getSemiBoldGilroyStyle(
                          color: ColorManager.greyL,
                          fontSize: FontSize.s14,
                        ),
                      ),
                      TextSpan(
                        text:
                            'Any health-related information provided through the App is for informational purposes only and does not constitute medical advice. You should consult a qualified healthcare professional for any medical concerns.',
                        style: getRegularGilroyStyle(
                          color: ColorManager.greyL,
                          fontSize: FontSize.s14,
                        ),
                      ),
                    ],
                  ),
                ),
                const RSizedBox.vertical(AppSize.s16),
                TextCustom(
                  text: 'Payments',
                  textStyle: getSemiBoldGilroyStyle(
                    color: ColorManager.black1,
                    fontSize: FontSize.s18,
                  ),
                ),
                const RSizedBox.vertical(AppSize.s10),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Payment Information: ',
                        style: getSemiBoldGilroyStyle(
                          color: ColorManager.greyL,
                          fontSize: FontSize.s14,
                        ),
                      ),
                      TextSpan(
                        text:
                            'When making payments through the App, you agree to provide accurate and complete payment information. You authorize us to charge your payment method for any services you purchase.',
                        style: getRegularGilroyStyle(
                          color: ColorManager.greyL,
                          fontSize: FontSize.s14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
