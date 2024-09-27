import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:doctor_ack/core/utils/media_query_values.dart';
import 'package:doctor_ack/core/widgets/svg_pic/svg_pic.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/assets_manager.dart';
import '../utils/color_manager.dart';
import '../utils/constants_manager.dart';
import '../utils/font_manager.dart';
import '../utils/routes_manager.dart';
import '../utils/styles_manager.dart';
import '../utils/values_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<bool?> showToast(
  BuildContext context, {
  required String message,
  required MessageType type,
}) {
  return Fluttertoast.showToast(
    msg: message.tr(),
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 1,
    backgroundColor: type == MessageType.success
        ? ColorManager.primary
        : type == MessageType.error
            ? ColorManager.red
            : ColorManager.secondary,
    textColor: type == MessageType.success
        ? ColorManager.white
        : type == MessageType.error
            ? ColorManager.white
            : ColorManager.black,
    fontSize: 14.0.sp,
  );
}

Future<bool?> showToast1({
  BuildContext? context,
  required String message,
  required MessageType type,
}) {
  return Fluttertoast.showToast(
    msg: message.tr(),
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 1,
    backgroundColor: type == MessageType.success
        ? ColorManager.primary
        : type == MessageType.error
            ? ColorManager.red
            : ColorManager.secondary,
    textColor: type == MessageType.success
        ? ColorManager.white
        : type == MessageType.error
            ? ColorManager.white
            : ColorManager.black,
    fontSize: 14.0.sp,
  );
}

void navigatorAndRemove(context, String screenName) {
  // GoRouter.of(context). pushReplacement(screenName);
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => RoutesMap.routeMap(screenName),
      ),
      (Route<dynamic> route) => false);
}

void navigator(context, String screenName) {
  // GoRouter.of(context). go(screenName);

  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => RoutesMap.routeMap(screenName),
  ));
}

bottomSheetCustom(
    {required BuildContext context,
    required Widget body,
    double height = AppSize.s100 * 3.5}) {
  return showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return ClipPath(
          clipper: CustomClipPath(),
          child: Container(
            padding: const EdgeInsets.only(top: 6.0),
            height: height,
            decoration: BoxDecoration(
                color: ColorManager.white,
                // borderRadius: BorderRadius.vertical(
                //     bottom: Radius.elliptical(
                //         MediaQuery.of(context).size.width, 100.0)),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppSize.s30.r),
                    topRight: Radius.circular(AppSize.s30.r))),
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(), child: body),
          ),
        );
      });
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = size.height;

    Path path = Path();
    // path.moveTo(0, 100);

    path.lineTo(0, height);
    path.lineTo(width, height);

    path.lineTo(width, 0);

    path.quadraticBezierTo(
      width,
      0,
      width * 0.5,
      height - (height - 10),
    );

    // path.lineTo(0, width);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

dialogCustom({
  required BuildContext context,
  required String okButtonName,
  String? cancelButtonName,
  required Widget body,
  required void Function() pressEventOk,
}) async {
  return AwesomeDialog(
    context: context,
    btnOk: AnimatedButton(
      pressEvent: pressEventOk,
      text: okButtonName,
      buttonTextStyle: getSemiBoldGilroyStyle(
          color: ColorManager.white, fontSize: FontSize.s16, height: 0.9),
    ),
    btnCancel: cancelButtonName != null
        ? AnimatedButton(
            pressEvent: () {
              Navigator.pop(context);
            },
            text: cancelButtonName,
            // boarderColor: ColorManager.grey,
            color: ColorManager.white,

            buttonTextStyle: getSemiBoldGilroyStyle(
                color: ColorManager.grey, fontSize: FontSize.s16, height: 0.9),
          )
        : null,
    animType: AnimType.scale,
    dialogType: DialogType.noHeader,
    padding: EdgeInsets.symmetric(
        vertical: AppPadding.p20, horizontal: AppPadding.p12),
    width: double.infinity,
    dialogBackgroundColor: ColorManager.white,
    showCloseIcon: true,
    closeIcon: Container(
      // margin: EdgeInsets.only(top: AppPadding.p16,right: AppPadding.p16),
      padding: EdgeInsets.all(AppPadding.p8),
      width: AppSize.s30.h,
      height: AppSize.s30.h,
      decoration: const ShapeDecoration(
        color: ColorManager.white1,
        shape: OvalBorder(),
      ),
      child: const SvgPictureCustom(
        assetsName: IconAssets.close,
        color: null,
      ),
    ),
    dialogBorderRadius: BorderRadius.circular(AppSize.s20.r),
    body: body,
  )..show();
}

dialogProgressCustom({
  required BuildContext context,
}) async {
  return AwesomeDialog(
    context: context,
    animType: AnimType.scale,
    dialogType: DialogType.noHeader,
    padding: EdgeInsets.symmetric(
        vertical: AppPadding.p20, horizontal: AppPadding.p20),
    width: context.width / 2,
    dialogBackgroundColor: ColorManager.white,
    showCloseIcon: false,
    alignment: Alignment.center,
    dialogBorderRadius: BorderRadius.circular(AppSize.s20.r),
    body: const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [CircularProgressIndicator()],
    ),
  )..show();
}
