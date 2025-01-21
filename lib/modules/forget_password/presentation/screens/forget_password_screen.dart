import 'package:doctor_ack/core/utils/constants_manager.dart';
import 'package:doctor_ack/languages/locale_keys.g.dart';
import 'package:doctor_ack/modules/forget_password/presentation/controller/forget_password_cubit.dart';
import 'package:doctor_ack/modules/forget_password/presentation/controller/forget_password_state.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/packages_imprts.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/styles_manager.dart';
import '../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/routes_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/component.dart';
import '../../../../core/widgets/elevated_button/elevated_button_custom.dart';
import '../../../../core/widgets/svg_pic/svg_pic.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../../../../core/widgets/text_form_field/text_form_field_custom.dart';
import 'verification_code_screen.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      // appBarCustom: const AppBarCustom(
      //   screenName: Routes.loginRoute,
      //   // text: LocaleKeys.forgetPassword,
      // ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppPadding.p16, vertical: AppPadding.p12),
          child: BlocProvider.value(
            value: BlocProvider.of<ForgetPasswordCubit>(context),
            child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
              listener: (context, state) {
                var cubit = ForgetPasswordCubit.get(context);

                if (state is SendOTPSuccessState) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VerificationCodeScreen(
                          isRegister: false,
                          email: cubit.emailController.text,
                        ),
                      ));
                  showToast(context,
                      message: LocaleKeys.toastOTPSent.tr(),
                      type: MessageType.success);
                } else if (state is SendOTPErrorState) {
                  showToast(context,
                      message: state.message, type: MessageType.error);
                }
              },
              builder: (context, state) {
                var cubit = ForgetPasswordCubit.get(context);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Image.asset(
                        ImageAssets.logo1,
                        height: AppSize.s70.h,
                        width: AppSize.s100.w * 1.65,
                      ),
                    ),
                    const RSizedBox.vertical(AppSize.s10),
                    Center(
                        child: SvgPictureCustom(
                            assetsName: IconAssets.resetPasswordSvg,
                            color: null,
                            height: AppSize.s100.h * 1.7,
                            width: AppSize.s100.w * 1.7)),
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
                            text: LocaleKeys.resetPassword,
                            fontSize: FontSize.s22,
                            fontWeight: FontWeightManager.semiBold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: AppSize.s34,
                    ),
                    TextFormFieldCustom(
                      radius: AppSize.s24.r,
                      fillColor: ColorManager.white,
                      hint: LocaleKeys.enterEmail.tr(),
                      controller: cubit.emailController,
                      validate: (value) {
                        if (value!.trim().isEmpty || value == ' ') {
                          return LocaleKeys.emailTextField.tr();
                        }
                        if (!RegExp(
                                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                            .hasMatch(value)) {
                          return LocaleKeys.emailValidTextField.tr();
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: const SvgPictureCustom(
                        assetsName: IconAssets.email,
                        color: ColorManager.black1,
                        height: AppSize.s24,
                      ),
                      prefix: true,
                    ),
                    const RSizedBox.vertical(AppSize.s20),
                    Center(
                      child: SizedBox(
                        width: AppSize.s100.w * 2.9,
                        child: TextCustom(
                          text: LocaleKeys.forgetPasswordHint,
                          textStyle: getMediumGilroyStyle(
                              color: ColorManager.black,
                              fontSize: FontSize.s12),
                          textAlign: TextAlign.center,
                          color: ColorManager.textFormLabelColor,
                        ),
                      ),
                    ),
                    const Spacer(),
                    state is SendOTPLoadingState
                        ? const Center(child: CircularProgressIndicator())
                        : ElevatedButtonCustom(
                            text: LocaleKeys.getCode,
                            fontWeight: FontWeight.bold,
                            onPressed: () {
                              cubit.sendOTPFun();
                            },
                          ),
                    const SizedBox(
                      height: AppSize.s10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextCustom(
                          text: LocaleKeys.rememberPassword,
                          textStyle: getMediumGilroyStyle(
                            color: ColorManager.black,
                            fontSize: FontSize.s12,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            navigator(context, Routes.loginRoute);
                          },
                          child: TextCustom(
                            text: LocaleKeys.backToLogin,
                            textStyle: getSemiBoldGilroyStyle(
                                color: ColorManager.black,
                                fontSize: FontSize.s12),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: AppSize.s20,
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
