import 'package:doctor_ack/core/widgets/svg_pic/svg_pic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../languages/locale_keys.g.dart';
import '../../modules/webViews/controllers/web_view_cubit.dart';
import '../utils/assets_manager.dart';
import '../utils/constants_manager.dart';
import '../utils/font_manager.dart';
import '../utils/routes_manager.dart';
import '../utils/styles_manager.dart';
import '../utils/values_manager.dart';
import 'component.dart';
import 'text_custom/text_custom.dart';

class RefundWidget extends StatelessWidget {
  const RefundWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        WebViewCubit.get(context).url =
            'https://ahmedemad007.github.io/DoctorAck_Refund/';
        navigator(context, Routes.webViewRoute);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: AppPadding.p20),
        child: Row(
          children: [
            const SvgPictureCustom(assetsName: IconAssets.privacy),
            const RSizedBox.horizontal(AppSize.s4),
            TextCustom(
              text: LocaleKeys.refundPolicy,
              textStyle: getMediumGilroyStyle(
                color: Colors.black,
                fontSize: FontSize.s14,
              ),
            ),
            const Spacer(),
            SvgPictureCustom(
                assetsName: AppConstants.language
                    ? IconAssets.arrowLeftC
                    : IconAssets.arrowRightC),
          ],
        ),
      ),
    );
  }
}
