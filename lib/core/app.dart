// ignore_for_file: deprecated_member_use

import 'package:device_preview/device_preview.dart';
import 'package:doctor_ack/core/controller/notification_cubit/notification_cubit.dart';
import 'package:doctor_ack/core/general_controllers/location_controller/location_cubit.dart';
import 'package:doctor_ack/core/utils/color_manager.dart';
import 'package:doctor_ack/core/utils/media_query_values.dart';
import 'package:doctor_ack/core/utils/routes_manager.dart';
import 'package:doctor_ack/core/utils/strings_manager.dart';
import 'package:doctor_ack/injection_imports.dart';
import 'package:doctor_ack/modules/clinic/presentaion/controllers/check_payment_cubit/check_payment_cubit.dart';
import 'package:doctor_ack/modules/clinic/presentaion/controllers/payment_cubit/payment_cubit.dart';
import 'package:doctor_ack/modules/favourite/presentation/controllers/toggle_cubit/toggle_cubit.dart';
import 'package:doctor_ack/modules/reviews/presentation/manager/controllers/reviews_cubit/reviews_cubit.dart';
// import 'package:doctor_ack/modules/user/presentation/controllers/users_cubit/users_cubit.dart';
import 'package:doctor_ack/modules/webViews/controllers/web_view_cubit.dart';
import 'package:doctor_ack/vendor_modules/advanced_reports/presentation/manager/filters_sorts_cubit/filters_sorts_cubit.dart';
import 'package:doctor_ack/vendor_modules/edit_clinic/presentation/manager/states_cubit/states_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../injection_container.dart';
import '../modules/all_services/presentation/controllers/all_clinics_cubit/all_services_cubit.dart';
import '../modules/search/presentation/controllers/locale_search_cubit/local_search_cubit.dart';
import '../modules/user/presentation/controllers/users_cubit/users_cubit.dart';
import 'controller/theme_controller/theme_cubit.dart';
import 'controller/theme_controller/theme_state.dart';
import 'utils/theme_manager.dart';

final navigatorkey = GlobalKey<NavigatorState>();

class DoctorAckApp extends StatefulWidget {
  const DoctorAckApp({super.key});

  @override
  State<DoctorAckApp> createState() => _DoctorAckAppState();
}

class _DoctorAckAppState extends State<DoctorAckApp> {
  @override
  void initState() {
    super.initState();
    // initFcm();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => PaymentCubit()),
        BlocProvider(create: (context) => ToggleCubit()),
        BlocProvider(create: (context) => NotificationCubit()),
        BlocProvider(create: (context) => LocalSearchCubit()..initDatabase()),
        BlocProvider(create: (context) => sl<CheckPaymentCubit>()),
        BlocProvider(create: (context) => sl<UsersCubit>()),
        BlocProvider(create: (context) => sl<GetCategoriesCubit>()),
        BlocProvider(create: (context) => sl<ClinicCubit>()),
        BlocProvider(create: (context) => sl<ReviewsCubit>()),
        BlocProvider(create: (context) => sl<CreateReviewsCubit>()),
        BlocProvider(create: (context) => sl<ClinicServicesCubit>()),
        BlocProvider(create: (context) => sl<ServiceCubit>()),
        BlocProvider(create: (context) => sl<AvailableTimesCubit>()),
        BlocProvider(create: (context) => sl<CreateReservationOrderCubit>()),
        BlocProvider(create: (context) => LocationCubit()..getLocation()),
        BlocProvider(create: (context) => sl<ProfileCubit>()),
        BlocProvider(create: (context) => sl<ServiceCubit>()),
        BlocProvider(create: (context) => sl<OfferCubit>()),
        BlocProvider(
            create: (context) => sl<AllClinicsCubit>()..getAllClinics()),
        BlocProvider(
            create: (context) => sl<AllServicesCubit>()..getAllServices()),
        BlocProvider(create: (context) => sl<LoginCubit>()),
        BlocProvider(create: (context) => sl<RegisterCubit>()),
        BlocProvider(create: (context) => sl<ForgetPasswordCubit>()),
        BlocProvider(create: (context) => sl<ChangePasswordCubit>()),
        BlocProvider(create: (context) => sl<EditProfileCubit>()),
        BlocProvider(create: (context) => sl<WalletCubit>()),
        BlocProvider(create: (context) => sl<ContactUsCubit>()),
        BlocProvider(create: (context) => sl<FavouritesCubit>()),
        BlocProvider(create: (context) => sl<AddRemoveFavouritesCubit>()),
        BlocProvider(create: (context) => sl<MyAppointmentsCubit>()),
        BlocProvider(create: (context) => sl<AppointmentCubit>()),
        BlocProvider(create: (context) => sl<CancelChangeAppointmentsCubit>()),
        // BlocProvider(create: (context) => sl<SearchServicesCubit>()),
        BlocProvider(create: (context) => sl<EditClinicCubit>()),
        BlocProvider(create: (context) => sl<ServicesCubit>()),
        BlocProvider(create: (context) => sl<VendorClinicCubit>()),
        BlocProvider(create: (context) => sl<BankCubit>()),
        BlocProvider(create: (context) => sl<UserManagementCubit>()),
        BlocProvider(create: (context) => sl<ChangeUserRoleCubit>()),
        BlocProvider(create: (context) => sl<CustomersCubit>()),
        BlocProvider(create: (context) => sl<BlockTimeCubit>()),
        BlocProvider(create: (context) => sl<FinancesCubit>()),
        BlocProvider(create: (context) => sl<SalesCubit>()),
        BlocProvider(create: (context) => sl<CurrencyCubit>()),
        BlocProvider(create: (context) => sl<BanksCubit>()),
        BlocProvider(create: (context) => sl<EditBankCubit>()),
        BlocProvider(create: (context) => sl<AppointmentsCubit>()),
        BlocProvider(create: (context) => sl<AdvancedSalesCubit>()),
        BlocProvider(create: (context) => sl<AdvancedCustomersCubit>()),
        BlocProvider(create: (context) => sl<TopServicesCubit>()),
        BlocProvider(create: (context) => sl<TagsCubit>()),
        BlocProvider(create: (context) => sl<StatesCubit>()),
        BlocProvider(create: (context) => FiltersSortsCubit()),
        BlocProvider(create: (context) => WebViewCubit()),
      ],
      child: BlocConsumer<ThemeCubit, ThemeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return ScreenUtilInit(
            designSize: Size(context.width, context.height),
            ensureScreenSize: true,
            // minTextAdapt: true,
            // splitScreenMode: true,
            builder: (context, child) => RefreshConfiguration(
              headerBuilder: () => const ClassicHeader(
                  refreshingIcon: CupertinoActivityIndicator(
                color: ColorManager.primary,
              )),
              child: MaterialApp(
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                title: AppStrings.appName.tr(),
                builder: (context, widget) {
                  return MediaQuery(
                    //Setting font does not change with system font size
                    data: MediaQuery.of(context)
                        .copyWith(textScaler: const TextScaler.linear(1.0)),
                    child: widget!,
                  );
                },
                navigatorKey: navigatorkey,
                routes: RoutesMap.routesMap(),
                initialRoute: Routes.splashRoute,
                debugShowCheckedModeBanner: false,
                theme: Style().getApplicationTheme(),
              ),
            ),
          );
        },
      ),
    );
  }
}
