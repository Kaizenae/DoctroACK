import 'package:doctor_ack/core/utils/constants_manager.dart';
import 'package:doctor_ack/core/utils/media_query_values.dart';
import 'package:doctor_ack/core/utils/styles_manager.dart';
import 'package:doctor_ack/core/widgets/component.dart';
import 'package:doctor_ack/core/widgets/elevated_button/elevated_button_custom.dart';
import 'package:doctor_ack/core/widgets/svg_pic/svg_pic.dart';
import 'package:doctor_ack/core/widgets/text_form_field/text_form_field_custom.dart';
import 'package:doctor_ack/languages/locale_keys.g.dart';
import 'package:doctor_ack/modules/help_and_feedback/presentation/controllers/contact_us_cubit.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/packages_imprts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/app_bar/app_bar_custom.dart';
import '../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';

class HelpAndFeedbackScreen extends StatelessWidget {
  const HelpAndFeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
        backgroundColor: ColorManager.white1,
        appBarCustom: const AppBarCustom(
          backgroundColor: ColorManager.white1,
          text: LocaleKeys.contactUs,
          centerTitle: false,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  // margin: EdgeInsets.all(AppPadding.p16),

                  padding: EdgeInsets.all(AppPadding.p24),
                  width: (AppSize.s100 * 3.43).w,
                  // height: (AppSize.s100 * 4.20).h,
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x26EEC6B3),
                        blurRadius: AppSize.s14.r,
                        offset: const Offset(AppSize.s0, AppSize.s4),
                        spreadRadius: AppSize.s0,
                      )
                    ],
                  ),
                  child: BlocProvider.value(
                    value: BlocProvider.of<ContactUsCubit>(context),
                    child: BlocConsumer<ContactUsCubit, ContactUsState>(
                      listener: (context, state) {
                        if (state is ContactUsSuccessState) {
                          showToast(context,
                              message: LocaleKeys.toastMessageSent.tr(),
                              type: MessageType.success);
                          Navigator.pop(context);
                        } else if (state is ContactUsErrorState) {
                          showToast(context,
                              message: state.message, type: MessageType.error);
                        }
                      },
                      builder: (context, state) {
                        var cubit = ContactUsCubit.get(context);
                        return Form(
                          key: cubit.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextFormFieldCustom(
                                controller: cubit.nameController,
                                fillColor: ColorManager.white,
                                radius: AppSize.s0,
                                hint: LocaleKeys.enterFirstLastName.tr(),
                                validate: (value) {
                                  if (value!.trim().isEmpty || value == ' ') {
                                    return LocaleKeys.nameTextField.tr();
                                  }

                                  return null;
                                },
                              ),
                              const RSizedBox.vertical(AppSize.s14),
                              TextFormFieldCustom(
                                controller: cubit.emailController,
                                fillColor: ColorManager.white,
                                keyboardType: TextInputType.emailAddress,
                                radius: AppSize.s0,
                                hint: LocaleKeys.enterEmail.tr(),
                                validate: (value) {
                                  if (value!.trim().isEmpty || value == ' ') {
                                    return LocaleKeys.emailTextField.tr();
                                  }
                                  if (!RegExp(r"""
[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?""")
                                      .hasMatch(value)) {
                                    return LocaleKeys.emailValidTextField.tr();
                                  }
                                  return null;
                                },
                              ),
                              const RSizedBox.vertical(AppSize.s14),
                              TextFormFieldCustom(
                                controller: cubit.subjectController,
                                fillColor: ColorManager.white,
                                keyboardType: TextInputType.text,
                                radius: AppSize.s0,
                                hint: LocaleKeys.enterSubject.tr(),
                                validate: (value) {
                                  if (value!.trim().isEmpty || value == ' ') {
                                    return LocaleKeys.subjectTextField.tr();
                                  }

                                  return null;
                                },
                              ),
                              const RSizedBox.vertical(AppSize.s14),
                              TextFormFieldCustom(
                                controller: cubit.messageController,
                                height: AppSize.s100 * 1.76,
                                fillColor: ColorManager.white,
                                radius: AppSize.s0,
                                keyboardType: TextInputType.multiline,
                                textInputAction: TextInputAction.newline,
                                maxLines: 10,
                                hint: LocaleKeys.message.tr(),
                                validate: (value) {
                                  if (value!.trim().isEmpty || value == ' ') {
                                    return LocaleKeys.message.tr();
                                  }
                                  return null;
                                },
                              ),
                              const RSizedBox.vertical(AppSize.s14),
                              state is ContactUsLoadingState
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : ElevatedButtonCustom(
                                      width: (AppSize.s100 * 2.5).w,
                                      onPressed: () {
                                        if (cubit.formKey.currentState!
                                            .validate()) {
                                          cubit.contactUsFun();
                                          cubit.emailController.clear();
                                          cubit.nameController.clear();
                                          cubit.messageController.clear();
                                          cubit.subjectController.clear();
                                          cubit.formKey.currentState!.reset();
                                        }
                                      },
                                      text: LocaleKeys.submit,
                                      textStyle: getSemiBoldGilroyStyle(
                                          color: ColorManager.white,
                                          fontSize: FontSize.s16,
                                          height: 0.09),
                                    )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  height: context.height / 2.65,
                  color: ColorManager.white,
                  child: Column(
                    children: [
                      RSizedBox.vertical(AppSize.s100.h),
                      SizedBox(
                        height: AppSize.s40.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(AppPadding.p8),
                                  width: AppSize.s40.h,
                                  height: AppSize.s40.h,
                                  decoration: const ShapeDecoration(
                                    color: Color(0xFFE9F6F6),
                                    shape: OvalBorder(),
                                  ),
                                  child: const SvgPictureCustom(
                                    assetsName: IconAssets.email,
                                  ),
                                ),
                                const RSizedBox.horizontal(AppSize.s8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextCustom(
                                      text: LocaleKeys.email,
                                      textStyle: getMediumGilroyStyle(
                                          color: ColorManager.primary,
                                          fontSize: FontSize.s12),
                                    ),
                                    TextCustom(
                                      text: 'info@doctorack.com',
                                      textStyle: getMediumGilroyStyle(
                                          color: ColorManager.grey,
                                          fontSize: FontSize.s12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(AppPadding.p8),
                                  width: AppSize.s40.h,
                                  height: AppSize.s40.h,
                                  decoration: const ShapeDecoration(
                                    color: Color(0xFFF0E7D1),
                                    shape: OvalBorder(),
                                  ),
                                  child: const SvgPictureCustom(
                                    assetsName: IconAssets.phone,
                                  ),
                                ),
                                const RSizedBox.horizontal(AppSize.s8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextCustom(
                                      text: LocaleKeys.phone,
                                      textStyle: getMediumGilroyStyle(
                                          color: ColorManager.primary,
                                          fontSize: FontSize.s12),
                                    ),
                                    TextCustom(
                                      text: '965231456',
                                      textStyle: getMediumGilroyStyle(
                                          color: ColorManager.grey,
                                          fontSize: FontSize.s12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
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

  Future<void> launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }
}
