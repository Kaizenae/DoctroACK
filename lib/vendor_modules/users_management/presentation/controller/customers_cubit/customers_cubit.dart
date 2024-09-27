import 'package:dartz/dartz.dart';
import '../../../../../../core/utils/packages_imprts.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../domain/entities/customers_entity.dart';
import '../../../domain/usecases/users_usecase.dart';
import 'customers_state.dart';

class CustomersCubit extends Cubit<CustomersState> {
  final CustomersUsecase customersUsecase;
  CustomersCubit({required this.customersUsecase}) : super(CustomersInitial());
  static CustomersCubit get(context) => BlocProvider.of(context);

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  Future<void> getCustomersFun() async {
    emit(GetCustomersLoadingState());
    Either<Failure, CustomersEntity> response =
        await customersUsecase(NoParams());
    refreshController.refreshCompleted();
    emit(response.fold((failure) {
      return GetCustomersErrorState(message: failure.message);
    }, (customersEntity) {
      return GetCustomersSuccessState(customersEntity: customersEntity);
    }));
  }
}
