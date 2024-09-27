import 'package:doctor_ack/core/controller/helper_functions.dart';
import 'package:doctor_ack/core/widgets/app_bar/app_bar_custom.dart';
import 'package:doctor_ack/core/widgets/scaffold_custom/scaffold_custom.dart';
import 'package:doctor_ack/vendor_modules/finances/presentation/manager/finances_cubit/finances_cubit.dart';
import 'package:doctor_ack/vendor_modules/finances/presentation/manager/finances_cubit/finances_state.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/utils/packages_imprts.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfScreen extends StatelessWidget {
  const PdfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
        appBarCustom: AppBarCustom(
          text: FinancesCubit.get(context).paymentName,
        ),
        body: BlocBuilder<FinancesCubit, FinancesState>(
          builder: (context, state) {
            var financeCubit = FinancesCubit.get(context);
            return SfPdfViewer.memory(
              HelperFunctions.imageConverter(financeCubit.pdf),
              controller: financeCubit.pdfViewerController,
            );
          },
        ));
  }
}
