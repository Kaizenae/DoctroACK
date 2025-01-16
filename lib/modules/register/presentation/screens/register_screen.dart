import 'package:doctor_ack/core/utils/constants_manager.dart';
import 'package:doctor_ack/core/utils/styles_manager.dart';
import 'package:doctor_ack/languages/locale_keys.g.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/packages_imprts.dart';
import '../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/routes_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/component.dart';
import '../../../../core/widgets/elevated_button/elevated_button_custom.dart';
import '../../../../core/widgets/svg_pic/svg_pic.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../../../../core/widgets/text_form_field/text_form_field_custom.dart';

import '../../../../injection_container.dart';
import '../controller/register_cubit.dart';
import '../controller/register_state.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      // appBarCustom: const AppBarCustom(
      //   isNull: false,
      //   widget: SizedBox(),
      // ),
      body: BlocProvider(
        create: (context) => sl<RegisterCubit>(),
        child: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is RegisterSuccessState) {
              showToast(context,
                  message: LocaleKeys.toastRegister.tr(),
                  type: MessageType.success);
              navigatorAndRemove(context, Routes.loginRoute);
            } else if (state is RegisterErrorState) {
              showToast(context,
                  message: state.message, type: MessageType.error);
            }
          },
          builder: (context, state) {
            var registerCubit = RegisterCubit.get(context);
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.all(AppPadding.p16),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Form(
                    key: registerCubit.formKey,
                    child: Column(
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
                                assetsName: IconAssets.signupSvg,
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
                                text: LocaleKeys.register,
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
                          hint: LocaleKeys.enterUserName.tr(),
                          controller: registerCubit.nameController,
                          validate: (value) {
                            if (value!.trim().isEmpty || value == ' ') {
                              return LocaleKeys.nameTextField.tr();
                            }

                            return null;
                          },
                          keyboardType: TextInputType.name,
                          prefixIcon: const SvgPictureCustom(
                            assetsName: IconAssets.profileOutline,
                            color: ColorManager.black1,
                            height: AppSize.s24,
                          ),
                          prefix: true,
                        ),
                        const SizedBox(
                          height: AppSize.s18,
                        ),
                        TextFormFieldCustom(
                          radius: AppSize.s24.r,
                          fillColor: ColorManager.white,
                          hint: LocaleKeys.enterEmail.tr(),
                          controller: registerCubit.emailController,
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
                        const SizedBox(
                          height: AppSize.s18,
                        ),
                        TextFormFieldCustom(
                          radius: AppSize.s24.r,
                          fillColor: ColorManager.white,
                          hint: "05 xxx xxx xx",
                          controller: registerCubit.phoneController,
                          validate: (value) {
                            if (value!.trim().isEmpty || value == ' ') {
                              return LocaleKeys.phoneTextField.tr();
                            }
                            if (!RegExp(r"[a-z0-9]").hasMatch(value)) {
                              return LocaleKeys.phoneTextField.tr();
                            }
                            if (value.toString().length >= 11) {
                              return LocaleKeys.phoneNumberDoesntCorrect.tr();
                            }
                            if (value.toString().length <= 9) {
                              return LocaleKeys.phoneNumberDoesntCorrect.tr();
                            }
                            return null;
                          },
                          keyboardType: TextInputType.phone,
                          prefixIcon: const SvgPictureCustom(
                            assetsName: IconAssets.phone,
                            color: ColorManager.black1,
                            height: AppSize.s24,
                          ),
                          prefix: true,
                        ),
                        const SizedBox(
                          height: AppSize.s18,
                        ),
                        TextFormFieldCustom(
                          radius: AppSize.s24.r,
                          fillColor: ColorManager.white,
                          hint: LocaleKeys.enterPassword.tr(),
                          controller: registerCubit.passwordController,
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
                            height: AppSize.s24,
                          ),
                          prefix: true,
                          suffixIcon: registerCubit.suffix,
                          suffix: true,
                          obSecure: registerCubit.isPassword ? true : false,
                          suffixOnPressed: () {
                            registerCubit.changePasswordVisibility();
                          },
                        ),
                        const SizedBox(
                          height: AppSize.s40,
                        ),
                        Center(
                          child: Column(
                            children: [
                              state is RegisterLoadingState
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : ElevatedButtonCustom(
                                      text: LocaleKeys.register,
                                      textStyle: getSemiBoldGilroyStyle(
                                          color: ColorManager.white,
                                          fontSize: FontSize.s18),
                                      onPressed: () {
                                        if (registerCubit.formKey.currentState!
                                            .validate()) {
                                          registerCubit.registerFun();
                                          registerCubit.formKey.currentState
                                              ?.reset();
                                        }
                                      },
                                    ),
                              const SizedBox(
                                height: AppSize.s16,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextCustom(
                                    text: LocaleKeys.alreadyHaveAccount,
                                    textStyle: getMediumGilroyStyle(
                                      color: ColorManager.grey,
                                      fontSize: FontSize.s12,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      navigator(context, Routes.loginRoute);
                                    },
                                    child: TextCustom(
                                      text: LocaleKeys.login,
                                      textStyle: getSemiBoldGilroyStyle(
                                          color: ColorManager.black,
                                          fontSize: FontSize.s12),
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
