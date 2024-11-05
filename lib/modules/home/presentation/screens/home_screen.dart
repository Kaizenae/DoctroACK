// ignore_for_file: use_build_context_synchronously
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
  @override
  void initState() {
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

  @override
  Widget build(BuildContext context) {
    return const ScaffoldCustom(
        body: SingleChildScrollView(
      child: HomeBody(),
    ));
  }
}
