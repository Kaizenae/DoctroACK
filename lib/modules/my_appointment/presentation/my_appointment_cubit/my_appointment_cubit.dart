import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';
import '../../../../../../core/utils/packages_imprts.dart';

import '../../../../../core/error/failure.dart';
import '../../domain/entities/my_appointment_entity.dart';
import '../../domain/use_cases/my_appointment_usecase.dart';
import 'my_appointment_state.dart';

class MyAppointmentsCubit extends Cubit<MyAppointmentsState> {
  final MyAppointmentUsecase myAppointmentUsecase;
  MyAppointmentsCubit({required this.myAppointmentUsecase})
      : super(MyAppointmentsInitial());

  static MyAppointmentsCubit get(context) => BlocProvider.of(context);

  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  RefreshController refreshPastController =
      RefreshController(initialRefresh: false);
  getMyAppointment() async {
    emit(GetMyAppointmentLoadingState());
    Either<Failure, MyAppointmentEntity> response =
        await myAppointmentUsecase(NoParams());
    refreshController.refreshCompleted();
    refreshPastController.refreshCompleted();

    emit(response
        .fold((failure) => GetMyAppointmentErrorState(message: failure.message),
            (myAppointmentEntity) {
      return GetMyAppointmentSuccessState(
          myAppointmentEntity: myAppointmentEntity);
    }));
  }
}
