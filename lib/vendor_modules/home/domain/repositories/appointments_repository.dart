import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/appointments_entity.dart';

abstract class AppointmentsRepository {
  Future<Either<Failure, AppointmentsEntity>> appointments(
      AppointmentsParams params);
}
