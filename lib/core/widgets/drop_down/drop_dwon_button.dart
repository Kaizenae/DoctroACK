import 'package:doctor_ack/core/utils/assets_manager.dart';
import 'package:doctor_ack/core/widgets/svg_pic/svg_pic.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/color_manager.dart';
import '../../utils/font_manager.dart';
import '../../utils/values_manager.dart';
import '../text_custom/text_custom.dart';

class CustomDropdownButton extends StatelessWidget {
  const CustomDropdownButton({
    required this.hint,
    required this.value,
    required this.dropdownItems,
    required this.onChanged,
    required this.onSave,
    this.selectedItemBuilder,
    this.hintAlignment,
    this.valueAlignment,
    this.buttonHeight,
    this.buttonWidth,
    this.buttonPadding,
    this.buttonDecoration,
    this.buttonElevation,
    this.icon,
    this.iconSize,
    this.iconEnabledColor,
    this.iconDisabledColor,
    this.itemHeight,
    this.itemPadding,
    this.dropdownHeight,
    this.dropdownWidth,
    this.dropdownPadding,
    this.dropdownDecoration,
    this.dropdownElevation,
    this.scrollbarRadius,
    this.scrollbarThickness,
    this.scrollbarAlwaysShow,
    this.offset = Offset.zero,
    this.color = ColorManager.white1,
    super.key,
  });

  final String hint;
  final String? value;
  final List<DropdownMenuItem<String>>? dropdownItems;
  final ValueChanged<String?>? onChanged;
  final ValueChanged<String?>? onSave;
  final DropdownButtonBuilder? selectedItemBuilder;
  final Alignment? hintAlignment;
  final Alignment? valueAlignment;
  final double? buttonHeight, buttonWidth;
  final EdgeInsetsGeometry? buttonPadding;
  final BoxDecoration? buttonDecoration;
  final int? buttonElevation;
  final Widget? icon;
  final double? iconSize;
  final Color? iconEnabledColor;
  final Color? iconDisabledColor;
  final double? itemHeight;
  final EdgeInsetsGeometry? itemPadding;
  final double? dropdownHeight, dropdownWidth;
  final EdgeInsetsGeometry? dropdownPadding;
  final BoxDecoration? dropdownDecoration;
  final int? dropdownElevation;
  final Radius? scrollbarRadius;
  final double? scrollbarThickness;
  final bool? scrollbarAlwaysShow;
  final Offset offset;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: dropdownHeight,
      child: DropdownButtonFormField2<String>(
        isExpanded: true,
        decoration: InputDecoration(
          fillColor: color,
          filled: true,
          // Add Horizontal padding using menuItemStyleData.padding so it matches
          // the menu padding when button's width is not specified.
          contentPadding: EdgeInsets.symmetric(vertical: AppPadding.p4),

          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: ColorManager.red),
            borderRadius: BorderRadius.circular(AppSize.s24.r),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: ColorManager.white1),
            borderRadius: BorderRadius.circular(AppSize.s24.r),
          ),

          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: ColorManager.red),
            borderRadius: BorderRadius.circular(AppSize.s24.r),
          ),

          border: OutlineInputBorder(
            borderSide: const BorderSide(color: ColorManager.white1),
            borderRadius: BorderRadius.circular(AppSize.s24.r),
          ),
          // Add more decoration..
        ),
        hint: TextCustom(
          text: hint,
          fontSize: FontSize.s14,
          color: ColorManager.textFormLabelColor,
        ),
        items: dropdownItems,
        validator: (value) {
          if (value == null) {
            return 'Please select Project.';
          }
          return null;
        },
        onChanged: (value) {
          onChanged!(value);
          //Do something when selected item is changed.
        },
        onSaved: (value) {
          onSave!(value);
        },
        buttonStyleData: ButtonStyleData(
          padding: EdgeInsets.only(right: AppPadding.p8),
        ),
        iconStyleData: const IconStyleData(
            icon: SvgPictureCustom(
          assetsName: IconAssets.arrowDownC,
          color: ColorManager.black,
        )),
        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.s14.r),
          ),
        ),
        menuItemStyleData: MenuItemStyleData(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
        ),
      ),
    );
  }
}
