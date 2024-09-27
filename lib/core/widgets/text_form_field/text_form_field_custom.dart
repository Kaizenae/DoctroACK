import 'package:doctor_ack/core/utils/media_query_values.dart';
import 'package:doctor_ack/core/utils/styles_manager.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../utils/values_manager.dart';
import '../../widgets/svg_pic/svg_pic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/color_manager.dart';

class TextFormFieldCustom extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? Function(String?)? validate;
  final Function(String?)? onSaved;
  final Function()? onEditingComplete;
  final bool obSecure;
  final Widget? prefixIcon;
  final bool prefix;
  final String? suffixIcon;
  final Color? suffixColor;
  final bool suffix;
  final Function? suffixOnPressed;
  final TextInputType? keyboardType;
  final int maxDigit;
  final Function? onChanged;
  final TextInputAction? textInputAction;
  final Function? onTab;
  final FocusNode? focus;
  final TextAlign align;
  final String? initial;
  final bool? enable;
  final double? padding;
  final double? height;
  final double? hintSize;
  final double? radius;
  final int? maxLines;
  final Color? fillColor;
  final Color? boarderColor;

  const TextFormFieldCustom(
      {super.key,
      this.controller,
      this.label,
      this.hint,
      this.obSecure = false,
      this.prefixIcon,
      this.prefix = false,
      this.suffixIcon,
      this.suffixColor = ColorManager.grey,
      this.suffix = false,
      this.suffixOnPressed,
      required this.validate,
      this.keyboardType,
      this.maxDigit = 100,
      this.hintSize = AppSize.s16,
      this.height = AppSize.s50,
      this.onChanged,
      this.textInputAction,
      this.onTab,
      this.onSaved,
      this.onEditingComplete,
      this.focus,
      this.align = TextAlign.start,
      this.initial,
      this.enable,
      this.fillColor = ColorManager.white,
      this.boarderColor = ColorManager.white,
      this.padding = 16.0,
      this.radius = 24.0,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.tablet ? AppSize.s80 : height,
      width: context.tablet ? context.width / 1.5 : context.width,
      decoration: ShapeDecoration(
        // color: fillColor,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius!),
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
        maxLines: maxLines ?? 1,

        textAlignVertical: TextAlignVertical.center,
        textAlign: align,
        focusNode: focus,
        // autofocus: true,
        enabled: enable,
        initialValue: initial,
        controller: controller,
        textInputAction: textInputAction ?? TextInputAction.done,
        onChanged: (value) {
          //onChanged!(value);
          onChanged != null ? onChanged!(value) : null;
        },
        onEditingComplete: onEditingComplete,
        obscureText: obSecure,
        validator: (value) {
          return validate!(value);
        },
        onSaved: onSaved,
        keyboardType: keyboardType,
        cursorColor: ColorManager.primary,
        onTap: () {
          onTab != null ? onTab!() : null;
        },
        inputFormatters: [
          LengthLimitingTextInputFormatter(maxDigit),
        ],
        scrollPhysics: const BouncingScrollPhysics(),
        //maxLength: maxDigit,
        decoration: InputDecoration(
          filled: true,
          fillColor: fillColor,
          isDense: true,
          //floatingLabelBehavior: FloatingLabelBehavior.auto,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius!),
            borderSide: BorderSide(
              color: boarderColor!,
              width: AppSize.s1_5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius!),
            borderSide: const BorderSide(
              color: ColorManager.textFormColor,
              width: AppSize.s1_5,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: padding!,
            horizontal: AppPadding.p16,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius!),
            borderSide: BorderSide(
              color: boarderColor!,
              width: AppSize.s1_5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius!),
            borderSide: const BorderSide(
              color: Colors.red,
              width: AppSize.s1_5,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius!),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
          suffixIconColor: ColorManager.textFormIconColor,
          focusColor: ColorManager.textFormColor,

          prefixIcon: prefix
              ? Padding(
                  padding: EdgeInsets.all(AppPadding.p16),
                  child: prefixIcon,
                )
              : null,
          suffixIcon: suffix
              ? InkWell(
                  onTap: suffixOnPressed != null
                      ? () {
                          suffixOnPressed!();
                          // suffixOnPressed!();
                        }
                      : null,
                  child: Padding(
                    padding: EdgeInsets.all(AppPadding.p16),
                    child: SvgPictureCustom(
                      assetsName: suffixIcon!,
                      color: suffixColor,
                      height: AppSize.s20,
                    ),
                  ),
                )
              : null,
          labelText: label,
          hintText: hint?.tr() ?? '',
          hintStyle: getLightGilroyStyle(
              color: ColorManager.grey, fontSize: hintSize!, height: 0.10),
          labelStyle: const TextStyle(
            color: ColorManager.grey,
            fontSize: AppSize.s16,
          ),
          floatingLabelStyle: const TextStyle(
            color: ColorManager.primary,
            fontSize: AppSize.s16,
          ),
        ),
      ),
    );
  }
}
