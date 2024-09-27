import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/general_entities/create_entity.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';
import 'package:flutter/cupertino.dart';
import '../../../../../../core/utils/packages_imprts.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/use_cases/my_appointment_usecase.dart';
import 'cancel_change_appointment_state.dart';

class CancelChangeAppointmentsCubit
    extends Cubit<CancelChangeAppointmentsState> {
  final CancelAppointmentUsecase cancelAppointmentUsecase;
  final ChangeAppointmentUsecase changeAppointmentUsecase;
  CancelChangeAppointmentsCubit(
      {required this.cancelAppointmentUsecase,
      required this.changeAppointmentUsecase})
      : super(CancelChangeAppointmentsInitial());

  static CancelChangeAppointmentsCubit get(context) => BlocProvider.of(context);

  TextEditingController reasonController = TextEditingController();
  int id = 0;
  String reason = '';
  String date = '';
  String time = '';
  cancelAppointment() async {
    emit(CancelAppointmentLoadingState());
    Either<Failure, CreateEntity> response = await cancelAppointmentUsecase(
        CancelAppointmentParams(id: id, reason: reason));

    emit(response.fold(
        (failure) => CancelAppointmentErrorState(message: failure.message),
        (createEntity) {
      id = 0;
      reason = '';
      date = '';
      time = '';
      return CancelAppointmentSuccessState(createEntity: createEntity);
    }));
  }

  changeAppointment() async {
    emit(ChangeAppointmentLoadingState());
    Either<Failure, CreateEntity> response = await changeAppointmentUsecase(
        ChangeAppointmentParams(id: id, date: date, time: time));

    emit(response.fold(
        (failure) => ChangeAppointmentErrorState(message: failure.message),
        (createEntity) =>
            ChangeAppointmentSuccessState(createEntity: createEntity)));
  }
}
