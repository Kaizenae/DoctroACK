import 'package:dartz/dartz.dart';
import '../../../../../../core/utils/packages_imprts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../domain/entities/advanced_customers_entity.dart';
import '../../../domain/use_cases/advanced_report_usecase.dart';
import 'advanced_customers_state.dart';

class AdvancedCustomersCubit extends Cubit<AdvancedCustomersState> {
  final AdvancedCustomersUsecase advancedCustomersUsecase;

  AdvancedCustomersCubit({required this.advancedCustomersUsecase})
      : super(AdvancedCustomersInitial());

  static AdvancedCustomersCubit get(context) => BlocProvider.of(context);

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  int serviceId = 0;
  String filter = 'times';
  String sort = 'lifetime';

  PdfViewerController pdfViewerController = PdfViewerController();
  TooltipBehavior tooltipCustomer = TooltipBehavior();

  Future<void> getAdvancedCustomersFun() async {
    emit(GetAdvancedCustomersLoadingState());
    Either<Failure, AdvancedCustomersEntity> response =
        await advancedCustomersUsecase(AdvancedReportParams(
            filter: filter, sort: sort, serviceId: serviceId));
    refreshController.refreshCompleted();
    emit(response.fold((failure) {
      return GetAdvancedCustomersErrorState(message: failure.message);
    }, (advancedCustomersEntity) {
      return GetAdvancedCustomersSuccessState(
          advancedCustomersEntity: advancedCustomersEntity);
    }));
  }
}
