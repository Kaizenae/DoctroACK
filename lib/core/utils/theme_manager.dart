import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'color_manager.dart';
import 'font_manager.dart';
import 'styles_manager.dart';
import 'values_manager.dart';

class Style {
  ThemeData getApplicationTheme() {
    return ThemeData(
      useMaterial3: true,
      // main colors
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      colorSchemeSeed: ColorManager.primary,
      brightness: Brightness.light,
      scaffoldBackgroundColor: ColorManager.scaffoldColor,
      // primaryColor:  ColorManager.primary,
      // // primaryColorLight: ColorManager.lightPrimary,
      // // primaryColorDark: ColorManager.darkPrimary,
      // disabledColor: ColorManager.grey1,
      // splashColor: ColorManager.lightPrimary,
      // ripple effect color
      // cardview theme
      cardTheme: const CardTheme(
          color: ColorManager.white,
          shadowColor: ColorManager.grey,
          elevation: AppSize.s4),
      // app bar theme
      appBarTheme: AppBarTheme(
          centerTitle: true,
          color: ColorManager.scaffoldColor,
          surfaceTintColor: ColorManager.white,
          elevation: AppSize.s0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: ColorManager.scaffoldColor,
          ),
          // shadowColor: ColorManager.lightPrimary,
          titleTextStyle: getRegularStyle(
              fontSize: FontSize.s16, color: ColorManager.white)),

      // scaffoldBackgroundColor: ColorManager.scaffoldColor,
      // button theme
      buttonTheme: const ButtonThemeData(
        shape: StadiumBorder(),
        disabledColor: ColorManager.grey1,
        buttonColor: ColorManager.primary,
        // splashColor: ColorManager.lightPrimary,
      ),

      // elevated button them
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              textStyle: getRegularStyle(
                  color: ColorManager.white, fontSize: FontSize.s17),
              backgroundColor: ColorManager.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s12)))),

      textTheme: TextTheme(
          displayLarge: getSemiBoldStyle(
              color: ColorManager.darkGrey, fontSize: FontSize.s20),
          headlineLarge: getSemiBoldStyle(
              color: ColorManager.white, fontSize: FontSize.s16),
          headlineMedium:
              getRegularStyle(color: ColorManager.grey, fontSize: FontSize.s14),
          titleMedium: getMediumStyle(
              color: ColorManager.primary, fontSize: FontSize.s16),
          bodyLarge: getRegularStyle(color: ColorManager.grey1),
          bodySmall: getRegularStyle(color: ColorManager.grey)),

      // input decoration theme (text form field)
      inputDecorationTheme: InputDecorationTheme(
          // content padding
          contentPadding: EdgeInsets.all(AppPadding.p8),
          // hint style
          hintStyle:
              getRegularStyle(color: ColorManager.grey, fontSize: FontSize.s14),
          labelStyle:
              getMediumStyle(color: ColorManager.grey, fontSize: FontSize.s14),
          errorStyle: getRegularStyle(color: ColorManager.error),

          // enabled border style
          enabledBorder: const OutlineInputBorder(
              borderSide:
                  BorderSide(color: ColorManager.grey, width: AppSize.s1_5),
              borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),

          // focused border style
          focusedBorder: const OutlineInputBorder(
              borderSide:
                  BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
              borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),

          // error border style
          errorBorder: const OutlineInputBorder(
              borderSide:
                  BorderSide(color: ColorManager.error, width: AppSize.s1_5),
              borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),
          // focused border style
          focusedErrorBorder: const OutlineInputBorder(
              borderSide:
                  BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
              borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)))),
      // label style
    );
  }
}
