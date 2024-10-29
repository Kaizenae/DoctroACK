import 'package:doctor_ack/core/utils/assets_manager.dart';
import 'package:doctor_ack/core/utils/constants_manager.dart';
import 'package:doctor_ack/core/utils/font_manager.dart';
import 'package:doctor_ack/core/utils/routes_manager.dart';
import 'package:doctor_ack/core/utils/styles_manager.dart';
import 'package:doctor_ack/core/widgets/component.dart';
import 'package:doctor_ack/core/widgets/elevated_button/elevated_button_custom.dart';
import 'package:doctor_ack/core/widgets/svg_pic/svg_pic.dart';
import 'package:doctor_ack/languages/locale_keys.g.dart';
import '../../../../../core/utils/packages_imprts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';

import 'package:flutter/material.dart';

class LanguageView extends StatelessWidget {
  const LanguageView({super.key});

  // bool isSelected(BuildContext context) => locale == context.locale;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: AppPadding.p16, right: AppPadding.p20, top: AppPadding.p28),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: TextCustom(
            text: LocaleKeys.language,
            fontSize: FontSize.s18,
            fontWeight: FontWeightManager.semiBold,
          )),
          const RSizedBox.vertical(AppSize.s16),
          _SwitchListTileMenuItem(
              title: 'عربي',
              subtitle: 'عربي',
              locale:
                  context.supportedLocales[1] //BuildContext extension method
              ),
          _SwitchListTileMenuItem(
              title: 'English',
              subtitle: 'English',
              locale: context.supportedLocales[0]),
          const RSizedBox.vertical(AppSize.s16),
          Center(
            child: ElevatedButtonCustom(
              width: AppSize.s100.w * 3,
              radius: AppSize.s50.r,
              text: LocaleKeys.save,
              textStyle: getSemiBoldGilroyStyle(
                color: Colors.white,
                fontSize: FontSize.s16,
                height: 0.09,
              ),
              onPressed: () async {
                navigatorAndRemove(context, Routes.splashRoute);
                // await context
                //     .setLocale(context.locale); //BuildContext extension method
                // SharedPreferences.getInstance().then((val) => val.setBool(
                //     'ARABIC',
                //     context.locale.languageCode == 'ar' ? true : false));
                // SharedPreferences.getInstance().then((val) {
                //   AppConstants.language = val.getBool('ARABIC')!;
                //   print(AppConstants.language);
                // });
                // Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }
}

class _SwitchListTileMenuItem extends StatelessWidget {
  const _SwitchListTileMenuItem({
    required this.title,
    required this.subtitle,
    required this.locale,
  });

  final String title;
  final String subtitle;
  final Locale locale;

  bool isSelected(BuildContext context) => locale == context.locale;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: AppPadding.p12),
      decoration: ShapeDecoration(
        color: ColorManager.white1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s60.r),
        ),
      ),
      child: ListTile(
          dense: true,
          // isThreeLine: true,
          title: TextCustom(
            text: title,
          ),
          trailing: isSelected(context)
              ? const SvgPictureCustom(
                  assetsName: IconAssets.radioCircle,
                  color: null,
                )
              : null,
          // subtitle: TextCustom(
          //   text: subtitle,
          // ),
          onTap: () async {
            await context.setLocale(locale); //BuildContext extension method
            SharedPreferences.getInstance().then((val) => val.setBool(
                'ARABIC', locale.languageCode == 'ar' ? true : false));
            SharedPreferences.getInstance().then((val) {
              AppConstants.language = val.getBool('ARABIC')!;
              AppConstants.languageCode =
                  AppConstants.language ? 'ar_001' : 'en_US';
            });
            // Navigator.pop(context);
          }),
    );
  }
}
