import 'package:doctor_ack/core/widgets/scaffold_custom/scaffold_custom.dart';
import 'package:doctor_ack/modules/clinic/presentaion/widgets/clinic_body.dart';
import 'package:flutter/material.dart';

class ClinicScreen extends StatelessWidget {
  const ClinicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScaffoldCustom(
      body: SingleChildScrollView(child: ClinicBody()),
    );
  }
}
