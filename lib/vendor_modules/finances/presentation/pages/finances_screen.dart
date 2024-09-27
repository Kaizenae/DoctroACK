import 'package:doctor_ack/core/utils/media_query_values.dart';
import 'package:doctor_ack/core/utils/routes_manager.dart';
import 'package:doctor_ack/core/utils/styles_manager.dart';
import 'package:doctor_ack/core/widgets/app_bar/app_bar_custom.dart';
import 'package:doctor_ack/core/widgets/component.dart';
import 'package:doctor_ack/core/widgets/lock_role.dart';
import 'package:doctor_ack/core/widgets/scaffold_custom/scaffold_custom.dart';
import 'package:doctor_ack/core/widgets/shimmer_custom/shimmer_custom.dart';
import 'package:doctor_ack/core/widgets/shimmer_custom/shimmer_horizontal.dart';
import 'package:doctor_ack/vendor_modules/finances/presentation/manager/finances_cubit/finances_cubit.dart';
import 'package:doctor_ack/vendor_modules/finances/presentation/manager/finances_cubit/finances_state.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/packages_imprts.dart';

import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/constants_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/svg_pic/svg_pic.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../../../../languages/locale_keys.g.dart';

class FinancesScreen extends StatelessWidget {
  const FinancesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      appBarCustom: const AppBarCustom(
        text: LocaleKeys.finances,
      ),
      body: AppConstants.role == 'admin' || AppConstants.type == 'clinic'
          ? SmartRefresher(
              controller: FinancesCubit.get(context).refreshController,
              onRefresh: () => FinancesCubit.get(context).getFinancesFun(),
              child: Padding(
                padding: EdgeInsets.all(AppPadding.p16),
                child: BlocProvider.value(
                  value: BlocProvider.of<FinancesCubit>(context)
                    ..getFinancesFun(),
                  child: BlocBuilder<FinancesCubit, FinancesState>(
                    builder: (context, state) {
                      return SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            switch (state) {
                              GetFinancesSuccessState() => SlideInRight(
                                  child: SizedBox(
                                    height: AppSize.s70,
                                    child: Row(
                                      children: [
                                        const SvgPictureCustom(
                                          assetsName: IconAssets.payout,
                                          height: AppSize.s30,
                                        ),
                                        const SizedBox(
                                          width: AppSize.s18,
                                        ),
                                        TextCustom(
                                          text: LocaleKeys.nextPayoutDate,
                                          textStyle: getRegularGilroyStyle(
                                              color: ColorManager.black,
                                              fontSize: FontSize.s20),
                                        ),
                                        const Spacer(),
                                        Container(
                                          width: AppSize.s80.w + 8,
                                          height: AppSize.s60.h - 4,
                                          padding: EdgeInsets.only(
                                              right: AppPadding.p14,
                                              left: AppPadding.p14,
                                              top: AppPadding.p8,
                                              bottom: AppPadding.p4),
                                          decoration: ShapeDecoration(
                                            color: const Color(0xFFADCCCC),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppSize.s12.r),
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Flexible(
                                                child: TextCustom(
                                                  text: DateFormat(
                                                          'dMMM',
                                                          AppConstants.language
                                                              ? 'ar'
                                                              : 'en')
                                                      .format(DateTime.parse(
                                                          state
                                                              .financesEntity
                                                              .resultEntity
                                                              .response
                                                              .nextPayoutDate)),
                                                  textStyle:
                                                      getRegularGilroyStyle(
                                                          color: ColorManager
                                                              .black,
                                                          fontSize:
                                                              FontSize.s18),
                                                ),
                                              ),
                                              TextCustom(
                                                text: DateFormat(
                                                        'y',
                                                        AppConstants.language
                                                            ? 'ar'
                                                            : 'en')
                                                    .format(DateTime.now()),
                                                textStyle:
                                                    getRegularGilroyStyle(
                                                        color:
                                                            ColorManager.black,
                                                        fontSize: FontSize.s14),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              GetFinancesErrorState() => const SizedBox(),
                              GetFinancesLoadingState() => ShimmerCustom(
                                    child: SizedBox(
                                  height: AppSize.s70,
                                  child: Row(
                                    children: [
                                      const SvgPictureCustom(
                                        assetsName: IconAssets.payout,
                                        height: AppSize.s30,
                                      ),
                                      const SizedBox(
                                        width: AppSize.s18,
                                      ),
                                      TextCustom(
                                        text: LocaleKeys.nextPayoutDate,
                                        textStyle: getRegularGilroyStyle(
                                            color: ColorManager.black,
                                            fontSize: FontSize.s20),
                                      ),
                                      const Spacer(),
                                      Container(
                                        width: AppSize.s80.w + 8,
                                        height: AppSize.s60.h - 4,
                                        padding: EdgeInsets.only(
                                            right: AppPadding.p14,
                                            left: AppPadding.p14,
                                            top: AppPadding.p8,
                                            bottom: AppPadding.p4),
                                        decoration: ShapeDecoration(
                                          color: const Color(0xFFADCCCC),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                AppSize.s12.r),
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            TextCustom(
                                              text: DateFormat(
                                                      'dMMM',
                                                      AppConstants.language
                                                          ? 'ar'
                                                          : 'en')
                                                  .format(DateTime.now()),
                                              textStyle: getRegularGilroyStyle(
                                                  color: ColorManager.black,
                                                  fontSize: FontSize.s18),
                                            ),
                                            TextCustom(
                                              text: DateFormat(
                                                      'y',
                                                      AppConstants.language
                                                          ? 'ar'
                                                          : 'en')
                                                  .format(DateTime.now()),
                                              textStyle: getRegularGilroyStyle(
                                                  color: ColorManager.black,
                                                  fontSize: FontSize.s14),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                              _ => const SizedBox(),
                            },

                            // Container(
                            //   width: 343,
                            //   height: 48,
                            //   alignment: Alignment.center,
                            //   decoration: ShapeDecoration(
                            //     color: ColorManager.black,
                            //     shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(AppSize.s10),
                            //     ),
                            //   ),
                            //   child: TextCustom(
                            //     text: '${LocaleKeys.totalBreakdown.tr()} : 06',
                            //     textStyle: getMediumGilroyStyle(
                            //       color: Colors.white,
                            //       fontSize: FontSize.s18,
                            //       height: 0.06,
                            //     ),
                            //   ),
                            // ),
                            const RSizedBox.vertical(AppSize.s20),
                            TextCustom(
                              text: LocaleKeys.invoices,
                              textStyle: getMediumGilroyStyle(
                                color: ColorManager.black2,
                                fontSize: FontSize.s18,
                                height: 0.07,
                              ),
                            ),
                            const RSizedBox.vertical(AppSize.s14),
                            switch (state) {
                              GetFinancesSuccessState() => SizedBox(
                                  width: context.width - 34,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) =>
                                        InvoicesWidget(
                                            date:
                                                state
                                                    .financesEntity
                                                    .resultEntity
                                                    .response
                                                    .financeEntity[index]
                                                    .date,
                                            amount:
                                                state
                                                    .financesEntity
                                                    .resultEntity
                                                    .response
                                                    .financeEntity[index]
                                                    .amount,
                                            paymentId:
                                                state
                                                    .financesEntity
                                                    .resultEntity
                                                    .response
                                                    .financeEntity[index]
                                                    .paymentId,
                                            paymentName:
                                                state
                                                    .financesEntity
                                                    .resultEntity
                                                    .response
                                                    .financeEntity[index]
                                                    .paymentName,
                                            pdf: state
                                                .financesEntity
                                                .resultEntity
                                                .response
                                                .financeEntity[index]
                                                .pdf,
                                            index: index),
                                    itemCount: state.financesEntity.resultEntity
                                        .response.financeEntity.length,
                                  ),
                                ),
                              GetFinancesErrorState() => const SizedBox(),
                              GetFinancesLoadingState() =>
                                const ShimmerVertical(),
                              _ => const SizedBox(),
                            },
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            )
          : const LockRoleWidget(),
    );
  }
}

class InvoicesWidget extends StatelessWidget {
  final int index;
  final int paymentId;
  final String paymentName;
  final double amount;
  final String date;
  final String pdf;

  const InvoicesWidget(
      {required this.index,
      required this.paymentId,
      required this.paymentName,
      required this.amount,
      required this.date,
      required this.pdf,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343,
      height: 74,
      padding: EdgeInsets.all(AppPadding.p12),
      margin: EdgeInsets.symmetric(vertical: AppPadding.p8),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 0.30, color: Color(0x3380797E)),
          borderRadius: BorderRadius.circular(20),
        ),
        shadows: const [
          BoxShadow(
            color: ColorManager.white1,
            blurRadius: 15,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: InkWell(
        onTap: () {
          FinancesCubit.get(context).pdf = pdf;
          FinancesCubit.get(context).paymentName = paymentName;
          navigator(context, Routes.pdfRoute);
          // HelperFunctions.imageConverter(pdf);
        },
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              padding: EdgeInsets.all(AppPadding.p8),
              decoration: const ShapeDecoration(
                color: Color(0xFFFFFAEE),
                shape: OvalBorder(),
              ),
              child: const SvgPictureCustom(
                assetsName: IconAssets.fileDocument,
                color: Color(0xFFD4C6A1),
              ),
            ),
            const RSizedBox.horizontal(AppSize.s14),
            SizedBox(
              width: 235,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextCustom(
                        text: paymentName,
                        textStyle: getRegularGilroyStyle(
                          color: ColorManager.black,
                          fontSize: FontSize.s16,
                        ),
                      ),
                      TextCustom(
                        text: date,
                        textStyle: getRegularGilroyStyle(
                          color: ColorManager.grey,
                          fontSize: FontSize.s12,
                        ),
                      ),
                    ],
                  ),
                  const RSizedBox.vertical(AppSize.s6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextCustom(
                        text: '$amount ${LocaleKeys.aED.tr()}',
                        textStyle: getRegularGilroyStyle(
                          color: ColorManager.grey,
                          fontSize: FontSize.s12,
                        ),
                      ),
                      // Container(
                      //   width: 79,
                      //   height: 23,
                      //   alignment: Alignment.center,
                      //   decoration: ShapeDecoration(
                      //     color: const Color(0x19D1283B),
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(20),
                      //     ),
                      //   ),
                      //   child: TextCustom(
                      //     text: index % 2 == 0
                      //         ? LocaleKeys.pending
                      //         : LocaleKeys.paid,
                      //     textStyle: getRegularGilroyStyle(
                      //       color: index % 2 == 0
                      //           ? ColorManager.red
                      //           : ColorManager.green1,
                      //       fontSize: FontSize.s12,
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
