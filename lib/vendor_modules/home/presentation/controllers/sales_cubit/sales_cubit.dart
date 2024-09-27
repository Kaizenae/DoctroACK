import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';
import 'package:doctor_ack/vendor_modules/home/domain/entities/sales_entity.dart';
import 'package:doctor_ack/vendor_modules/home/domain/use_cases/sales_usecase.dart';
import '../../../../../../core/utils/packages_imprts.dart';

import '../../../../../core/error/failure.dart';
import 'sales_state.dart';

class SalesCubit extends Cubit<SalesState> {
  final SalesUsecase salesUsecase;

  SalesCubit({required this.salesUsecase}) : super(SalesInitial());

  static SalesCubit get(context) => BlocProvider.of(context);
  String filter = 'today';
  String start = '';
  String end = '';

  Future<void> getSalesFun() async {
    emit(GetSalesLoadingState());

    Either<Failure, SalesEntity> response =
        await salesUsecase(SalesParams(filter: filter, start: start, end: end));

    emit(response
        .fold((failure) => GetSalesErrorState(message: failure.message),
            (salesEntity) {
      return GetSalesSuccessState(salesEntity: salesEntity);
    }));
  }
}
