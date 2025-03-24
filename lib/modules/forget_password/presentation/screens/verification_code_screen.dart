import 'package:doctor_ack/core/utils/styles_manager.dart';
import 'package:doctor_ack/core/widgets/elevated_button/elevated_button_custom.dart';
import 'package:doctor_ack/languages/locale_keys.g.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/packages_imprts.dart';
import '../../../../core/utils/constants_manager.dart';
import '../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/routes_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/component.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import 'package:pinput/pinput.dart';

import '../controller/forget_password_cubit.dart';
import '../controller/forget_password_state.dart';

class VerificationCodeScreen extends StatelessWidget {
  const VerificationCodeScreen(
      {super.key, required this.isRegister, required this.email});
  final bool isRegister;
  final String email;

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      // appBarCustom: const AppBarCustom(
      //   screenName: Routes.forgetPasswordRoute,
      //   text: LocaleKeys.verificationCode,
      // ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppPadding.p16, vertical: AppPadding.p12),
          child: BlocProvider.value(
            value: BlocProvider.of<ForgetPasswordCubit>(context),
            child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
              listener: (context, state) {
                if (state is VerifyOTPSuccessState) {
                  if (isRegister) {
                    navigatorAndRemove(context, Routes.loginRoute);
                    showToast(context,
                        message: LocaleKeys.toastOTPVerified.tr(),
                        type: MessageType.success);
                  } else {
                    navigator(context, Routes.newPasswordRoute);
                    showToast(context,
                        message: LocaleKeys.toastOTPVerified.tr(),
                        type: MessageType.success);
                  }
                } else if (state is VerifyOTPErrorState) {
                  showToast(context,
                      message: state.message, type: MessageType.error);
                }
              },
              builder: (context, state) {
                var cubit = ForgetPasswordCubit.get(context);
                return Column(
                  children: [
                    Center(
                      child: Image.asset(
                        ImageAssets.logo1,
                        height: AppSize.s70.h,
                        width: AppSize.s100.w * 1.65,
                      ),
                    ),
                    const RSizedBox.vertical(AppSize.s10),
                    Row(
                      children: [
                        const Expanded(
                            child: Divider(
                          thickness: 0.2,
                          height: AppSize.s40,
                          color: ColorManager.red,
                          endIndent: AppSize.s10,
                          indent: 0,
                        )),
                        Expanded(
                          flex: 4,
                          child: TextCustom(
                            text: LocaleKeys.verifyCode,
                            fontSize: FontSize.s22,
                            fontWeight: FontWeightManager.semiBold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: AppSize.s34,
                    ),
                    Pinput(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      defaultPinTheme: PinTheme(
                        width: AppSize.s60,
                        height: AppSize.s70,
                        textStyle: getMediumGilroyStyle(
                            color: ColorManager.blackDark,
                            fontSize: FontSize.s26),
                        decoration: BoxDecoration(
                          color: ColorManager.white1,
                          border: Border.all(
                              width: 1, color: const Color(0x1980797E)),
                          borderRadius: BorderRadius.circular(AppSize.s12.r),
                        ),
                      ),
                      focusedPinTheme: PinTheme(
                        width: AppSize.s60,
                        height: AppSize.s70,
                        textStyle: getMediumGilroyStyle(
                            color: ColorManager.blackDark,
                            fontSize: FontSize.s26),
                        decoration: BoxDecoration(
                          color: ColorManager.white1,
                          border: Border.all(
                              width: 2, color: const Color(0xFFC29E8A)),
                          borderRadius: BorderRadius.circular(AppSize.s12.r),
                        ),
                      ),
                      submittedPinTheme: PinTheme(
                        width: AppSize.s60,
                        height: AppSize.s70,
                        textStyle: getMediumGilroyStyle(
                            color: ColorManager.blackDark,
                            fontSize: FontSize.s26),
                        decoration: BoxDecoration(
                          color: ColorManager.white1,
                          border: Border.all(
                              width: 1, color: const Color(0x1980797E)),
                          borderRadius: BorderRadius.circular(AppSize.s12.r),
                        ),
                      ),
                      validator: (s) {
                        cubit.otpController.text = s ?? '';
                        return null;
                        // return s == '2222' ? null : LocaleKeys.pinIncorrect.tr();
                      },
                      onSubmitted: (s) {
                        cubit.otpController.text = s;

                        // cubit.verifyOTPFun();
                      },
                      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      showCursor: true,
                      // androidSmsAutofillMethod:
                      //     AndroidSmsAutofillMethod.smsUserConsentApi,
                      onCompleted: (pin) {
                        cubit.otpController.text = pin;

                        cubit.verifyOTPFun(email: email);
                      },
                    ),
                    const RSizedBox.vertical(AppSize.s28),
                    Center(
                      child: SizedBox(
                          width: AppSize.s100.w * 2.9,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: '${LocaleKeys.pleaseCheckEmail.tr()} ',
                                  style: getMediumGilroyStyle(
                                      color: ColorManager.grey,
                                      fontSize: FontSize.s12),
                                ),
                                TextSpan(
                                  text: cubit.emailController.text,
                                  style: getSemiBoldGilroyStyle(
                                      color: ColorManager.black,
                                      fontSize: FontSize.s12),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          )),
                    ),
                    const RSizedBox.vertical(AppSize.s34),
                    state is VerifyOTPLoadingState
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ElevatedButtonCustom(
                            onPressed: () {
                              cubit.verifyOTPFun(email: email);
                            },
                            text: LocaleKeys.submit,
                          ),
                    const RSizedBox.vertical(AppSize.s20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextCustom(
                          text: LocaleKeys.resendVerificationCode,
                          textStyle: getMediumGilroyStyle(
                            color: ColorManager.grey,
                            fontSize: FontSize.s12,
                          ),
                        ),
                        state is SendOTPLoadingState
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : InkWell(
                                onTap: () {
                                  cubit.sendOTPFun();
                                },
                                child: TextCustom(
                                  text: LocaleKeys.resendOtp,
                                  textStyle: getSemiBoldGilroyStyle(
                                      color: ColorManager.black,
                                      fontSize: FontSize.s12),
                                ),
                              ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
