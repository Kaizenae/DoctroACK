import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/general_entities/notification_entity.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../forget_password/domain/entities/general_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, GeneralEntity>> updateNoToken(StringParams params);
  Future<Either<Failure, NotificationEntity>> sendNotification(
      SendNotificationParams params);
  Future<Either<Failure, GeneralEntity>> deleteUserAccount(NoParams params);
}
