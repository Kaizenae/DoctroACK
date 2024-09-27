import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/general_entities/create_entity.dart';
import '../entities/appointment_entity.dart';
import '../entities/my_appointment_entity.dart';

abstract class MyAppointmentRepository {
  Future<Either<Failure, MyAppointmentEntity>> myAppointment(NoParams params);
  Future<Either<Failure, UserAppointmentEntity>> appointment(IDParams params);
  Future<Either<Failure, CreateEntity>> cancelAppointment(
      CancelAppointmentParams params);
  Future<Either<Failure, CreateEntity>> changeAppointment(
      ChangeAppointmentParams params);
}
