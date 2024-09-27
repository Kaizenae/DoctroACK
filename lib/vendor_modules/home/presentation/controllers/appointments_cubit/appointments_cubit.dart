import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';
import '../../../../../../core/utils/packages_imprts.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/utils/color_manager.dart';
import '../../../domain/entities/appointments_entity.dart';
import '../../../domain/use_cases/appointments_usecase.dart';
import 'appointments_state.dart';

class AppointmentsCubit extends Cubit<AppointmentsState> {
  final AppointmentsUsecase appointmentsUsecase;

  AppointmentsCubit({required this.appointmentsUsecase})
      : super(AppointmentsInitial());

  static AppointmentsCubit get(context) => BlocProvider.of(context);
  int filter = 0;
  int serviceId = 0;
  String start = '';
  String end = '';
  var colorCollection = [
    ColorManager.red,
    ColorManager.primary,
    ColorManager.darkGrey,
  ];
  Future<void> getAppointmentsFun() async {
    emit(GetAppointmentsLoadingState());

    Either<Failure, AppointmentsEntity> response = await appointmentsUsecase(
        AppointmentsParams(
            filter: filter, start: start, end: end, serviceId: serviceId));

    emit(response
        .fold((failure) => GetAppointmentsErrorState(message: failure.message),
            (appointmentsEntity) {
      return GetAppointmentsSuccessState(
          appointmentsEntity: appointmentsEntity);
    }));
  }
}
