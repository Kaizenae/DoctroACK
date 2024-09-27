import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';
import 'package:doctor_ack/modules/my_appointment/domain/entities/appointment_entity.dart';
import '../../../../../../core/utils/packages_imprts.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/use_cases/my_appointment_usecase.dart';
import 'appointment_state.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  final AppointmentUsecase appointmentUsecase;
  AppointmentCubit({required this.appointmentUsecase})
      : super(AppointmentInitial());

  static AppointmentCubit get(context) => BlocProvider.of(context);

  int id = 0;

  getMyAppointment() async {
    emit(GetAppointmentLoadingState());
    Either<Failure, UserAppointmentEntity> response =
        await appointmentUsecase(IDParams(id: id));

    emit(response
        .fold((failure) => GetAppointmentErrorState(message: failure.message),
            (appointmentEntity) {
      return GetAppointmentSuccessState(appointmentEntity: appointmentEntity);
    }));
  }
}
