import 'package:doctor_ack/core/widgets/scaffold_custom/scaffold_custom.dart';

import 'package:flutter/material.dart';

import '../widgets/clinic_body.dart';

class VendorClinicScreen extends StatelessWidget {
  const VendorClinicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScaffoldCustom(
      body: ClinicBody(),
    );
  }
}
