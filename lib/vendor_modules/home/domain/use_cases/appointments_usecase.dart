import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/appointments_entity.dart';
import '../repositories/appointments_repository.dart';

class AppointmentsUsecase
    implements UseCase<AppointmentsEntity, AppointmentsParams> {
  final AppointmentsRepository appointmentsRepository;

  AppointmentsUsecase(this.appointmentsRepository);

  @override
  Future<Either<Failure, AppointmentsEntity>> call(AppointmentsParams params) =>
      appointmentsRepository.appointments(params);
}
