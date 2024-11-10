// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:share_plus/share_plus.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class DynamicLinksHelper {
  static Future<void> createLink(
      String refCode, String title, String image) async {
    const String url = 'https://doctorack.page.link';
    final DynamicLinkParameters parameters = DynamicLinkParameters(
        androidParameters: const AndroidParameters(
            packageName: "come.doctorAck.protoType", minimumVersion: 0),
        iosParameters: const IOSParameters(
            bundleId: "com.doctorack.DoctorAck", minimumVersion: "0"),
        socialMetaTagParameters: SocialMetaTagParameters(
            description: '', imageUrl: Uri.parse(image), title: title),
        link: Uri.parse('$url/$refCode'),
        uriPrefix: "https://doctorack.page.link");

    final FirebaseDynamicLinks links = FirebaseDynamicLinks.instance;
    final refLink = await links.buildShortLink(parameters);

    await Share.share(
      refLink.shortUrl.toString(),
      subject: title,
    );
  }

  void handleMyLink(Uri url, BuildContext context) {
    List<String> sepeatedLink = [];

    /// osama.link.page/Hellow --> osama.link.page and Hellow
    sepeatedLink.addAll(url.path.split('/'));
    FirebaseDynamicLinksPlatform.instance.onLink.listen((event) {
      Navigator.pushNamed(context, event.link.path);
    }).onError((error) {
      debugPrint(error.message);
    });

    // Get.to(()=>ProductDetailScreen(sepeatedLink[1]));
    // navigator(context, sepeatedLink[1]);
  }

  void initDynamicLink(BuildContext context) async {
    FirebaseDynamicLinksPlatform.instance.onLink.listen((event) {
      debugPrint("The Token that i'm interesed in is ${event.link.path}");

      Navigator.pushNamed(context, event.link.path);
    }).onError((error) {
      debugPrint(error.message);
    });
    // final instanceLink =
    //     await FirebaseDynamicLinksPlatform.instance.getInitialLink();
    //
    // if (instanceLink != null) {
    //   final Uri refLink = instanceLink.link;
    //   // if(refLink.queryParameters.containsKey(key))
    //   Future.delayed(
    //     const Duration(milliseconds: 100),
    //     () => handleMyLink(refLink, context),
    //   );
    //   // Share.share('This is the link ${refLink.data}');
    // }
  }
}
