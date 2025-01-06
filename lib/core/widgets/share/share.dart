import 'dart:io';

import 'package:share_plus/share_plus.dart';

void shareFun({required String name}) async {
  if (Platform.isIOS) {
    await Share.share(
      "https://apps.apple.com/us/app/doctorack/id6477729263",
      subject: name.toString(),
    );
  } else if (Platform.isAndroid) {
    await Share.share(
      "https://play.google.com/store/apps/details?id=com.doctorAck.doctor_ack",
      subject: name.toString(),
    );
  }
}


// https://apps.apple.com/ae/app/idc-hr/id6478759744
// https://play.google.com/store/apps/details?id=com.attendance.IDCHR