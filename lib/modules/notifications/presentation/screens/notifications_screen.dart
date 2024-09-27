import 'package:doctor_ack/core/controller/notification_cubit/notification_cubit.dart';
import 'package:doctor_ack/core/utils/font_manager.dart';
import 'package:doctor_ack/core/utils/styles_manager.dart';
import 'package:doctor_ack/core/widgets/cached_image/cached_network_image.dart';
import 'package:doctor_ack/core/widgets/empty.dart';
import 'package:doctor_ack/core/widgets/error_widget.dart';
import 'package:doctor_ack/core/widgets/shimmer_custom/shimmer_custom.dart';
import 'package:doctor_ack/languages/locale_keys.g.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/packages_imprts.dart';

import '../../../../core/controller/notification_cubit/notification_state.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/app_bar/app_bar_custom.dart';
import '../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';

// this is notification screen contains all user notifications
class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      // backgroundColor: ColorManager.white1,
      appBarCustom: const AppBarCustom(
        text: LocaleKeys.notifications,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const TextCustom(
            //   text: LocaleKeys.newN,
            //   fontSize: 20,
            //   fontWeight: FontWeight.w600,
            // ),
            // const SizedBox(
            //   height: 15,
            // ),
            // ListView.separated(
            //   shrinkWrap: true,
            //   physics: const NeverScrollableScrollPhysics(),
            //   itemBuilder: (context, index) => newNotification(context),
            //   itemCount: 2,
            //   separatorBuilder: (context, index) => const SizedBox(
            //     height: 10,
            //   ),
            // ),
            // const SizedBox(
            //   height: 15,
            // ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: AppPadding.p14, horizontal: AppPadding.p16),
              child: TextCustom(
                text: LocaleKeys.newest,
                textStyle: getSemiBoldGilroyStyle(
                  color: ColorManager.primary,
                  fontSize: FontSize.s20,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: AppPadding.p14),
              decoration: const BoxDecoration(color: ColorManager.white1),
              child: BlocProvider.value(
                value: BlocProvider.of<NotificationCubit>(context)
                  ..getNotificationItems(),
                child: BlocBuilder<NotificationCubit, NotificationState>(
                  builder: (context, state) {
                    return switch (state) {
                      GetNotificationSuccessState() => state
                              .savedNotificationEntity.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) =>
                                  NewNotificationWidget(
                                title:
                                    state.savedNotificationEntity[index].title,
                                body: state.savedNotificationEntity[index].body,
                                date: state.savedNotificationEntity[index].time,
                              ),
                              itemCount: state.savedNotificationEntity.length,
                            )
                          : const EmptyWidget(title: ''),
                      GetNotificationErrorState() =>
                        ErrorsWidget(text: state.message),
                      GetNotificationLoadingState() => ShimmerCustom(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) =>
                                const NewNotificationWidget(),
                            itemCount: 3,
                          ),
                        ),
                      _ => ShimmerCustom(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) =>
                                const NewNotificationWidget(),
                            itemCount: 3,
                          ),
                        )
                    };
                  },
                ),
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.symmetric(
            //       vertical: AppPadding.p14, horizontal: AppPadding.p16),
            //   child: TextCustom(
            //     text: LocaleKeys.oldest,
            //     textStyle: getSemiBoldGilroyStyle(
            //       color: ColorManager.primary,
            //       fontSize: FontSize.s20,
            //     ),
            //   ),
            // ),
            // ListView.builder(
            //   shrinkWrap: true,
            //   physics: const NeverScrollableScrollPhysics(),
            //   itemBuilder: (context, index) => pastNotification(
            //     context,
            //   ),
            //   itemCount: 9,
            // ),
          ],
        ),
      ),
    );
  }
}

class NewNotificationWidget extends StatelessWidget {
  final String? body;
  final String? title;
  final String? date;

  const NewNotificationWidget(
      {super.key, this.body = '', this.title = '', this.date = ''});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPadding.p4),
      margin: EdgeInsets.only(
          bottom: AppPadding.p10, right: AppPadding.p16, left: AppPadding.p16),
      width: (AppSize.s100 * 3.43).w,
      // height: AppSize.s60.h,
      decoration: ShapeDecoration(
        color: ColorManager.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s40.r),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x7FF7EBE4),
            blurRadius: AppSize.s14,
            offset: Offset(AppSize.s0, AppSize.s4),
            spreadRadius: AppSize.s0,
          )
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSize.s50.r),
            child: Image.asset(
              ImageAssets.logoIcon1,
              width: AppSize.s56.h,
              height: AppSize.s56.h,
              fit: BoxFit.fill,
            ),
          ),
          RSizedBox.horizontal(AppSize.s12.w),
          SizedBox(
            width: (AppSize.s100 * 2).w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextCustom(
                  text: title!,
                  textStyle: getSemiBoldGilroyStyle(
                    color: ColorManager.black,
                    fontSize: FontSize.s12,
                  ),
                ),
                RSizedBox.vertical(AppSize.s6.h),
                TextCustom(
                  text: body!,
                  textStyle: getMediumGilroyStyle(
                      color: ColorManager.black,
                      fontSize: FontSize.s10,
                      height: 1.4),
                ),
              ],
            ),
          ),
          const Spacer(),
          TextCustom(
            text: date!,
            textStyle: getMediumGilroyStyle(
              color: ColorManager.grey,
              fontSize: FontSize.s10,
            ),
          ),
          const RSizedBox.horizontal(AppSize.s10),
        ],
      ),
    );
  }
}

Widget pastNotification(context) {
  return Container(
    padding: EdgeInsets.all(AppPadding.p4),
    margin: EdgeInsets.only(
        bottom: AppPadding.p10, right: AppPadding.p16, left: AppPadding.p16),
    width: (AppSize.s100 * 3.43).w,
    // height: AppSize.s60.h,
    decoration: ShapeDecoration(
      color: ColorManager.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s40.r),
      ),
      shadows: const [
        BoxShadow(
          color: Color(0x7FF7EBE4),
          blurRadius: AppSize.s14,
          offset: Offset(AppSize.s0, AppSize.s4),
          spreadRadius: AppSize.s0,
        )
      ],
    ),
    child: Row(
      children: [
        CachedNetworkImageCustom(
          boarder: AppSize.s50.r,
          url: ImageNetwork.profile1Image,
          width: AppSize.s56.h,
          height: AppSize.s56.h,
          boxFit: BoxFit.fill,
        ),
        RSizedBox.horizontal(AppSize.s12.w),
        SizedBox(
          width: (AppSize.s100 * 1.9).w,
          child: TextCustom(
            text:
                'Your upcoming appointment with Dr. Smith at Healthy Skin Clinic has been confirmed.',
            textStyle: getMediumGilroyStyle(
                color: ColorManager.black, fontSize: FontSize.s10, height: 1.4),
          ),
        ),
        const Spacer(),
        TextCustom(
          text: '25/08/2023',
          textStyle: getMediumGilroyStyle(
            color: ColorManager.grey,
            fontSize: FontSize.s10,
          ),
        ),
        const RSizedBox.horizontal(AppSize.s10),
      ],
    ),
  );
}
