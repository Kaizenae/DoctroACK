import 'package:doctor_ack/core/utils/font_manager.dart';
import 'package:doctor_ack/core/utils/styles_manager.dart';
import 'package:doctor_ack/languages/locale_keys.g.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/packages_imprts.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/app_bar/app_bar_custom.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import '../controller/bloc.dart';
import '../controller/states.dart';

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
      body: BlocProvider(
        create: (context) => NotificationsBLoc()..getNotifications(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              BlocBuilder<NotificationsBLoc, NotificationsStates>(
                  builder: (context, state) {
                return state is NotificationsLoadingState
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : state is NotificationsSuccessState
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: NotificationsBLoc.get(context)
                                .notificationsModel
                                .result
                                .responseModel
                                .responseModel
                                .length,
                            itemBuilder: (context, index) {
                              return NewNotificationWidget(
                                title: NotificationsBLoc.get(context)
                                    .notificationsModel
                                    .result
                                    .responseModel
                                    .responseModel[index]
                                    .title,
                                body: NotificationsBLoc.get(context)
                                    .notificationsModel
                                    .result
                                    .responseModel
                                    .responseModel[index]
                                    .description,
                                date: NotificationsBLoc.get(context)
                                    .notificationsModel
                                    .result
                                    .responseModel
                                    .responseModel[index]
                                    .date,
                                image: NotificationsBLoc.get(context)
                                    .notificationsModel
                                    .result
                                    .responseModel
                                    .responseModel[index]
                                    .image,
                                time: NotificationsBLoc.get(context)
                                    .notificationsModel
                                    .result
                                    .responseModel
                                    .responseModel[index]
                                    .time,
                              );
                            },
                          )
                        : const ErrorsWidget();
              })
            ],
          ),
        ),
      ),
    );
  }
}

class NewNotificationWidget extends StatelessWidget {
  final String? body;
  final String? title;
  final String? date;
  final String image;
  final String time;

  const NewNotificationWidget({
    super.key,
    this.body = '',
    this.title = '',
    this.date = '',
    this.image = "",
    this.time = "",
  });

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
            child: image.isEmpty
                ? Image.asset(
                    ImageAssets.logoIcon1,
                    width: AppSize.s56.h,
                    height: AppSize.s56.h,
                    fit: BoxFit.fill,
                  )
                : Image.network(
                    image,
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
          Column(
            children: [
              TextCustom(
                text: date!,
                textStyle: getMediumGilroyStyle(
                  color: ColorManager.grey,
                  fontSize: FontSize.s10,
                ),
              ),
              RSizedBox.vertical(AppSize.s6.h),
              TextCustom(
                text: time,
                textStyle: getMediumGilroyStyle(
                    color: ColorManager.black,
                    fontSize: FontSize.s10,
                    height: 1.4),
              ),
            ],
          ),
          const RSizedBox.horizontal(AppSize.s10),
        ],
      ),
    );
  }
}
