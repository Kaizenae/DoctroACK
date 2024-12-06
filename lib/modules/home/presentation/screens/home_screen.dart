// ignore_for_file: use_build_context_synchronously

// import 'package:doctor_ack/core/utils/routes_manager.dart';
// import 'package:doctor_ack/modules/clinic/presentaion/controllers/clinic_cubit/clinic_cubit.dart';
// import 'package:doctor_ack/modules/service/presentation/controller/service_cubit.dart';
// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import '../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../widgets/home_body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // This widget is the root of your application.
  // ignore: deprecated_member_use
  // FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  @override
  void initState() {
    // initDynamicLinkBasic();
    // initDynamicLinks();
    // initDynamicLinksHadeth();
    super.initState();
  }

//   Future<void> initDynamicLinks() async {
//     dynamicLinks.onLink.listen((dynamicLinkData) {
//       List<String> sepeatedLink = [];
//       List<String> sepratedID = [];
//       sepeatedLink.addAll(dynamicLinkData.link.path.split('/'));
//       String id = dynamicLinkData.link.toString();
//       sepratedID.addAll(id.split('/'));
// print('initDynamicLinks $sepeatedLink');
//       // RoomCubit.get(context).roomId = sepratedID[4];
//       Navigator.pushNamed(context, sepeatedLink[1]);
//     }).onError((error) {
//       debugPrint(error.message);
//     });
//   }
//
//   Future<void> initDynamicLinksHadeth() async {
//     dynamicLinks.onLink.listen((dynamicLinkData) {
//       List<String> sepeatedLink = [];
//       List<String> sepratedID = [];
//
//       sepeatedLink.addAll(dynamicLinkData.link.path.split('/'));
//       String id = dynamicLinkData.link.toString();
//       sepratedID.addAll(id.split('='));
//       print('initDynamicLinksHadeth $sepeatedLink');
//
//       // HadethInfoCubit.get(context).id = sepratedID[1];
//       Navigator.pushNamed(context, sepeatedLink[1]);
//     }).onError((error) {
//       debugPrint(error.message);
//     });
//   }

  // Future<void> initDynamicLinkBasic() async {
  //   // ignore: deprecated_member_use
  //   dynamicLinks.onLink.listen((dynamicLinkData) {
  //     List<String> sepeatedLink = [];
  //     // List<String> sepratedID = [];
  //     // print("Path ${dynamicLinkData.link.path}");
  //     //
  //     sepeatedLink.addAll(dynamicLinkData.link.path.split('/'));
  //     // String id = dynamicLinkData.link.toString();
  //     // sepratedID.addAll(id.split('='));
  //     // print("SepratedID $sepratedID");
  //     // print("SepratedLink $sepeatedLink");
  //     // HadethInfoCubit.get(context).id = sepratedID[1];
  //     if (sepeatedLink[1] == Routes.serviceClinicRoute) {
  //       ServiceCubit.get(context).serviceID = int.parse(sepeatedLink[2]);
  //       Navigator.pushNamed(context, sepeatedLink[1]);
  //     } else if (sepeatedLink[1] == Routes.clinicRoute) {
  //       ClinicCubit.get(context).clinicID = int.parse(sepeatedLink[2]);
  //       Navigator.pushNamed(context, sepeatedLink[1]);
  //     }
  //   }).onError((error) {
  //     debugPrint(error.message);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();
    return const ScaffoldCustom(
        body: SingleChildScrollView(
      child: HomeBody(),
    ));
  }
}
