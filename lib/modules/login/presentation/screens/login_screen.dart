import 'package:doctor_ack/core/utils/constants_manager.dart';
import 'package:doctor_ack/core/utils/media_query_values.dart';
import 'package:doctor_ack/core/utils/styles_manager.dart';
import 'package:doctor_ack/core/widgets/svg_pic/svg_pic.dart';
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
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../../../../core/widgets/text_form_field/text_form_field_custom.dart';
import '../controller/login_cubit.dart';
import '../controller/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> loginFormKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      // appBarCustom: const AppBarCustom(
      //   isNull: false,
      //   widget: SizedBox(),
      // ),
      body: BlocProvider.value(
        value: BlocProvider.of<LoginCubit>(context),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              if (state.loginEntity.resultEntity.body.type == 'patient') {
                navigatorAndRemove(context, Routes.mainRoute);
              } else {
                navigatorAndRemove(context, Routes.vendorMainRoute);
              }
            } else if (state is LoginErrorState) {
              showToast(context,
                  message: state.message, type: MessageType.error);
            }
          },
          builder: (context, state) {
            var loginCubit = LoginCubit.get(context);
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.all(AppPadding.p16),
                child: Form(
                  key: loginFormKey,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
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
                                text: LocaleKeys.login,
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
                          controller: loginCubit.emailController,
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
                            height: AppSize.s20,
                          ),
                          prefix: true,
                        ),
                        const SizedBox(
                          height: AppSize.s14,
                        ),
                        TextFormFieldCustom(
                          radius: AppSize.s24.r,
                          fillColor: ColorManager.white,
                          hint: LocaleKeys.enterPassword.tr(),
                          controller: loginCubit.passwordController,
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
                          suffix: true,
                          suffixIcon: loginCubit.suffix,
                          obSecure: loginCubit.isPassword ? true : false,
                          suffixOnPressed: () {
                            loginCubit.changePasswordVisibility();
                          },
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              navigator(context, Routes.forgetPasswordRoute);
                            },
                            child: const TextCustom(
                              text: LocaleKeys.forgetPassword,
                              decoration: TextDecoration.underline,
                              color: ColorManager.grey,
                              decorationColor: ColorManager.grey,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: AppSize.s40,
                        ),
                        Center(
                          child: Column(
                            children: [
                              state is LoginLoadingState
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : ElevatedButtonCustom(
                                      text: LocaleKeys.loginB,
                                      width: context.width / 1.3,
                                      fontWeight: FontWeight.w700,
                                      onPressed: () {
                                        if (loginFormKey.currentState!
                                            .validate()) {
                                          loginCubit.loginFun();
                                          loginFormKey.currentState?.reset();
                                        }
                                      },
                                    ),
                              // const SizedBox(
                              //   height: AppSize.s16,
                              // ),
                              // ElevatedButtonCustom(
                              //   text: 'Vendor Login',
                              //   width: context.width / 1.3,
                              //   fontWeight: FontWeight.w700,
                              //   onPressed: () {
                              //     if (loginCubit.formKey.currentState!
                              //         .validate()) {
                              //     }
                              //   },
                              // ),
                              const SizedBox(
                                height: AppSize.s16,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextCustom(
                                    text: LocaleKeys.haveAccount,
                                    textStyle: getMediumGilroyStyle(
                                      color: ColorManager.grey,
                                      fontSize: FontSize.s12,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      navigator(context, Routes.registerRoute);
                                    },
                                    child: TextCustom(
                                      text: LocaleKeys.register,
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
