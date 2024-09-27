import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/general_entities/create_entity.dart';
import '../../../../../../core/utils/packages_imprts.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../domain/use_cases/clinic_usecase.dart';
import 'create_reservation_order_state.dart';

class CreateReservationOrderCubit extends Cubit<CreateReservationOrderState> {
  final CreateReservationOrderUsecase createReservationOrderUsecase;

  CreateReservationOrderCubit({required this.createReservationOrderUsecase})
      : super(ClinicInitial());

  static CreateReservationOrderCubit get(context) => BlocProvider.of(context);

  int serviceID = 0;
  int doctorId = 0;
  String date = '';
  String start = '';
  String transId = '';
  String price = '0';

  Future<void> createReservationOrder({required String transID}) async {
    emit(CreateReservationOrderLoadingState());
    Either<Failure, CreateEntity> response =
        await createReservationOrderUsecase(CreateReservationOrderParams(
            wallet: false,
            serviceID: serviceID,
            userID: doctorId,
            date: date,
            start: start,
            transId: transID,
            state: 'confirm'));

    emit(response.fold((failure) {
      return CreateReservationOrderErrorState(message: failure.message);
    }, (createEntity) {
      return CreateReservationOrderSuccessState(createEntity: createEntity);
    }));
  }

  Future<void> createAppointmentWallet() async {
    emit(CreateAppointmentWalletLoadingState());
    Either<Failure, CreateEntity> response =
        await createReservationOrderUsecase(CreateReservationOrderParams(
            wallet: true,
            serviceID: serviceID,
            userID: doctorId,
            date: date,
            start: start,
            transId: 'Wallet',
            state: 'confirm'));

    emit(response.fold((failure) {
      return CreateAppointmentWalletErrorState(message: failure.message);
    }, (createEntity) {
      return CreateAppointmentWalletSuccessState(createEntity: createEntity);
    }));
  }
}
