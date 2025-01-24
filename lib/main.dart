import 'dart:ui';

import 'package:device_preview/device_preview.dart';
import 'package:doctor_ack/core/app.dart';
import 'package:doctor_ack/core/controller/database_helper.dart';
// import 'package:doctor_ack/core/controller/firebase_api.dart';
import 'package:doctor_ack/core/local/cache_helper.dart';
import 'package:doctor_ack/core/utils/constants_manager.dart';
import 'package:doctor_ack/core/utils/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bloc_observer.dart';
import 'core/api/dio_helper.dart';
// import 'firebase_option.dart';
import 'injection_container.dart' as di;

class L10n {
  static final all = [
    const Locale('en'),
    const Locale('ar'),
  ];
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
// First get the FlutterView.
  FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

// Dimensions in physical pixels (px)
  Size size = view.physicalSize;
  AppConstants.width = size.width;
  AppConstants.height = size.height;
  //Assign publishable key to flutter_stripe
  // Stripe.publishableKey =
  //     "pk_test_51NZpcHFhBEU67ifLD00nlouQhxn78zJJWLuLl2rai998Nx6vXrpQhm9muyfHTNAva2L9HzBzz8mTmFLgBXGSv3h100F7dWB4dF";

  //Load our .env file that contains our Stripe Secret key
  await dotenv.load(fileName: "assets/.env");
  Stripe.publishableKey = dotenv.env['STRIPE_PUBLIC']!;
  Stripe.merchantIdentifier = 'DoctorAck';
  await Stripe.instance.applySettings();
  await di.init();
  await CacheHelper.init();
  await DioHelper.init();
  await DatabaseHelper.initializeDatabase();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  // initFcm();

  SharedPreferences.getInstance().then((val) {
    AppConstants.language = val.getBool('ARABIC') ?? false;
    AppConstants.languageCode = AppConstants.language ? 'ar_001' : 'en_US';
  });
  Bloc.observer = MyBlocObserver();
  AppConstants.token = CacheHelper.get(key: AppStrings.cachedToken) ?? '';
  AppConstants.expireToken =
      CacheHelper.get(key: AppStrings.cachedExpireToken) ?? '';
  AppConstants.type = CacheHelper.get(key: AppStrings.cachedType) ?? '';
  runApp(
    DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => (EasyLocalization(
            supportedLocales: L10n.all,
            path: 'assets/languages',
            fallbackLocale: L10n.all[0],
            child: const DoctorAckApp()))),
  );
}
