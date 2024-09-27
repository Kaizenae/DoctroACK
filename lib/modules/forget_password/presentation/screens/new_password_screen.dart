import 'package:doctor_ack/core/utils/styles_manager.dart';
import 'package:doctor_ack/languages/locale_keys.g.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/packages_imprts.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/constants_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/routes_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/component.dart';
import '../../../../core/widgets/elevated_button/elevated_button_custom.dart';
import '../../../../core/widgets/svg_pic/svg_pic.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../../../../core/widgets/text_form_field/text_form_field_custom.dart';

import '../../../login/presentation/controller/login_cubit.dart';
import '../controller/forget_password_cubit.dart';
import '../controller/forget_password_state.dart';

List<String> passwordCheckHint = [
  LocaleKeys.use8Char,
  LocaleKeys.useUpperLower,
  LocaleKeys.useNumbers,
  LocaleKeys.useSpecialChar,
];

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
        // appBarCustom: const AppBarCustom(
        //   screenName: Routes.forgetPasswordRoute,
        //   text: LocaleKeys.newPassword,
        // ),
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
        child: SingleChildScrollView(
          child: BlocProvider.value(
            value: BlocProvider.of<ForgetPasswordCubit>(context),
            child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
              listener: (context, state) {
                if (state is NewPasswordSuccessState) {
                  navigator(context, Routes.successRoute);
                  showToast(context,
                      message: LocaleKeys.toastResetPassword.tr(),
                      type: MessageType.success);
                } else if (state is NewPasswordErrorState) {
                  showToast(context,
                      message: state.message, type: MessageType.error);
                }
              },
              builder: (context, state) {
                var cubit = ForgetPasswordCubit.get(context);
                return Form(
                  key: cubit.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
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
                              assetsName: IconAssets.loginSvg,
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
                              text: LocaleKeys.newPassword,
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
                        hint: LocaleKeys.enterPassword.tr(),
                        controller: cubit.passwordController,
                        validate: (v) {
                          if (v!.isEmpty) {
                            return LocaleKeys.passwordTextField.tr();
                          }
                          return null;
                        },
                        keyboardType: TextInputType.visiblePassword,
                        prefixIcon: const SvgPictureCustom(
                          assetsName: IconAssets.lock,
                          color: ColorManager.black1,
                          height: AppSize.s20,
                        ),
                        prefix: true,
                        suffixIcon: LoginCubit.get(context).suffix,
                        suffix: true,
                        obSecure:
                            LoginCubit.get(context).isPassword ? true : false,
                        suffixOnPressed: () {
                          LoginCubit.get(context).changePasswordVisibility();
                        },
                      ),
                      const SizedBox(
                        height: AppSize.s16,
                      ),
                      TextFormFieldCustom(
                        radius: AppSize.s24.r,
                        fillColor: ColorManager.white,
                        hint: LocaleKeys.confirmPassword.tr(),
                        controller: cubit.confirmPasswordController,
                        validate: (v) {
                          if (v!.isEmpty) {
                            return LocaleKeys.passwordTextField.tr();
                          }
                          return null;
                        },
                        keyboardType: TextInputType.visiblePassword,
                        prefixIcon: const SvgPictureCustom(
                          assetsName: IconAssets.lock,
                          color: ColorManager.black1,
                          height: AppSize.s20,
                        ),
                        prefix: true,
                        suffixIcon: LoginCubit.get(context).suffix,
                        suffix: true,
                        obSecure:
                            LoginCubit.get(context).isPassword ? true : false,
                        suffixOnPressed: () {
                          LoginCubit.get(context).changePasswordVisibility();
                        },
                      ),
                      const SizedBox(
                        height: AppSize.s34,
                      ),
                      TextCustom(
                        text: LocaleKeys.useStrongPassword,
                        textStyle: getSemiBoldGilroyStyle(
                          color: ColorManager.black,
                          fontSize: FontSize.s16,
                        ),
                      ),
                      const SizedBox(
                        height: AppSize.s22,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: 4,
                        itemBuilder: (context, index) => Row(
                          children: [
                            Container(
                              margin:
                                  EdgeInsets.symmetric(vertical: AppPadding.p8),
                              width: AppSize.s8.h,
                              height: AppSize.s8.h,
                              decoration: const ShapeDecoration(
                                color: ColorManager.grey,
                                shape: OvalBorder(),
                              ),
                            ),
                            RSizedBox.horizontal(AppSize.s8.w),
                            TextCustom(
                              text: passwordCheckHint[index].tr(),
                              textStyle: getMediumGilroyStyle(
                                color: ColorManager.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: AppSize.s24,
                      ),
                      state is NewPasswordLoadingState
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : ElevatedButtonCustom(
                              text: LocaleKeys.savePassword,
                              fontWeight: FontWeight.bold,
                              onPressed: () {
                                if (cubit.formKey.currentState!.validate() &&
                                    cubit.passwordController.text.trim() ==
                                        cubit.confirmPasswordController.text
                                            .trim()) {
                                  cubit.newPasswordFun();
                                  cubit.formKey.currentState?.reset();
                                }
                              },
                            ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    ));
  }
}
