import 'package:doctor_ack/core/utils/constants_manager.dart';
import 'package:doctor_ack/core/utils/media_query_values.dart';
import 'package:doctor_ack/core/widgets/component.dart';
import 'package:doctor_ack/core/widgets/elevated_button/elevated_button_custom.dart';
import 'package:doctor_ack/core/widgets/lock_role.dart';
import 'package:doctor_ack/core/widgets/scaffold_custom/scaffold_custom.dart';
import 'package:doctor_ack/core/widgets/shimmer_custom/shimmer_custom.dart';
import 'package:doctor_ack/core/widgets/text_form_field/text_form_field_custom.dart';
import 'package:doctor_ack/languages/locale_keys.g.dart';
import 'package:doctor_ack/vendor_modules/edit_clinic/presentation/manager/banks_cubit/banks_cubit.dart';
import 'package:doctor_ack/vendor_modules/edit_clinic/presentation/manager/banks_cubit/banks_state.dart';
import 'package:doctor_ack/vendor_modules/edit_clinic/presentation/manager/edit_bank_cubit/edit_bank_cubit.dart';
import 'package:doctor_ack/vendor_modules/edit_clinic/presentation/manager/edit_bank_cubit/edit_bank_state.dart';
import 'package:doctor_ack/vendor_modules/vendor_clinic/presentaion/controllers/bank_cubit/bank_cubit.dart';
import 'package:flutter/material.dart';
import 'package:doctor_ack/core/widgets/text_custom/text_custom.dart';
import '../../../../../core/utils/packages_imprts.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/styles_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/drop_down/drop_dwon_button.dart';
import '../../../../core/widgets/svg_pic/svg_pic.dart';
import '../../../../injection_container.dart';
import '../manager/clinic_cubit.dart';
import '../manager/clinic_state.dart';

class EditBankScreen extends StatelessWidget {
  const EditBankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      body: AppConstants.role == 'admin' || AppConstants.type == 'clinic'
          ? SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: AppSize.s100.h * 2,
                    child: Stack(
                      // alignment: Alignment.center,
                      children: [
                        Image.asset(
                          ImageAssets.profileRectangle,
                          width: context.width,
                          fit: BoxFit.fill,
                          height: (AppSize.s100 * 1.79).h,
                        ),
                        Positioned(
                          top: AppSize.s60,
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
                                    text: LocaleKeys.editBankDetails,
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
                            top: (AppSize.s100 * 1.6).h,
                            right: context.tablet
                                ? (AppSize.s100 * 2.3).w
                                : AppSize.s16.w,
                            child: Container(
                              color: ColorManager.white,
                              width: (AppSize.s100 * 3.4).w,
                              height: AppSize.s50.h,
                              alignment: Alignment.center,
                            )),
                      ],
                    ),
                  ),
                  BlocConsumer<EditClinicCubit, EditClinicState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      var cubit = EditClinicCubit.get(context);
                      return SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Container(
                          alignment: Alignment.center,
                          // height: (AppSize.s100*2).h,
                          width: context.tablet
                              ? context.width - 40
                              : (AppSize.s100 * 3.4).w,
                          color: ColorManager.white,
                          child: Form(
                            key: cubit.formKeyBank,
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
                                const RSizedBox.vertical(AppSize.s18),
                                BlocProvider(
                                  create: (context) =>
                                      sl<BanksCubit>()..getBanksFun(),
                                  child: BlocBuilder<BanksCubit, BanksState>(
                                    builder: (context, bankState) {
                                      BanksCubit.get(context);
                                      return switch (bankState) {
                                        GetBanksSuccessState() =>
                                          CustomDropdownButton(
                                            dropdownHeight: AppSize.s40,
                                            hint: LocaleKeys.bankName.tr(),
                                            value: '0',
                                            dropdownItems: List.generate(
                                                bankState
                                                    .banksEntity
                                                    .resultEntity
                                                    .response
                                                    .length,
                                                (index) =>
                                                    DropdownMenuItem<String>(
                                                      value: bankState
                                                          .banksEntity
                                                          .resultEntity
                                                          .response[index]
                                                          .id
                                                          .toString(),
                                                      child: TextCustom(
                                                        text: bankState
                                                            .banksEntity
                                                            .resultEntity
                                                            .response[index]
                                                            .name,
                                                        textStyle:
                                                            getSemiBoldGilroyStyle(
                                                          color: ColorManager
                                                              .primary,
                                                          fontSize:
                                                              FontSize.s14,
                                                        ),
                                                      ),
                                                    )),
                                            onChanged: (onChanged) {
                                              cubit.bankNameController =
                                                  onChanged!;
                                            },
                                            onSave: (String? value) {},
                                          ),
                                        GetBanksErrorState() =>
                                          const SizedBox(),
                                        GetBanksLoadingState() => ShimmerCustom(
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
                                const SizedBox(
                                  height: AppSize.s16,
                                ),
                                TextFormFieldCustom(
                                  controller: cubit.holderNameController,
                                  validate: (value) {
                                    if (value!.trim().isEmpty || value == ' ') {
                                      return LocaleKeys
                                          .accountHolderNameTextField
                                          .tr();
                                    }

                                    return null;
                                  },
                                  keyboardType: TextInputType.name,
                                  // suffixIcon: IconAssets.d,
                                  // suffix: true,
                                  prefix: true,
                                  prefixIcon: const SvgPictureCustom(
                                    assetsName: IconAssets.profileOutline,
                                  ),
                                ),
                                const SizedBox(
                                  height: AppSize.s16,
                                ),
                                TextFormFieldCustom(
                                  controller: cubit.accountNumberController,
                                  validate: (value) {
                                    if (value!.trim().isEmpty || value == ' ') {
                                      return LocaleKeys.accountNumberTextField
                                          .tr();
                                    }

                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                  prefix: true,
                                  prefixIcon: const SvgPictureCustom(
                                    assetsName: IconAssets.creditCard,
                                  ), // suffixIcon: IconAssets.d,
                                  // suffix: true,
                                ),
                                const RSizedBox.vertical(AppSize.s70),
                                BlocConsumer<EditBankCubit, EditBankState>(
                                  listener: (context, editBankState) {
                                    if (editBankState is EditBankSuccessState) {
                                      showToast(context,
                                          message:
                                              LocaleKeys.toastEditBank.tr(),
                                          type: MessageType.success);
                                      BankCubit.get(context).getBank();
                                      Navigator.pop(context);
                                    } else if (editBankState
                                        is EditBankErrorState) {
                                      showToast(context,
                                          message: editBankState.message,
                                          type: MessageType.success);
                                    }
                                  },
                                  builder: (context, editBankState) {
                                    var editBankCubit =
                                        EditBankCubit.get(context);
                                    return editBankState is EditBankLoadingState
                                        ? const Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : ElevatedButtonCustom(
                                            onPressed: () {
                                              if (cubit
                                                      .formKeyBank.currentState!
                                                      .validate() ||
                                                  cubit.currencyController
                                                      .isNotEmpty ||
                                                  cubit.bankNameController
                                                      .isNotEmpty) {
                                                editBankCubit.bankId =
                                                    int.parse(cubit
                                                        .bankNameController);
                                                editBankCubit.accountNumber =
                                                    int.parse(cubit
                                                        .accountNumberController
                                                        .text);
                                                editBankCubit.holderName = cubit
                                                    .holderNameController.text;
                                                editBankCubit.editBankFun();
                                                // cubit.editClinicProfile();
                                              }
                                            },
                                            radius: AppSize.s50.r,
                                            text: LocaleKeys.done,
                                            textStyle: getMediumGilroyStyle(
                                                color: ColorManager.white,
                                                fontSize: FontSize.s18,
                                                height: 0.08));
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          : const LockRoleWidget(),
    );
  }
}
