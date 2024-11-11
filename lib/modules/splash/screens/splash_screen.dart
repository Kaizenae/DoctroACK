// ignore_for_file: use_build_context_synchronously

import 'package:doctor_ack/core/utils/constants_manager.dart';
import 'package:flutter/material.dart';
// import '../../../../../../core/utils/packages_imprts.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/routes_manager.dart';
import '../../../core/widgets/component.dart';
import '../../../core/widgets/scaffold_custom/scaffold_custom.dart';
// import '../../user/presentation/controllers/users_cubit/users_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool animate = false;

  @override
  void initState() {
    super.initState();
    startAnimation();
    // UsersCubit.get(context).updateNoTokenFun();
  }

  Future startAnimation() async {
    // await Future.delayed(const Duration(milliseconds: 500));
    // setState(() {
    //   animate = true;
    // });
    // await Future.delayed(const Duration(milliseconds: 2000));
    Future.delayed(
      const Duration(seconds: 1, milliseconds: 800),
      () {
        if (AppConstants.token.isNotEmpty && AppConstants.type == 'patient') {
          navigatorAndRemove(context, Routes.mainRoute);
        } else if (AppConstants.token.isNotEmpty &&
            AppConstants.type != 'patient') {
          navigatorAndRemove(context, Routes.vendorMainRoute);
        } else {
          navigatorAndRemove(context, Routes.loginRoute);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      backgroundColor: ColorManager.white,
      body:
          // BlocProvider.value(
          // value: BlocProvider.of<UsersCubit>(context)..updateNoTokenFun(),
          // child:
          Center(
        child: Lottie.asset(ImageAssets.splashLogo, repeat: false
            // onLoaded: (p0) => navigatorAndRemove(context, Routes.mainRoute),
            ),
      ),
      // ),
    );
  }
}
