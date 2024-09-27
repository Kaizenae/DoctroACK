import 'package:doctor_ack/core/utils/assets_manager.dart';
import 'package:doctor_ack/core/utils/font_manager.dart';
import 'package:doctor_ack/core/utils/routes_manager.dart';
import 'package:doctor_ack/core/utils/styles_manager.dart';
import 'package:doctor_ack/core/widgets/component.dart';
import 'package:doctor_ack/core/widgets/svg_pic/svg_pic.dart';
import 'package:doctor_ack/languages/locale_keys.g.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/constants_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/app_bar/app_bar_custom.dart';
import '../../../../core/widgets/elevated_button/elevated_button_custom.dart';
import '../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../../../../core/widgets/text_form_field/text_form_field_custom.dart';
import '../../../../injection_container.dart';
import '../cubit/change_password_cubit.dart';
import '../cubit/change_password_state.dart';
import '../../../../core/utils/packages_imprts.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      appBarCustom: const AppBarCustom(
        centerTitle: false,
        text: LocaleKeys.changePassword,
      ),
      body: BlocProvider(
        create: (context) => sl<ChangePasswordCubit>(),
        child: BlocConsumer<ChangePasswordCubit, ChangePasswordStates>(
          listener: (context, state) {
            if (state is ChangePasswordSuccessState) {
              Navigator.pop(context);
              showToast(context,
                  message: LocaleKeys.toastChangePassword.tr(),
                  type: MessageType.success);
            } else if (state is ChangePasswordErrorState) {
              showToast(context,
                  message: state.message, type: MessageType.error);
            }
          },
          builder: (context, state) {
            var changePasswordCubit = ChangePasswordCubit.get(context);
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.all(AppPadding.p16),
                child: Form(
                  key: changePasswordCubit.formKey,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const RSizedBox.vertical(
                          AppSize.s16,
                        ),
                        TextFormFieldCustom(
                          fillColor: ColorManager.white,
                          boarderColor: ColorManager.white,
                          radius: AppSize.s24.r,
                          hint: LocaleKeys.enterCurrentPassword,
                          controller: changePasswordCubit.oldPasswordController,
                          validate: (v) {
                            if (v!.isEmpty) {
                              return LocaleKeys.oldPasswordValidate.tr();
                            }
                            return null;
                          },
                          keyboardType: TextInputType.visiblePassword,
                          suffixIcon: changePasswordCubit.suffix,
                          suffix: true,
                          prefix: true,
                          prefixIcon: const SvgPictureCustom(
                              assetsName: IconAssets.lock),
                          obSecure:
                              changePasswordCubit.isPassword ? true : false,
                          suffixOnPressed: () {
                            changePasswordCubit.changePasswordVisibility();
                          },
                        ),
                        const RSizedBox.vertical(
                          AppSize.s16,
                        ),
                        TextFormFieldCustom(
                          fillColor: ColorManager.white,
                          boarderColor: ColorManager.white,
                          radius: AppSize.s24.r,
                          hint: LocaleKeys.newPassword,
                          controller: changePasswordCubit.newPasswordController,
                          validate: (v) {
                            if (v!.isEmpty) {
                              return LocaleKeys.passwordTextField.tr();
                            }
                            return null;
                          },
                          keyboardType: TextInputType.visiblePassword,
                          suffixIcon: changePasswordCubit.suffixConfirm,
                          suffix: true,
                          prefix: true,
                          prefixIcon: const SvgPictureCustom(
                              assetsName: IconAssets.lock),
                          obSecure: changePasswordCubit.isPasswordConfirm
                              ? true
                              : false,
                          suffixOnPressed: () {
                            changePasswordCubit
                                .changePasswordConfirmVisibility();
                          },
                        ),
                        const RSizedBox.vertical(
                          AppSize.s16,
                        ),
                        TextFormFieldCustom(
                          fillColor: ColorManager.white,
                          boarderColor: ColorManager.white,
                          radius: AppSize.s24.r,
                          hint: LocaleKeys.confirmNewPassword,
                          controller:
                              changePasswordCubit.newPasswordConfirmController,
                          validate: (v) {
                            if (v!.isEmpty) {
                              return LocaleKeys.passwordTextField.tr();
                            }
                            return null;
                          },
                          keyboardType: TextInputType.visiblePassword,
                          suffixIcon: changePasswordCubit.suffixConfirm,
                          suffix: true,
                          prefix: true,
                          prefixIcon: const SvgPictureCustom(
                              assetsName: IconAssets.lock),
                          obSecure: changePasswordCubit.isPasswordConfirm
                              ? true
                              : false,
                          suffixOnPressed: () {
                            changePasswordCubit
                                .changePasswordConfirmVisibility();
                          },
                        ),
                        const RSizedBox.vertical(
                          AppSize.s16,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {
                                navigator(context, Routes.forgetPasswordRoute);
                              },
                              child: TextCustom(
                                text: LocaleKeys.forgetPassword,
                                textStyle: getMediumGilroyStyle(
                                    color: ColorManager.primary,
                                    fontSize: FontSize.s14),
                                decoration: TextDecoration.underline,
                                decorationColor: ColorManager.primary,
                              )),
                        ),
                        const SizedBox(
                          height: AppSize.s40,
                        ),
                        Center(
                          child: state is ChangePasswordLoadingState
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : ElevatedButtonCustom(
                                  radius: AppSize.s50,

                                  // width: 100,
                                  onPressed: () async {
                                    if (changePasswordCubit
                                            .formKey.currentState!
                                            .validate() &&
                                        changePasswordCubit
                                                .newPasswordController.text ==
                                            changePasswordCubit
                                                .newPasswordConfirmController
                                                .text) {
                                      changePasswordCubit.changePasswordFun();
                                      changePasswordCubit.oldPasswordController
                                          .clear();
                                      changePasswordCubit
                                          .newPasswordConfirmController
                                          .clear();
                                      changePasswordCubit.newPasswordController
                                          .clear();
                                    }
                                  },
                                  text: LocaleKeys.save,
                                  textStyle: getMediumGilroyStyle(
                                      color: ColorManager.white,
                                      fontSize: FontSize.s16),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
