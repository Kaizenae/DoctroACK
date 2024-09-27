import 'dart:io';

import 'package:doctor_ack/core/utils/constants_manager.dart';
import 'package:doctor_ack/core/utils/media_query_values.dart';
import 'package:doctor_ack/core/utils/styles_manager.dart';
import 'package:doctor_ack/core/widgets/elevated_button/elevated_button_custom.dart';
import 'package:doctor_ack/core/widgets/text_form_field/text_form_field_custom.dart';
import 'package:doctor_ack/languages/locale_keys.g.dart';

import '../../../../core/controller/helper_functions.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/component.dart';
import '../../../../core/widgets/cached_image/cached_network_image.dart';
import '../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import 'package:flutter/material.dart';
import '../../../../core/widgets/svg_pic/svg_pic.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../../../profile/presentation/cubit/profile_cubit.dart';
import '../cubit/edit_profile_cubit.dart';
import '../cubit/edit_profile_state.dart';
import '../../../../../core/utils/packages_imprts.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: BlocProvider.value(
            value: BlocProvider.of<EditProfileCubit>(context),
            child: BlocConsumer<EditProfileCubit, EditProfileStates>(
              listener: (context, state) {
                if (state is EditProfileSuccessState) {
                  showToast(context,
                      message: LocaleKeys.toastEditProfile.tr(),
                      type: MessageType.success);
                  ProfileCubit.get(context).getProfileFun();
                  Navigator.pop(context);
                } else if (state is EditProfileErrorState) {
                  showToast(context,
                      message: state.message, type: MessageType.error);
                }
              },
              builder: (context, state) {
                var editProfileCubit = EditProfileCubit.get(context);
                return Column(
                  children: [
                    SizedBox(
                      height: AppSize.s100.h * 3,
                      child: Stack(
                        // alignment: Alignment.center,
                        children: [
                          Image.asset(
                            ImageAssets.profileRectangle,
                            width: double.infinity,
                            fit: BoxFit.fitWidth,
                            height: (AppSize.s100 * 1.79).h,
                          ),
                          Positioned(
                            top: AppSize.s24,
                            child: SizedBox(
                              width: context.width,
                              child: Padding(
                                padding: EdgeInsets.all(AppPadding.p16),
                                child: Row(
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          if (editProfileCubit.checkChanges()) {
                                            Navigator.pop(context);
                                          } else {
                                            dialogCustom(
                                              context: context,
                                              okButtonName: 'Discard',
                                              body: Column(
                                                children: [
                                                  TextCustom(
                                                    text:
                                                        '${LocaleKeys.editProfile.tr()}?',
                                                    fontWeight:
                                                        FontWeightManager
                                                            .semiBold,
                                                    fontSize: FontSize.s18,
                                                  ),
                                                  const RSizedBox.vertical(
                                                      AppSize.s16),
                                                  TextCustom(
                                                    text:
                                                        'Your Changes Will be discard. Are you sure?',
                                                    textStyle:
                                                        getMediumGilroyStyle(
                                                      color: ColorManager.grey,
                                                      fontSize: FontSize.s14,
                                                    ),
                                                  ),
                                                  const RSizedBox.vertical(
                                                      AppSize.s16),
                                                ],
                                              ),
                                              pressEventOk: () {
                                                Navigator.popUntil(context,
                                                    (route) => route.isFirst);
                                              },
                                            );
                                          }
                                        },
                                        child: SvgPictureCustom(
                                          assetsName: AppConstants.language
                                              ? IconAssets.arrowRight
                                              : IconAssets.arrowLeft,
                                          color: ColorManager.white,
                                        )),
                                    SizedBox(
                                      width: AppSize.s20.w,
                                    ),
                                    TextCustom(
                                      text: LocaleKeys.editProfile,
                                      fontSize: FontSize.s18,
                                      color: ColorManager.white,
                                      fontWeight: FontWeightManager.medium,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                              top: (AppSize.s100 * 1.4).h,
                              right: context.tablet
                                  ? AppSize.s100.w * 2.5
                                  : AppSize.s16.w,
                              child: Container(
                                color: ColorManager.white,
                                width: (AppSize.s100 * 3.4).w,
                                height: AppSize.s100.h * 1.4,
                                alignment: Alignment.center,
                              )),
                          Positioned(
                            top: (AppSize.s80).h,
                            right: context.tablet
                                ? context.width / 2.3
                                : (AppSize.s100 * 1.10).w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: (AppSize.s100 * 1.32).h,
                                  height: (AppSize.s100 * 1.32).h,
                                  decoration: const ShapeDecoration(
                                    shape: OvalBorder(
                                      side: BorderSide(
                                        width: 6,
                                        strokeAlign:
                                            BorderSide.strokeAlignCenter,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  child: Container(
                                    height: AppSize.s80,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle),
                                    child: CachedNetworkImageCustom(
                                      height: AppSize.s80,
                                      boarder: AppSize.s80,
                                      url: editProfileCubit.image!,
                                    ),
                                  ),
                                ),
                                ElevatedButtonCustom(
                                  width: (AppSize.s100 * 1.56).w,
                                  height: AppSize.s40.h,
                                  radius: AppSize.s30.r,
                                  colors: ColorManager.secondary1,
                                  borderColor: ColorManager.secondary1,
                                  fontWeight: FontWeightManager.regular,
                                  fontSize: FontSize.s14,
                                  onPressed: () async {
                                    final image = await editProfileCubit
                                        .imagePicker
                                        .pickImage(source: ImageSource.gallery);

                                    editProfileCubit.changeImage(
                                        HelperFunctions.convertToBase64(
                                            File(image!.path)));
                                  },
                                  text: LocaleKeys.changePicture,
                                  textStyle: getMediumGilroyStyle(
                                      color: ColorManager.white,
                                      fontSize: FontSize.s14,
                                      height: 0.10),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // padding: EdgeInsets.only(top: AppPadding.p100 / 0.7),
                      alignment: Alignment.center,
                      // height: (AppSize.s100*2).h,
                      width: (AppSize.s100 * 3.4).w,
                      color: ColorManager.white,
                      child: Form(
                        key: editProfileCubit.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Expanded(
                                    child: Divider(
                                  thickness: 0.2,
                                  height: AppSize.s40,
                                  color: ColorManager.red,
                                  endIndent: AppSize.s20,
                                  indent: 0,
                                )),
                                Expanded(
                                  flex: 3,
                                  child: TextCustom(
                                    text: LocaleKeys.information,
                                    fontSize: FontSize.s18,
                                    fontWeight: FontWeightManager.bold,
                                  ),
                                ),
                              ],
                            ),
                            const RSizedBox.vertical(AppSize.s18),
                            TextFormFieldCustom(
                              controller: editProfileCubit.userNameController,
                              fillColor: ColorManager.white,
                              boarderColor: ColorManager.white,
                              radius: AppSize.s24.r,
                              prefix: true,
                              prefixIcon: const SvgPictureCustom(
                                assetsName: IconAssets.profileIcon,
                              ),
                              hint: LocaleKeys.enterUserName.tr(),
                              validate: (value) {
                                if (value!.trim().isEmpty || value == ' ') {
                                  return LocaleKeys.nameTextField.tr();
                                }

                                return null;
                              },
                            ),
                            const RSizedBox.vertical(AppSize.s16),
                            TextFormFieldCustom(
                              controller: editProfileCubit.emailController,
                              fillColor: ColorManager.white,
                              boarderColor: ColorManager.white,
                              radius: AppSize.s24.r,
                              prefix: true,
                              prefixIcon: const SvgPictureCustom(
                                assetsName: IconAssets.email,
                              ),
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
                            const RSizedBox.vertical(AppSize.s16),
                            TextFormFieldCustom(
                              controller:
                                  editProfileCubit.phoneNumberController,
                              fillColor: ColorManager.white,
                              boarderColor: ColorManager.white,
                              radius: AppSize.s24.r,
                              prefix: true,
                              prefixIcon: const SvgPictureCustom(
                                assetsName: IconAssets.phone,
                              ),
                              hint: LocaleKeys.enterPhoneNumber.tr(),
                              validate: (value) {
                                if (value!.trim().isEmpty || value == ' ') {
                                  return LocaleKeys.phoneTextField.tr();
                                }
                                if (!RegExp(r"[a-z0-9]").hasMatch(value)) {
                                  return LocaleKeys.phoneTextField.tr();
                                }
                                return null;
                              },
                            ),
                            const RSizedBox.vertical(AppSize.s70),
                            state is EditProfileLoadingState
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : ElevatedButtonCustom(
                                    onPressed: () {
                                      if (editProfileCubit.formKey.currentState!
                                          .validate()) {
                                        editProfileCubit.editProfile();
                                      }
                                    },
                                    radius: AppSize.s50.r,
                                    text: LocaleKeys.done,
                                    textStyle: getSemiBoldGilroyStyle(
                                        color: ColorManager.white,
                                        fontSize: FontSize.s18,
                                        height: 0.08),
                                  )
                          ],
                        ),
                      ),
                    )
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
