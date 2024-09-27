import 'package:dartz/dartz.dart';
import '../../../../../../core/utils/packages_imprts.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../domain/entities/top_services_entity.dart';
import '../../../domain/use_cases/advanced_report_usecase.dart';
import 'top_services_state.dart';

class TopServicesCubit extends Cubit<TopServicesState> {
  final TopServicesUsecase topServicesUsecase;

  TopServicesCubit({required this.topServicesUsecase})
      : super(TopServicesInitial());

  static TopServicesCubit get(context) => BlocProvider.of(context);

  Future<void> getTopServicesFun() async {
    emit(GetTopServicesLoadingState());
    Either<Failure, TopServicesEntity> response =
        await topServicesUsecase(NoParams());
    emit(response.fold((failure) {
      return GetTopServicesErrorState(message: failure.message);
    }, (topServicesEntity) {
      return GetTopServicesSuccessState(topServicesEntity: topServicesEntity);
    }));
  }
}
