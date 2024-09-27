import 'package:doctor_ack/core/utils/constants_manager.dart';
import 'package:doctor_ack/core/utils/styles_manager.dart';
import 'package:doctor_ack/languages/locale_keys.g.dart';
import 'package:doctor_ack/modules/clinic/presentaion/controllers/payment_cubit/payment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../core/utils/packages_imprts.dart';

import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/font_manager.dart';
import '../../../../core/utils/routes_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/app_bar/app_bar_custom.dart';
import '../../../../core/widgets/component.dart';
import '../../../../core/widgets/elevated_button/elevated_button_custom.dart';
import '../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../../../../core/widgets/svg_pic/svg_pic.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      appBarCustom: const AppBarCustom(
        isNull: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SvgPictureCustom(
                  assetsName: IconAssets.rectangleDone,
                  color: null,
                  height: (AppSize.s100 * 2).h,
                  width: (AppSize.s100 * 2).w,
                ),
                Bounce(
                  child: SvgPictureCustom(
                    assetsName: IconAssets.congratulation,
                    color: null,
                    height: (AppSize.s100 * 2).h,
                    width: (AppSize.s100 * 2).w,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: AppSize.s34.h,
            ),
            TextCustom(
              text: LocaleKeys.congrats,
              fontSize: FontSize.s22,
              fontWeight: FontWeightManager.regular,
            ),
            SizedBox(
              height: AppSize.s6.h,
            ),
            TextCustom(
              text: LocaleKeys.payCongrats,
              textStyle: TextStyle(
                color: ColorManager.grey,
                fontSize: FontSize.s12,
                fontFamily: 'Gilroy-Medium',
                fontWeight: FontWeightManager.medium,
              ),
            ),
            SizedBox(
              height: AppSize.s10.h,
            ),
            TextCustom(
              text: 'Your payment Reference is',
              textStyle: getMediumGilroyStyle(
                color: ColorManager.grey,
                fontSize: FontSize.s12,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextCustom(
                  text: ' ${PaymentCubit.get(context).paymentId}',
                  textStyle: getMediumGilroyStyle(
                    color: ColorManager.primary,
                    fontSize: FontSize.s14,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(
                          text: PaymentCubit.get(context).paymentId));
                      showToast(context,
                          message: 'Copied', type: MessageType.success);
                    },
                    icon: const Icon(Icons.copy_rounded))
              ],
            ),
            const SizedBox(
              height: AppSize.s50,
            ),
            ElevatedButtonCustom(
              radius: AppSize.s50.r,
              text: LocaleKeys.home,
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: FontSize.s18,
                fontFamily: 'Gilroy-SemiBold',
                fontWeight: FontWeightManager.semiBold,
                height: 0.08,
              ),
              onPressed: () {
                navigatorAndRemove(context, Routes.mainRoute);
              },
            )
          ],
        ),
      ),
    );
  }
}
