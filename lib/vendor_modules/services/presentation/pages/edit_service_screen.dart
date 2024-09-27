import 'dart:io';

import 'package:doctor_ack/core/controller/helper_functions.dart';
import 'package:doctor_ack/core/utils/media_query_values.dart';
import 'package:doctor_ack/core/widgets/elevated_button/elevated_button_custom.dart';
import 'package:doctor_ack/core/widgets/lock_role.dart';
import '../../../../core/widgets/cached_image/cached_network_image.dart';import 'package:doctor_ack/core/widgets/scaffold_custom/scaffold_custom.dart';
import 'package:doctor_ack/core/widgets/text_form_field/text_form_field_custom.dart';
import 'package:doctor_ack/languages/locale_keys.g.dart';
import 'package:doctor_ack/modules/all_services/presentation/controllers/all_clinics_cubit/all_services_cubit.dart';
import 'package:doctor_ack/vendor_modules/services/presentation/manager/services_cubit.dart';
import 'package:doctor_ack/vendor_modules/services/presentation/manager/services_state.dart';
import 'package:flutter/material.dart';
import 'package:doctor_ack/core/widgets/text_custom/text_custom.dart';
import '../../../../../core/utils/packages_imprts.dart';

import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/constants_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/styles_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/component.dart';
import '../../../../core/widgets/svg_pic/svg_pic.dart';

// class WorkingDaysEntity {
//   final int id;
//   final String name;
//
//   WorkingDaysEntity({
//     required this.id,
//     required this.name,
//   });
// }

class EditServiceScreen extends StatefulWidget {
  const EditServiceScreen({super.key});

  @override
  State<EditServiceScreen> createState() => _EditServiceScreenState();
}

class _EditServiceScreenState extends State<EditServiceScreen> {
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
              value: BlocProvider.of<ServicesCubit>(context),
              child: BlocConsumer<ServicesCubit, ServicesState>(
                listener: (context, state) {
                  if (state is EditServiceSuccessState) {
                    showToast(context,
                        message: LocaleKeys.toastEditTreatment.tr(),
                        type: MessageType.success);
                    AllServicesCubit.get(context).getAllServices();
                    Navigator.pop(context);
                  } else if (state is EditServiceErrorState) {
                    showToast(context,
                        message: state.message, type: MessageType.error);
                  }
                },
                builder: (context, state) {
                  var cubit = ServicesCubit.get(context);
                  return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          SizedBox(
                            height: AppSize.s100.h * 3,
                            child: Stack(
                              // alignment: Alignment.center,
                              children: [
                                Image.asset(
                                  ImageAssets.profileRectangle,
                                  width: context.width,
                                  height: (AppSize.s100 * 1.9).h,
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
                                                assetsName:
                                                    AppConstants.language
                                                        ? IconAssets.arrowRight
                                                        : IconAssets.arrowLeft,
                                                color: ColorManager.white,
                                              )),
                                          SizedBox(
                                            width: AppSize.s20.w,
                                          ),
                                          TextCustom(
                                            text: LocaleKeys.editService,
                                            fontSize: FontSize.s18,
                                            color: ColorManager.white,
                                            fontWeight:
                                                FontWeightManager.medium,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    top: (AppSize.s100 * 1.7).h,
                                    right: AppSize.s16.w,
                                    child: Container(
                                      color: ColorManager.white,
                                      width: (AppSize.s100 * 3.4).w,
                                      height: AppSize.s100.h * 1.4,
                                      alignment: Alignment.center,
                                    )),
                                Positioned(
                                  top: (AppSize.s100).h,
                                  right: (AppSize.s100 * 1.10).w,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                        child: cubit.image.isEmpty
                                            ? Padding(
                                                padding: EdgeInsets.all(
                                                    AppPadding.p36),
                                                child: const SvgPictureCustom(
                                                  assetsName:
                                                      IconAssets.service1,
                                                  color: ColorManager
                                                      .serviceIconColor,
                                                ),
                                              )
                                            : CachedNetworkImageCustom(
                                                boarder: AppSize.s80,
                                                url:
                                                        cubit.image,
                                                boxFit: BoxFit.fill,
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
                            // padding: EdgeInsets.only(top: AppPadding.p100 / 0.7),
                            alignment: Alignment.center,
                            // height: (AppSize.s100*2).h,
                            width: (AppSize.s100 * 3.4).w,
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

                                  TextFormFieldCustom(
                                    controller: cubit.nameController,
                                    fillColor: ColorManager.white,
                                    boarderColor: ColorManager.white,
                                    radius: AppSize.s24.r,
                                    prefix: true,
                                    prefixIcon: const SvgPictureCustom(
                                      assetsName: IconAssets.serviceActive,
                                      color: ColorManager.black,
                                    ),
                                    hint: LocaleKeys.enterServiceName.tr(),
                                    validate: (value) {
                                      if (value!.trim().isEmpty ||
                                          value == ' ') {
                                        return LocaleKeys.nameTextField.tr();
                                      }

                                      return null;
                                    },
                                    keyboardType: TextInputType.name,
                                    suffixIcon: IconAssets.profileOutline,
                                    suffix: true,
                                  ),
                                  const SizedBox(
                                    height: AppSize.s18,
                                  ),

                                  TextFormFieldCustom(
                                    controller: cubit.priceController,
                                    fillColor: ColorManager.white,
                                    boarderColor: ColorManager.white,
                                    radius: AppSize.s24.r,
                                    prefix: true,
                                    prefixIcon: const SvgPictureCustom(
                                      assetsName: IconAssets.dollarCircle,
                                      color: ColorManager.black,
                                    ),
                                    hint: LocaleKeys.enterServicePrice.tr(),
                                    validate: (value) {
                                      if (value!.trim().isEmpty ||
                                          value == ' ') {
                                        return LocaleKeys.priceTextField.tr();
                                      }

                                      return null;
                                    },
                                    keyboardType: TextInputType.number,
                                    // suffixIcon: IconAssets.d,
                                    // suffix: true,
                                  ),
                                  const SizedBox(
                                    height: AppSize.s18,
                                  ),

                                  Container(
                                    // height: AppSize.s100 * 3,
                                    decoration: ShapeDecoration(
                                      // color: fillColor,

                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(AppSize.s24),
                                      ),
                                      shadows: const [
                                        BoxShadow(
                                          color: Color(0x19C29E8A),
                                          blurRadius: 20,
                                          offset: Offset(0, 3),
                                          spreadRadius: 1,
                                        )
                                      ],
                                    ),

                                    child: TextFormField(
                                      controller: cubit.aboutController,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: ColorManager.white,
                                        isDense: true,
                                        //floatingLabelBehavior: FloatingLabelBehavior.auto,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              AppSize.s24),
                                          borderSide: const BorderSide(
                                            color: ColorManager.white,
                                            width: AppSize.s1_5,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              AppSize.s24),
                                          borderSide: const BorderSide(
                                            color: ColorManager.white,
                                            width: AppSize.s1_5,
                                          ),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: AppPadding.p16,
                                          horizontal: AppPadding.p16,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              AppSize.s24),
                                          borderSide: const BorderSide(
                                            color: ColorManager.white,
                                            width: AppSize.s1_5,
                                          ),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              AppSize.s24),
                                          borderSide: const BorderSide(
                                            color: Colors.red,
                                            width: AppSize.s1_5,
                                          ),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              AppSize.s24),
                                          borderSide: const BorderSide(
                                            color: Colors.red,
                                          ),
                                        ),
                                        suffixIconColor:
                                            ColorManager.textFormIconColor,

                                        prefixIcon: Padding(
                                          padding:
                                              EdgeInsets.all(AppPadding.p16),
                                          child: const SvgPictureCustom(
                                            assetsName: IconAssets.privacy,
                                            color: ColorManager.black,
                                          ),
                                        ),
                                        hintText:
                                            LocaleKeys.enterServiceAbout.tr(),
                                        // helperText: 'sdsfsdf',
                                        hintStyle: getLightGilroyStyle(
                                            color: ColorManager.grey,
                                            fontSize: FontSize.s16,
                                            height: 0.10),
                                        //   suffixIcon:const SvgPictureCustom(
                                        //   assetsName: IconAssets.service1,color: ColorManager.black,
                                        // ) ,
                                        focusColor: ColorManager.textFormColor,

                                        labelStyle: const TextStyle(
                                          color: ColorManager.grey,
                                          fontSize: AppSize.s16,
                                        ),
                                        floatingLabelStyle: const TextStyle(
                                          color: ColorManager.primary,
                                          fontSize: AppSize.s16,
                                        ),
                                      ),
                                      validator: (validate) {
                                        if (validate!.isEmpty) {
                                          return LocaleKeys
                                              .aboutServiceTextField;
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.multiline,
                                      textInputAction: TextInputAction.newline,
                                      maxLines: 3,
                                    ),
                                  ),
                                  const RSizedBox.vertical(AppSize.s70),
                                  state is EditServiceLoadingState
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : ElevatedButtonCustom(
                                          onPressed: () {
                                            if (cubit.formKey.currentState!
                                                .validate()) {
                                              cubit.editService();
                                            }
                                          },
                                          radius: AppSize.s50.r,
                                          text: LocaleKeys.done,
                                          textStyle: getSemiBoldGilroyStyle(
                                              color: ColorManager.white,
                                              fontSize: FontSize.s18,
                                              height: 0.08),
                                        )

                                  // MultiSelectChipField(
                                  //   autovalidateMode: AutovalidateMode.onUserInteraction,
                                  //   scroll: false,
                                  //   textStyle: Theme.of(context)
                                  //       .textTheme
                                  //       .headlineMedium!
                                  //       .copyWith(color: ColorManager.black),
                                  //   items: _items,
                                  //   initialValue: const [],
                                  //   title: Text(
                                  //     "Working Days",
                                  //     style: Theme.of(context)
                                  //         .textTheme
                                  //         .headlineMedium!
                                  //         .copyWith(color: ColorManager.textFormColor),
                                  //   ),
                                  //   headerColor: ColorManager.primary,
                                  //   decoration: BoxDecoration(
                                  //       border: Border.all(
                                  //           color: ColorManager.primary, width: 1.8),
                                  //       borderRadius: BorderRadius.circular(AppSize.s8)),
                                  //   selectedChipColor: ColorManager.secondary1,
                                  //   selectedTextStyle:
                                  //       const TextStyle(color: ColorManager.primary),
                                  //   onTap: (values) {
                                  //     //_selectedAnimals4 = values;
                                  //   },
                                  // ),
                                  // const SizedBox(height: AppSize.s16),
                                  //################################################################################################
                                  // MultiSelectDialogField with initial values
                                  //################################################################################################
                                  // MultiSelectDialogField(
                                  //   onConfirm: (val) {
                                  //     _selectedAnimals5 = val;
                                  //   },
                                  //   dialogWidth: MediaQuery.of(context).size.width * 0.7,
                                  //   items: _items,
                                  //   initialValue:
                                  //   _selectedAnimals5, // setting the value of this in initState() to pre-select values.
                                  // ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ));
                },
              ),
            )
          : const LockRoleWidget(),
    );
  }
}
