import 'package:doctor_ack/core/controller/firebase_api.dart';
import 'package:doctor_ack/core/utils/font_manager.dart';
import 'package:doctor_ack/core/utils/media_query_values.dart';
import 'package:doctor_ack/core/utils/values_manager.dart';
import 'package:doctor_ack/core/widgets/text_custom/text_custom.dart';
import 'package:doctor_ack/languages/locale_keys.g.dart';
import 'package:doctor_ack/modules/favourite/presentation/screens/favourite_screen.dart';
import 'package:doctor_ack/modules/home/presentation/screens/home_screen.dart';
import 'package:doctor_ack/modules/profile/presentation/screens/profile_screen.dart';
import 'package:doctor_ack/modules/search/presentation/screens/search_screen.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/packages_imprts.dart';
import '../../core/controller/firebase_provider.dart';
import '../../core/utils/assets_manager.dart';
import '../../core/utils/color_manager.dart';
import '../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../../core/widgets/svg_pic/svg_pic.dart';
import '../my_appointment/presentation/screens/my_appointments_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    NotificationListenerProvider().getMessage(context);
    setupFlutterNotifications();
    initFcm();
  }

  final _screens = [
    const HomeScreen(),
    const FavouriteScreen(),
    const SearchScreen(),
    const MyAppointmentsScreen(),
    const ProfileScreen(),
  ];
  List<String> data = [
    IconAssets.home,
    IconAssets.favorite,
    IconAssets.searchNav,
    IconAssets.calendarDates,
    IconAssets.profileIcon,
  ];
  List<String> dataName = [
    LocaleKeys.home,
    LocaleKeys.favorite,
    LocaleKeys.search,
    LocaleKeys.appointmentDate,
    LocaleKeys.profile,
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      left: false,
      right: false,
      child: ScaffoldCustom(
        body: SafeArea(
          child: Stack(
            children: _screens
                .asMap()
                .map((index, screen) {
                  return MapEntry(
                    index,
                    Offstage(
                      offstage: _selectedIndex != index,
                      child: screen,
                    ),
                  );
                })
                .values
                .toList(),
          ),
        ),
        bottomNavigationBar: Material(
          elevation: 10,
          color: const Color(0xff2B2028),
          child: SizedBox(
            height: AppSize.s80.h,
            width: context.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                  5,
                  (i) => InkWell(
                        splashFactory: NoSplash.splashFactory,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          setState(() {
                            _selectedIndex = i;
                          });
                        },
                        child: AnimatedContainer(
                            padding: EdgeInsets.only(bottom: AppPadding.p8),
                            duration: const Duration(milliseconds: 250),
                            // width: context.width,

                            child: SizedBox(
                              height: AppSize.s80,
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                // mainAxisAlignment: MainAxisAlignment.center,

                                children: [
                                  Visibility(
                                    visible: i == _selectedIndex && i != 2,
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: FadeIn(
                                        duration:
                                            const Duration(milliseconds: 250),
                                        child: Column(
                                          children: [
                                            SvgPictureCustom(
                                                assetsName: IconAssets.navIcon,
                                                height: AppSize.s8.h,
                                                width: AppSize.s16.w,
                                                color: const Color(0xffC59C7D)),
                                            SizedBox(
                                              height: AppSize.s4.h,
                                            ),
                                            SvgPictureCustom(
                                                assetsName: IconAssets.navIcon1,
                                                height: AppSize.s4.h,
                                                width: AppSize.s4.w,
                                                color: const Color(0xffC59C7D)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                        i == 2 ? AppSize.s70.h : AppSize.s50.h,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SvgPictureCustom(
                                            assetsName: data[i],
                                            height: i == 2
                                                ? AppSize.s50.h
                                                : AppSize.s24.h,
                                            width: i == 2
                                                ? AppSize.s50.w
                                                : AppSize.s24.w,
                                            color: i == _selectedIndex
                                                ? const Color(0xffC59C7D)
                                                : i == 2
                                                    ? null
                                                    : ColorManager.white),
                                        // SizedBox(height: AppSize.s8.h,),
                                        SizedBox(
                                          width: AppSize.s60.w,
                                          child: TextCustom(
                                            textAlign: TextAlign.center,
                                            text: dataName[i],
                                            maxLines: 1,
                                            color: i == _selectedIndex
                                                ? const Color(0xffC59C7D)
                                                : ColorManager.white,
                                            fontSize: FontSize.s10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )),
                      )),
            ),
          ),
        ),
      ),
    );
  }
}
