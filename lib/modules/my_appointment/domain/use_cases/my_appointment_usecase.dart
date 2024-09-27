import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/general_entities/create_entity.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/appointment_entity.dart';
import '../entities/my_appointment_entity.dart';
import '../repositories/my_appointment_repository.dart';

class MyAppointmentUsecase implements UseCase<MyAppointmentEntity, NoParams> {
  final MyAppointmentRepository myAppointmentRepository;

  MyAppointmentUsecase(this.myAppointmentRepository);

  @override
  Future<Either<Failure, MyAppointmentEntity>> call(NoParams params) =>
      myAppointmentRepository.myAppointment(params);
}

class AppointmentUsecase implements UseCase<UserAppointmentEntity, IDParams> {
  final MyAppointmentRepository myAppointmentRepository;

  AppointmentUsecase(this.myAppointmentRepository);

  @override
  Future<Either<Failure, UserAppointmentEntity>> call(IDParams params) =>
      myAppointmentRepository.appointment(params);
}

class CancelAppointmentUsecase
    implements UseCase<CreateEntity, CancelAppointmentParams> {
  final MyAppointmentRepository myAppointmentRepository;

  CancelAppointmentUsecase(this.myAppointmentRepository);

  @override
  Future<Either<Failure, CreateEntity>> call(CancelAppointmentParams params) =>
      myAppointmentRepository.cancelAppointment(params);
}

class ChangeAppointmentUsecase
    implements UseCase<CreateEntity, ChangeAppointmentParams> {
  final MyAppointmentRepository myAppointmentRepository;

  ChangeAppointmentUsecase(this.myAppointmentRepository);

  @override
  Future<Either<Failure, CreateEntity>> call(ChangeAppointmentParams params) =>
      myAppointmentRepository.changeAppointment(params);
}
