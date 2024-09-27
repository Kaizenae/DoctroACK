import 'package:doctor_ack/core/utils/media_query_values.dart';
import 'package:doctor_ack/core/utils/routes_manager.dart';
import 'package:doctor_ack/core/utils/styles_manager.dart';
import 'package:doctor_ack/core/widgets/component.dart';
import 'package:doctor_ack/core/widgets/elevated_button/elevated_button_custom.dart';
import 'package:doctor_ack/core/widgets/error_widget.dart';
import 'package:doctor_ack/core/widgets/scaffold_custom/scaffold_custom.dart';
import 'package:doctor_ack/core/widgets/shimmer_custom/shimmer_horizontal.dart';
import 'package:doctor_ack/languages/locale_keys.g.dart';
import 'package:doctor_ack/vendor_modules/vendor_clinic/presentaion/controllers/bank_cubit/bank_cubit.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/packages_imprts.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/app_bar/app_bar_custom.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../../../edit_clinic/presentation/manager/clinic_cubit.dart';
import '../../../edit_clinic/presentation/manager/clinic_state.dart';

class BankDetails extends StatelessWidget {
  const BankDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
        appBarCustom: const AppBarCustom(
          text: LocaleKeys.bankDetails,
          centerTitle: false,
        ),
        body: SmartRefresher(
          controller: BankCubit.get(context).refreshController,
          onRefresh: () => BankCubit.get(context).getBank(),
          child: Column(
            children: [
              BlocProvider.value(
                value: BlocProvider.of<BankCubit>(context)..getBank(),
                child: BlocBuilder<BankCubit, BankState>(
                  builder: (context, bankState) {
                    var bankCubit = BankCubit.get(context);
                    return switch (bankState) {
                      BankSuccessState() => ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                              bankState.bankEntity.resultEntity.response.length,
                          itemBuilder: (context, index) => Container(
                            padding: EdgeInsets.all(AppPadding.p16),
                            margin: EdgeInsets.all(AppPadding.p16),
                            width: 343,
                            height: 188,
                            decoration: ShapeDecoration(
                              color: ColorManager.white1,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(AppSize.s20),
                              ),
                            ),
                            child: SizedBox(
                              width: context.width - 40,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextCustom(
                                        text: bankState.bankEntity.resultEntity
                                            .response[index].bankName,
                                        textStyle: getRegularGilroyStyle(
                                          color: ColorManager.black,
                                          fontSize: FontSize.s16,
                                        ),
                                      ),
                                      BlocConsumer<EditClinicCubit,
                                          EditClinicState>(
                                        listener: (context, state) {},
                                        builder: (context, state) {
                                          var cubit =
                                              EditClinicCubit.get(context);
                                          return ElevatedButtonCustom(
                                            width: AppSize.s80,
                                            height: AppSize.s30,
                                            fontSize: FontSize.s16,
                                            onPressed: () {
                                              cubit.bankNameController =
                                                  bankState
                                                      .bankEntity
                                                      .resultEntity
                                                      .response[index]
                                                      .bankName;

                                              cubit.accountNumberController
                                                      .text =
                                                  bankState
                                                      .bankEntity
                                                      .resultEntity
                                                      .response[index]
                                                      .holderNumber;
                                              cubit.holderNameController.text =
                                                  bankState
                                                      .bankEntity
                                                      .resultEntity
                                                      .response[index]
                                                      .holderName;
                                              cubit.currencyController =
                                                  bankState
                                                      .bankEntity
                                                      .resultEntity
                                                      .response[index]
                                                      .currency;
                                              navigator(context,
                                                  Routes.editBankRoute);
                                            },
                                            text: LocaleKeys.edit,
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    color: ColorManager.divider,
                                    height: 1,
                                    thickness: 0.2,
                                  ),
                                  SizedBox(
                                    height: AppSize.s10.h,
                                  ),
                                  BankDetailsWidget(
                                      label:
                                          '${LocaleKeys.accountNumber.tr()} :',
                                      value: bankState.bankEntity.resultEntity
                                          .response[index].holderNumber),
                                  SizedBox(
                                    height: AppSize.s4.h,
                                  ),
                                  BankDetailsWidget(
                                      label:
                                          '${LocaleKeys.accountHolderName.tr()} :',
                                      value: bankState.bankEntity.resultEntity
                                          .response[index].holderName),
                                  SizedBox(
                                    height: AppSize.s4.h,
                                  ),
                                  BankDetailsWidget(
                                      label: '${LocaleKeys.currency.tr()} :',
                                      value: bankState.bankEntity.resultEntity
                                          .response[index].currency),
                                  BankDetailsWidget(
                                      label: '${LocaleKeys.iban.tr()} :',
                                      value: bankState.bankEntity.resultEntity
                                          .response[index].iban),
                                ],
                              ),
                            ),
                          ),
                        ),
                      BankErrorState() => ErrorsWidget(
                          onPress: () => bankCubit.getBank(),
                        ),
                      BankLoadingState() => const ShimmerVertical(),
                      _ => const ShimmerVertical(),
                    };
                  },
                ),
              ),
            ],
          ),
        ));
  }
}

class BankDetailsWidget extends StatelessWidget {
  final String label;
  final String value;

  const BankDetailsWidget({
    required this.label,
    required this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextCustom(
          text: label,
          textStyle: getRegularGilroyStyle(
              color: ColorManager.grey, fontSize: FontSize.s14),
        ),
        // SizedBox(width: AppSize.s16.w,),
        TextCustom(
          arabic: false,
          text: value,
          textStyle: getRegularGilroyStyle(
              color: ColorManager.black, fontSize: FontSize.s14),
        ),
      ],
    );
  }
}
