import 'package:doctor_ack/core/utils/styles_manager.dart';
import 'package:doctor_ack/languages/locale_keys.g.dart';
import 'package:doctor_ack/modules/wallet/presentation/cubit/wallet_cubit.dart';
import 'package:doctor_ack/modules/wallet/presentation/cubit/wallet_state.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/packages_imprts.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/app_bar/app_bar_custom.dart';
import '../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      appBarCustom: const AppBarCustom(
        text: LocaleKeys.wallet,
      ),
      body: Padding(
        padding: EdgeInsets.all(AppPadding.p20),
        child: Column(
          children: [
            SizedBox(
              height: AppSize.s100,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    ImageAssets.walletShape,
                    height: AppSize.s100,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextCustom(
                          text: LocaleKeys.yourCredit,
                          textStyle: getSemiBoldGilroyStyle(
                            color: ColorManager.grey,
                            fontSize: FontSize.s12,
                          ),
                        ),
                        // const RSizedBox.vertical(AppSize.s10),
                        BlocProvider.value(
                          value: BlocProvider.of<WalletCubit>(context)
                            ..getWalletFun(),
                          child: BlocBuilder<WalletCubit, WalletState>(
                            builder: (context, state) {
                              return TextCustom(
                                text: state is GetWalletSuccessState
                                    ? '${state.walletEntity.resultEntity.balance} ${LocaleKeys.aED.tr()}'
                                    : '000 ${LocaleKeys.aED.tr()}',
                                textStyle: getSemiBoldGilroyStyle(
                                  color: ColorManager.primary,
                                  fontSize: FontSize.s36,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            // const RSizedBox.vertical(
            //   AppSize.s30,
            // ),
            // TextCustom(
            //   textAlign: TextAlign.center,
            //   text:
            //       'Coupon cards often offer percentages or fixed amounts off the regular price, helping you keep more money in your pocket.',
            //   textStyle: getMediumGilroyStyle(
            //     color: ColorManager.grey,
            //     fontSize: FontSize.s14,
            //   ),
            // ),
            // const RSizedBox.vertical(
            //   AppSize.s100 * 1.39,
            // ),
            // ElevatedButtonCustom(
            //   radius: AppSize.s50,
            //   onPressed: () {},
            //   colors: ColorManager.black,
            //   text: LocaleKeys.addCredit,
            //   textStyle: getMediumGilroyStyle(
            //       color: ColorManager.white, fontSize: FontSize.s16),
            // )
          ],
        ),
      ),
    );
  }
}
