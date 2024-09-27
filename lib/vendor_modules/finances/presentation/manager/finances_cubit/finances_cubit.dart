import 'package:dartz/dartz.dart';
import '../../../../../../core/utils/packages_imprts.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../domain/entities/finances_entity.dart';
import '../../../domain/use_cases/finances_usecase.dart';
import 'finances_state.dart';

class FinancesCubit extends Cubit<FinancesState> {
  final FinancesUsecase financesUsecase;
  FinancesCubit({required this.financesUsecase}) : super(FinancesInitial());
  static FinancesCubit get(context) => BlocProvider.of(context);

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  String pdf = '';
  String paymentName = '';

  PdfViewerController pdfViewerController = PdfViewerController();

  Future<void> getFinancesFun() async {
    emit(GetFinancesLoadingState());
    Either<Failure, FinancesEntity> response =
        await financesUsecase(NoParams());
    refreshController.refreshCompleted();
    emit(response.fold((failure) {
      return GetFinancesErrorState(message: failure.message);
    }, (financesEntity) {
      return GetFinancesSuccessState(financesEntity: financesEntity);
    }));
  }
}
