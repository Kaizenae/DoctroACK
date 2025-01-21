import 'package:doctor_ack/core/utils/strings_manager.dart';
import 'package:doctor_ack/modules/all_clinics/presentation/screens/all_clinics_screen.dart';
import 'package:doctor_ack/modules/all_services/presentation/screens/all_services_screen.dart';
import 'package:doctor_ack/modules/categories/presentation/screens/categories_screen.dart';
import 'package:doctor_ack/modules/change_password/presentation/screens/change_password_screen.dart';
import 'package:doctor_ack/modules/clinic/presentaion/screens/clinic_screen.dart';
import 'package:doctor_ack/modules/clinic/presentaion/screens/schedule_screen.dart';
import 'package:doctor_ack/modules/coupon/presentation/screens/coupons_screen.dart';
import 'package:doctor_ack/modules/edit_profile/presentation/screens/edit_profile_screen.dart';
import 'package:doctor_ack/modules/favourite/presentation/screens/favourite_screen.dart';
import 'package:doctor_ack/modules/help_and_feedback/presentation/screens/help_and_feedback_screen.dart';
import 'package:doctor_ack/modules/main_page/main_page_screen.dart';
import 'package:doctor_ack/modules/notifications/presentation/screens/notifications_screen.dart';
import 'package:doctor_ack/modules/payments/presentation/screens/payment_success_screen.dart';
import 'package:doctor_ack/modules/profile/presentation/screens/profile_screen.dart';
import 'package:doctor_ack/modules/reviews/presentation/screens/reviews_screen.dart';
import 'package:doctor_ack/modules/search/presentation/screens/search_screen.dart';
import 'package:doctor_ack/modules/service/presentation/pages/service_screen.dart';
import 'package:doctor_ack/modules/splash/screens/splash_screen.dart';
import 'package:doctor_ack/modules/wallet/presentation/screens/wallet_screen.dart';
import 'package:doctor_ack/vendor_modules/advanced_reports/presentation/pages/advanced_reports.dart';
import 'package:doctor_ack/vendor_modules/home/presentation/screens/calendar_screen.dart';
import 'package:doctor_ack/vendor_modules/home/presentation/screens/home_screen.dart';
import 'package:doctor_ack/vendor_modules/services/presentation/pages/edit_service_screen.dart';
import 'package:doctor_ack/vendor_modules/services/presentation/pages/services_screen.dart';
import 'package:doctor_ack/vendor_modules/vendor_clinic/presentaion/screens/vendor_clinic_screen.dart';
import 'package:doctor_ack/vendor_modules/vendor_reviews/presentation/screens/vendor_reviews_screen.dart';
import 'package:flutter/material.dart';

import '../../modules/forget_password/presentation/screens/success_screen.dart';
import '../../modules/main_page/vendor_main_page_screen.dart';
import '../../modules/my_appointment/presentation/screens/my_appointments_screen.dart';
import '../../modules/my_appointment/presentation/widgets/appointment_service_screen.dart';
import '../../modules/privacy/presentation/pages/privacy_screen.dart';
import '../../modules/special_offers/presentation/pages/SpecialOffersScreen.dart';
import '../../modules/webViews/webView_screen.dart';
import '../../vendor_modules/about_us/presentation/pages/vendor_about_us.dart';
import '../../vendor_modules/edit_clinic/presentation/pages/edit_bank_screen.dart';
import '../../vendor_modules/edit_clinic/presentation/pages/edit_clinic_screen.dart';
import '../../vendor_modules/finances/presentation/pages/finances_screen.dart';
import '../../vendor_modules/finances/presentation/pages/pdf_screen.dart';
import '../../vendor_modules/services/presentation/pages/service_screen.dart';
import '../../vendor_modules/users_management/presentation/pages/user_management_screen.dart';
import '../../vendor_modules/vendor_clinic/presentaion/widgets/bank_details.dart';
import '../widgets/app_bar/app_bar_custom.dart';
import '../../modules/forget_password/presentation/screens/forget_password_screen.dart';
import '../../modules/forget_password/presentation/screens/new_password_screen.dart';
import '../../modules/login/presentation/screens/login_screen.dart';
import '../../modules/register/presentation/screens/register_screen.dart';
import '../widgets/scaffold_custom/scaffold_custom.dart';
import '../widgets/text_custom/text_custom.dart';

class Routes {
  // static const String splashRoute = "";
  // static const String splash = "";
  static const String onBoarding = "onBoarding";
  static const String loginRoute = "login";
  static const String splashRoute = "/";
  static const String registerRoute = "register";
  static const String forgetPasswordRoute = "forgetPasswordScreen";
  static const String newPasswordRoute = "newPasswordScreen";
  static const String successRoute = "successScreen";
  static const String mainRoute = "mainRoute";
  static const String vendorMainRoute = "vendorMainRoute";
  static const String vendorHomeRoute = "vendorHomeRoute";
  static const String allClinicsScreen = "allClinicsScreen";
  static const String allServicesScreen = "allServicesScreen";
  static const String categoriesScreen = "categoriesScreen";
  static const String profileRoute = "profileRoute";
  static const String walletRoute = "walletRoute";
  static const String couponsRoute = "couponsRoute";
  static const String clinicRoute = "clinicRoute";
  static const String serviceClinicRoute = "serviceClinicRoute";
  static const String clinicReviewsRoute = "clinicReviewsRoute";
  static const String scheduleRoute = "scheduleRoute";
  static const String paymentMethodsRoute = "paymentMethodsRoute";
  static const String paymentSuccessRoute = "paymentSuccessRoute";
  static const String contactUsRoute = "contactUsRoute";
  static const String searchRoute = "searchRoute";
  static const String editProfileRoute = "editProfileRoute";
  static const String editUserNameRoute = "editUserNameRoute";
  static const String editPhoneNumberRoute = "editPhoneNumberRoute";
  static const String changePasswordRoute = "changePasswordRoute";
  static const String notificationsRoute = "notificationsRoute";
  static const String favoritesRoute = "favoritesRoute";
  static const String myAppointmentsRoute = "MyAppointmentsRoute";
  static const String myAppointmentServiceRoute = "MyAppointmentServiceRoute";
  static const String specialOffersRoute = "specialOffersRoute";
  static const String privacyRoute = "privacyRoute";
  static const String webViewRoute = "webViewRoute";

  //********************************************/ Vendor Module \**********************************************
  static const String advancedReportsRoute = "advancedReportsRoute";
  static const String servicesRoute = "servicesRoute";
  static const String serviceRoute = "serviceRoute";
  static const String editServiceRoute = "editServiceRoute";
  static const String editClinicRoute = "editClinicRoute";
  static const String vendorReviewsRoute = "vendorReviewsRoute";
  static const String vendorClinicRoute = "vendorClinicRoute";
  static const String userManagementRoute = "userManagementRoute";
  static const String editBankRoute = "editBankRoute";
  static const String bankRoute = "bankRoute";
  static const String financesRoute = "financesRoute";
  static const String aboutUSRoute = "aboutUSRoute";
  static const String calendarRoute = "calendarRoute";
  static const String pdfRoute = "PdfScreen";

  static Route createRoute(String screen) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          RoutesMap.routeMap(screen),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}

class RoutesMap {
  static Map<String, Widget Function(BuildContext)> routesMap() {
    return {
      Routes.loginRoute: (BuildContext context) => const LoginScreen(),
      Routes.splashRoute: (BuildContext context) => const SplashScreen(),
      Routes.registerRoute: (BuildContext context) => const RegisterScreen(),
      Routes.forgetPasswordRoute: (BuildContext context) =>
          const ForgetPasswordScreen(),

      Routes.newPasswordRoute: (BuildContext context) =>
          const NewPasswordScreen(),
      Routes.successRoute: (BuildContext context) => const SuccessScreen(),
      Routes.mainRoute: (BuildContext context) => const MainPage(),
      Routes.allClinicsScreen: (BuildContext context) =>
          const AllClinicsScreen(),
      Routes.allServicesScreen: (BuildContext context) =>
          const AllServicesScreen(),
      Routes.categoriesScreen: (BuildContext context) =>
          const CategoriesScreen(),
      Routes.profileRoute: (BuildContext context) => const ProfileScreen(),
      Routes.editProfileRoute: (BuildContext context) =>
          const EditProfileScreen(),
      Routes.changePasswordRoute: (BuildContext context) =>
          const ChangePasswordScreen(),
      Routes.walletRoute: (BuildContext context) => const WalletScreen(),
      Routes.couponsRoute: (BuildContext context) => const CouponsScreen(),
      Routes.contactUsRoute: (BuildContext context) =>
          const HelpAndFeedbackScreen(),
      Routes.clinicRoute: (BuildContext context) => const ClinicScreen(),
      Routes.serviceClinicRoute: (BuildContext context) =>
          const ServiceClinicScreen(),
      Routes.clinicReviewsRoute: (BuildContext context) =>
          const ReviewsScreen(),
      Routes.scheduleRoute: (BuildContext context) => const ScheduleScreen(),
      Routes.paymentSuccessRoute: (BuildContext context) =>
          const PaymentSuccessScreen(),
      Routes.searchRoute: (BuildContext context) => const SearchScreen(),
      Routes.notificationsRoute: (BuildContext context) =>
          const NotificationScreen(),
      Routes.myAppointmentsRoute: (BuildContext context) =>
          const MyAppointmentsScreen(),
      Routes.myAppointmentServiceRoute: (BuildContext context) =>
          const AppointmentServiceScreen(),
      Routes.specialOffersRoute: (BuildContext context) =>
          const SpecialOffersScreen(),
      Routes.privacyRoute: (BuildContext context) => const PrivacyScreen(),
      Routes.favoritesRoute: (BuildContext context) => const FavouriteScreen(),

      //********************************************/ Vendor Module \**********************************************

      Routes.vendorMainRoute: (BuildContext context) => const VendorMainPage(),
      Routes.vendorHomeRoute: (BuildContext context) =>
          const VendorHomeScreen(),
      Routes.advancedReportsRoute: (BuildContext context) =>
          const AdvancedReports(),
      Routes.servicesRoute: (BuildContext context) =>
          const VendorServicesScreen(),
      Routes.serviceRoute: (BuildContext context) => const ServiceScreen(),
      Routes.editServiceRoute: (BuildContext context) =>
          const EditServiceScreen(),
      Routes.editClinicRoute: (BuildContext context) =>
          const EditClinicScreen(),
      Routes.vendorReviewsRoute: (BuildContext context) =>
          const VendorReviewsScreen(),
      Routes.vendorClinicRoute: (BuildContext context) =>
          const VendorClinicScreen(),
      Routes.userManagementRoute: (BuildContext context) =>
          const UserManagementScreen(),
      Routes.editBankRoute: (BuildContext context) => const EditBankScreen(),
      Routes.bankRoute: (BuildContext context) => const BankDetails(),
      Routes.financesRoute: (BuildContext context) => const FinancesScreen(),
      Routes.aboutUSRoute: (BuildContext context) => const VendorAboutUs(),
      Routes.calendarRoute: (BuildContext context) => const CalendarScreen(),
      Routes.pdfRoute: (BuildContext context) => const PdfScreen(),
      Routes.webViewRoute: (BuildContext context) => const WebViewExample(),
    };
  }

  static Widget routeMap(String screen) {
    switch (screen) {
      case Routes.loginRoute:
        return const LoginScreen();
      case Routes.splashRoute:
        return const SplashScreen();

      case Routes.registerRoute:
        return const RegisterScreen();
      case Routes.forgetPasswordRoute:
        return const ForgetPasswordScreen();

      case Routes.newPasswordRoute:
        return const NewPasswordScreen();

      case Routes.successRoute:
        return const SuccessScreen();

      case Routes.mainRoute:
        return const MainPage();
      case Routes.allClinicsScreen:
        return const AllClinicsScreen();
      case Routes.allServicesScreen:
        return const AllServicesScreen();
      case Routes.categoriesScreen:
        return const CategoriesScreen();
      case Routes.profileRoute:
        return const ProfileScreen();
      case Routes.editProfileRoute:
        return const EditProfileScreen();
      case Routes.changePasswordRoute:
        return const ChangePasswordScreen();
      case Routes.walletRoute:
        return const WalletScreen();
      case Routes.couponsRoute:
        return const CouponsScreen();
      case Routes.contactUsRoute:
        return const HelpAndFeedbackScreen();
      case Routes.clinicRoute:
        return const ClinicScreen();
      case Routes.serviceClinicRoute:
        return const ServiceClinicScreen();
      case Routes.clinicReviewsRoute:
        return const ReviewsScreen();
      case Routes.paymentSuccessRoute:
        return const PaymentSuccessScreen();
      case Routes.scheduleRoute:
        return const ScheduleScreen();
      case Routes.searchRoute:
        return const SearchScreen();
      case Routes.notificationsRoute:
        return const NotificationScreen();
      case Routes.myAppointmentsRoute:
        return const MyAppointmentsScreen();
      case Routes.myAppointmentServiceRoute:
        return const AppointmentServiceScreen();
      case Routes.specialOffersRoute:
        return const SpecialOffersScreen();
      case Routes.privacyRoute:
        return const PrivacyScreen();
      case Routes.favoritesRoute:
        return const FavouriteScreen();

      case Routes.webViewRoute:
        return const WebViewExample();

      //********************************************/ Vendor Module \**********************************************

      case Routes.vendorMainRoute:
        return const VendorMainPage();
      case Routes.vendorHomeRoute:
        return const VendorHomeScreen();
      case Routes.advancedReportsRoute:
        return const AdvancedReports();
      case Routes.servicesRoute:
        return const VendorServicesScreen();
      case Routes.serviceRoute:
        return const ServiceScreen();
      case Routes.editServiceRoute:
        return const EditServiceScreen();
      case Routes.editClinicRoute:
        return const EditClinicScreen();
      case Routes.vendorReviewsRoute:
        return const VendorReviewsScreen();
      case Routes.vendorClinicRoute:
        return const VendorClinicScreen();
      case Routes.userManagementRoute:
        return const UserManagementScreen();
      case Routes.editBankRoute:
        return const EditBankScreen();
      case Routes.bankRoute:
        return const BankDetails();
      case Routes.financesRoute:
        return const FinancesScreen();
      case Routes.aboutUSRoute:
        return const VendorAboutUs();
      case Routes.calendarRoute:
        return const CalendarScreen();
      case Routes.pdfRoute:
        return const PdfScreen();

      default:
        return const ScaffoldCustom(
          appBarCustom: AppBarCustom(
            text: AppStrings.noRouteFound,
          ),
          body: Center(child: TextCustom(text: AppStrings.noRouteFound)),
        );
    }
  }
}
