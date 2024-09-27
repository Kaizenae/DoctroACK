import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';
import 'package:doctor_ack/modules/forget_password/domain/entities/general_entity.dart';
import '../../../../core/error/failure.dart';

abstract class EditProfileRepository {
  Future<Either<Failure, GeneralEntity>> editProfile(EditProfileParams params);
}
