import 'dart:io';

import 'package:doctor_ack/core/utils/constants_manager.dart';
import 'package:doctor_ack/core/utils/media_query_values.dart';
import 'package:doctor_ack/core/widgets/component.dart';
import 'package:doctor_ack/core/widgets/elevated_button/elevated_button_custom.dart';
import 'package:doctor_ack/core/widgets/lock_role.dart';
import 'package:doctor_ack/core/widgets/scaffold_custom/scaffold_custom.dart';
import 'package:doctor_ack/core/widgets/text_form_field/text_form_field_custom.dart';
import 'package:doctor_ack/languages/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:doctor_ack/core/widgets/text_custom/text_custom.dart';
import '../../../../../core/utils/packages_imprts.dart';

import '../../../../core/controller/helper_functions.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/styles_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/cached_image/cached_network_image.dart';
import '../../../../core/widgets/drop_down/drop_dwon_button.dart';
import '../../../../core/widgets/shimmer_custom/shimmer_custom.dart';
import '../../../../core/widgets/svg_pic/svg_pic.dart';
import '../../../../injection_container.dart';
import '../manager/clinic_cubit.dart';
import '../manager/clinic_state.dart';
import '../manager/states_cubit/states_cubit.dart';
import '../manager/states_cubit/states_state.dart';

class EditClinicScreen extends StatefulWidget {
  const EditClinicScreen({super.key});

  @override
  State<EditClinicScreen> createState() => _EditClinicScreenState();
}

class _EditClinicScreenState extends State<EditClinicScreen> {
  ImagePicker imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      body: AppConstants.role == 'admin' || AppConstants.type == 'clinic'
          ? BlocProvider.value(
              value: BlocProvider.of<EditClinicCubit>(context),
              child: BlocConsumer<EditClinicCubit, EditClinicState>(
                listener: (context, state) {
                  if (state is EditClinicProfileSuccessState) {
                    showToast(context,
                        message: LocaleKeys.toastEditClinic.tr(),
                        type: MessageType.success);
                    Navigator.pop(context);
                  } else if (state is EditClinicProfileErrorState) {
                    showToast(context,
                        message: state.message, type: MessageType.error);
                  }
                },
                builder: (context, state) {
                  var cubit = EditClinicCubit.get(context);
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(
                          height: AppSize.s100.h * 3,
                          child: Stack(
                            // alignment: Alignment.center,
                            children: [
                              CachedNetworkImageCustom(
                                height: AppSize.s100 * 1.9,
                                shimmerHeight: AppSize.s100 * 1.9,
                                url: cubit.imageCover,
                              ),
                              Positioned(
                                top: AppSize.s40,
                                child: SizedBox(
                                  width: context.width,
                                  child: Padding(
                                    padding: EdgeInsets.all(AppPadding.p16),
                                    child: Row(
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
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
                                          text: LocaleKeys.editClinic,
                                          fontSize: FontSize.s18,
                                          color: ColorManager.white,
                                          fontWeight: FontWeightManager.medium,
                                        ),
                                        const Spacer(),
                                        Container(
                                          width: 36,
                                          height: 36,
                                          padding:
                                              EdgeInsets.all(AppPadding.p8),
                                          decoration: const ShapeDecoration(
                                            color: ColorManager.white1,
                                            shape: OvalBorder(),
                                          ),
                                          child: InkWell(
                                              onTap: () async {
                                                final image = await cubit
                                                    .imagePickerCover
                                                    .pickImage(
                                                        source: ImageSource
                                                            .gallery);
                                                cubit.changeImageCover(
                                                    HelperFunctions
                                                        .convertToBase64(
                                                            File(image!.path)));
                                              },
                                              child: const SvgPictureCustom(
                                                assetsName: IconAssets.editIcon,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                  top: (AppSize.s100 * 1.6),
                                  right: AppSize.s16.w,
                                  left: AppSize.s16,
                                  child: Container(
                                    color: ColorManager.white,
                                    width: context.width,
                                    // margin: EdgeInsets.symmetric(horizontal: AppPadding.p16),
                                    height: AppSize.s100,
                                    alignment: Alignment.center,
                                  )),
                              Positioned(
                                top: (AppSize.s100 * 1.1).h,
                                right: context.tablet
                                    ? (AppSize.s100 * 3).w
                                    : (AppSize.s100 * 1.10).w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: (AppSize.s100 * 1.32).h,
                                      height: (AppSize.s100 * 1.32).h,
                                      decoration: const ShapeDecoration(
                                        color: ColorManager.black,
                                        shape: OvalBorder(
                                          side: BorderSide(
                                            width: 6,
                                            strokeAlign:
                                                BorderSide.strokeAlignCenter,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      child: // cubit.image.isEmpty ?
                                          CachedNetworkImageCustom(
                                        width: (AppSize.s100 * 1.32).h,
                                        height: (AppSize.s100 * 1.32).h,
                                        boarder: AppSize.s60,
                                        url: cubit.image,
                                      ),
                                      //     : CachedNetworkImageCustom(
                                      //   boarder: AppSize.s80,
                                      //   url: cubit.image,
                                      //   boxFit: BoxFit.fill,
                                      // ),
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
                                        final image = await cubit.imagePicker
                                            .pickImage(
                                                source: ImageSource.gallery);
                                        cubit.changeImage(
                                            HelperFunctions.convertToBase64(
                                                File(image!.path)));
                                      },
                                      text: LocaleKeys.changeLogo,
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
                          padding: EdgeInsets.only(bottom: AppPadding.p16),
                          alignment: Alignment.center,
                          // height: (AppSize.s100*2).h,
                          width: context.tablet
                              ? context.width - 40
                              : (AppSize.s100 * 3.4).w,
                          color: ColorManager.white,
                          child: Form(
                            key: cubit.formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Expanded(
                                        child: Divider(
                                      thickness: 0.2,
                                      height: AppSize.s40,
                                      color: ColorManager.secondary,
                                      endIndent: AppSize.s8,
                                      indent: 0,
                                    )),
                                    Expanded(
                                      flex: 5,
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
                                  controller: cubit.nameController,
                                  radius: AppSize.s24.r,
                                  prefix: true,
                                  prefixIcon: const SvgPictureCustom(
                                    assetsName: IconAssets.profileOutline,
                                  ),
                                  hint: LocaleKeys.enterUserName.tr(),
                                  validate: (val) {
                                    if (val!.isEmpty) {
                                      return '';
                                    }
                                    return null;
                                  },
                                ),
                                const RSizedBox.vertical(AppSize.s16),
                                TextFormFieldCustom(
                                  controller: cubit.streetController,
                                  radius: AppSize.s24.r,
                                  prefix: true,
                                  prefixIcon: const SvgPictureCustom(
                                    assetsName: IconAssets.address,
                                  ),
                                  hint: LocaleKeys.enterStreet.tr(),
                                  validate: (val) {
                                    if (val!.isEmpty) {
                                      return '';
                                    }
                                    return null;
                                  },
                                ),
                                const RSizedBox.vertical(AppSize.s16),
                                TextFormFieldCustom(
                                  controller: cubit.cityController,
                                  radius: AppSize.s24.r,
                                  prefix: true,
                                  prefixIcon: const SvgPictureCustom(
                                    assetsName: IconAssets.address,
                                  ),
                                  hint: LocaleKeys.enterCity.tr(),
                                  validate: (val) {
                                    if (val!.isEmpty) {
                                      return '';
                                    }
                                    return null;
                                  },
                                ),
                                const RSizedBox.vertical(AppSize.s16),
                                BlocProvider(
                                  create: (context) =>
                                      sl<StatesCubit>()..getStatesFun(),
                                  child: BlocBuilder<StatesCubit, StatesState>(
                                    builder: (context, bankState) {
                                      return switch (bankState) {
                                        GetStatesSuccessState() =>
                                          CustomDropdownButton(
                                            dropdownDecoration: BoxDecoration(
                                              border: Border.all(
                                                  color: ColorManager.white),
                                              color: ColorManager.white,
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Color(0x19C29E8A),
                                                  blurRadius: 20,
                                                  offset: Offset(0, 3),
                                                  spreadRadius: 1,
                                                )
                                              ],
                                            ),
                                            buttonDecoration: BoxDecoration(
                                              border: Border.all(
                                                  color: ColorManager.white),
                                              color: ColorManager.white,
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Color(0x19C29E8A),
                                                  blurRadius: 20,
                                                  offset: Offset(0, 3),
                                                  spreadRadius: 1,
                                                )
                                              ],
                                            ),
                                            scrollbarAlwaysShow: true,
                                            buttonElevation: 3,
                                            color: ColorManager.white,
                                            dropdownHeight: AppSize.s50,
                                            hint: LocaleKeys.selectState.tr(),
                                            value: '0',
                                            dropdownItems: List.generate(
                                                bankState
                                                    .statesEntity
                                                    .resultEntity
                                                    .response
                                                    .length,
                                                (index) =>
                                                    DropdownMenuItem<String>(
                                                      value: bankState
                                                          .statesEntity
                                                          .resultEntity
                                                          .response[index]
                                                          .id
                                                          .toString(),
                                                      child: TextCustom(
                                                        text: bankState
                                                            .statesEntity
                                                            .resultEntity
                                                            .response[index]
                                                            .name,
                                                        textStyle:
                                                            getSemiBoldGilroyStyle(
                                                          color:
                                                              ColorManager.grey,
                                                          fontSize:
                                                              FontSize.s14,
                                                        ),
                                                      ),
                                                    )),
                                            onChanged: (onChanged) {
                                              cubit.stateController.text =
                                                  onChanged!;
                                            },
                                            onSave: (String? value) {},
                                          ),
                                        GetStatesErrorState() =>
                                          const SizedBox(),
                                        GetStatesLoadingState() =>
                                          ShimmerCustom(
                                              child: Container(
                                            height: AppSize.s50,
                                            color: ColorManager.lightGrey,
                                          )),
                                        _ => ShimmerCustom(
                                              child: Container(
                                            height: AppSize.s50,
                                            color: ColorManager.lightGrey,
                                          )),
                                      };
                                    },
                                  ),
                                ),

                                const RSizedBox.vertical(AppSize.s16),
                                TextFormFieldCustom(
                                  controller: cubit.phoneController,
                                  radius: AppSize.s24.r,
                                  prefix: true,
                                  prefixIcon: const SvgPictureCustom(
                                    assetsName: IconAssets.phone,
                                  ),
                                  hint: LocaleKeys.enterPhoneNumber.tr(),
                                  validate: (val) {
                                    if (val!.isEmpty) {
                                      return '';
                                    }
                                    return null;
                                  },
                                ),
                                const RSizedBox.vertical(AppSize.s16),
                                TextFormFieldCustom(
                                  controller: cubit.expertiseController,
                                  radius: AppSize.s24.r,
                                  prefix: true,
                                  prefixIcon: const SvgPictureCustom(
                                    assetsName: IconAssets.expertise,
                                  ),
                                  hint: LocaleKeys.enterExpertise.tr(),
                                  validate: (val) {
                                    if (val!.isEmpty) {
                                      return '';
                                    }
                                    return null;
                                  },
                                ),
                                const RSizedBox.vertical(AppSize.s16),
                                TextFormFieldCustom(
                                  controller: cubit.experienceController,
                                  radius: AppSize.s24.r,
                                  prefix: true,
                                  prefixIcon: const SvgPictureCustom(
                                    assetsName: IconAssets.time,
                                  ),
                                  hint: LocaleKeys.enterExperience.tr(),
                                  validate: (val) {
                                    if (val!.isEmpty) {
                                      return '';
                                    }
                                    return null;
                                  },
                                ),
                                const RSizedBox.vertical(AppSize.s16),
                                TextFormFieldCustom(
                                  controller: cubit.aboutController,
                                  maxLines: 4,
                                  height: AppSize.s100 * 1.2,
                                  radius: AppSize.s24.r,
                                  prefix: true,
                                  prefixIcon: const SvgPictureCustom(
                                    assetsName: IconAssets.privacy,
                                  ),
                                  hint: LocaleKeys.enterAboutClinic.tr(),
                                  validate: (val) {
                                    if (val!.isEmpty) {
                                      return '';
                                    }
                                    return null;
                                  },
                                ),
                                // const RSizedBox.vertical(AppSize.s18),
                                state is EditClinicProfileLoadingState
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : ElevatedButtonCustom(
                                        onPressed: () {
                                          if (cubit.formKey.currentState!
                                              .validate()) {
                                            cubit.editClinicProfile();
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
                    ),
                  );
                },
              ),
            )
          : const LockRoleWidget(),
    );
  }
}
