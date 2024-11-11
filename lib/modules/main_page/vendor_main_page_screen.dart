import 'package:doctor_ack/core/utils/media_query_values.dart';
import 'package:doctor_ack/modules/all_services/presentation/controllers/all_clinics_cubit/all_services_cubit.dart';
import 'package:doctor_ack/vendor_modules/advanced_reports/presentation/pages/advanced_reports.dart';
import 'package:doctor_ack/vendor_modules/home/presentation/screens/home_screen.dart';
import 'package:doctor_ack/vendor_modules/vendor_clinic/presentaion/controllers/clinic_profile_cubit/clinic_profile_cubit.dart';
import 'package:doctor_ack/vendor_modules/vendor_clinic/presentaion/screens/vendor_clinic_screen.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/packages_imprts.dart';
// import '../../core/controller/firebase_api.dart';
// import '../../core/controller/firebase_provider.dart';
import '../../core/utils/assets_manager.dart';
import '../../core/utils/color_manager.dart';
import '../../core/utils/constants_manager.dart';
import '../../core/utils/font_manager.dart';
import '../../core/utils/values_manager.dart';
import '../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../../core/widgets/svg_pic/svg_pic.dart';
import '../../core/widgets/text_custom/text_custom.dart';
import '../../languages/locale_keys.g.dart';
import '../../vendor_modules/services/presentation/pages/services_screen.dart';
import '../search/presentation/screens/search_screen.dart';

class VendorMainPage extends StatefulWidget {
  const VendorMainPage({super.key});

  @override
  State<VendorMainPage> createState() => _VendorMainPageState();
}

class _VendorMainPageState extends State<VendorMainPage> {
  @override
  void initState() {
    super.initState();
    // NotificationListenerProvider().getMessage(context);
    // setupFlutterNotifications();
    // initFcm();
  }

  final _screens = [
    const VendorHomeScreen(),
    const VendorServicesScreen(),
    const SearchScreen(),
    const AdvancedReports(),
    const VendorClinicScreen(),
  ];
  List<String> data = [
    IconAssets.home,
    IconAssets.serviceActive,
    IconAssets.searchNav,
    IconAssets.calendarDates,
    IconAssets.profileIcon,
  ];
  List<String> dataName = [
    LocaleKeys.home,
    LocaleKeys.services,
    LocaleKeys.search,
    LocaleKeys.advancedReports,
    LocaleKeys.profile,
  ];

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
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
          height: AppSize.s80,
          width: context.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
                5,
                (i) => BlocBuilder<VendorClinicCubit, ClinicProfileState>(
                      builder: (context, state) {
                        return InkWell(
                          splashFactory: NoSplash.splashFactory,
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            setState(() {
                              _selectedIndex = i;
                            });
                            if (_selectedIndex == 1 &&
                                state is ClinicProfileSuccessState) {
                              AllServicesCubit.get(context).clinicId =
                                  AppConstants.cachedId != 0
                                      ? AppConstants.cachedId
                                      : state.clinicProfileEntity.resultEntity
                                          .response.id;
                              AllServicesCubit.get(context).getAllServices();
                            }
                          },
                          child: AnimatedContainer(
                              padding: EdgeInsets.only(bottom: AppPadding.p8),
                              duration: const Duration(milliseconds: 250),
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
                                                  assetsName:
                                                      IconAssets.navIcon,
                                                  height: AppSize.s8.h,
                                                  width: AppSize.s16.w,
                                                  color:
                                                      const Color(0xffC59C7D)),
                                              SizedBox(
                                                height: AppSize.s4.h,
                                              ),
                                              SvgPictureCustom(
                                                  assetsName:
                                                      IconAssets.navIcon1,
                                                  height: AppSize.s4.h,
                                                  width: AppSize.s4.w,
                                                  color:
                                                      const Color(0xffC59C7D)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: i == 2
                                          ? AppSize.s70.h
                                          : AppSize.s50.h,
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
                                              fontSize: FontSize.s12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )),
                        );
                      },
                    )),
          ),
        ),
      ),
    );
  }
}
