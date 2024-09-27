import 'package:dartz/dartz.dart';
import '../../../../../../core/utils/packages_imprts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../domain/entities/advanced_sales_entity.dart';
import '../../../domain/use_cases/advanced_report_usecase.dart';
import 'advanced_sales_state.dart';

class AdvancedSalesCubit extends Cubit<AdvancedSalesState> {
  final AdvancedSalesUsecase advancedSalesUsecase;

  AdvancedSalesCubit({required this.advancedSalesUsecase})
      : super(AdvancedSalesInitial());

  static AdvancedSalesCubit get(context) => BlocProvider.of(context);

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  int serviceId = 0;
  String filter = 'months';
  String sort = 'lifetime';
  TooltipBehavior tooltip = TooltipBehavior();

  Future<void> getAdvancedSalesFun() async {
    emit(GetAdvancedSalesLoadingState());
    Either<Failure, AdvancedSalesEntity> response = await advancedSalesUsecase(
        AdvancedReportParams(filter: filter, sort: sort, serviceId: serviceId));
    refreshController.refreshCompleted();
    emit(response.fold((failure) {
      return GetAdvancedSalesErrorState(message: failure.message);
    }, (advancedSalesEntity) {
      return GetAdvancedSalesSuccessState(
          advancedSalesEntity: advancedSalesEntity);
    }));
  }
}
