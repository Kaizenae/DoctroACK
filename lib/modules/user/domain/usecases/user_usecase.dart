import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/general_entities/notification_entity.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../forget_password/domain/entities/general_entity.dart';
import '../repositories/user_repository.dart';

class UpdateNoTokenUsecase implements UseCase<GeneralEntity, StringParams> {
  final UserRepository userRepository;

  UpdateNoTokenUsecase(this.userRepository);

  @override
  Future<Either<Failure, GeneralEntity>> call(StringParams params) =>
      userRepository.updateNoToken(params);
}

class SendNotificationUsecase
    implements UseCase<NotificationEntity, SendNotificationParams> {
  final UserRepository userRepository;

  SendNotificationUsecase(this.userRepository);

  @override
  Future<Either<Failure, NotificationEntity>> call(
          SendNotificationParams params) =>
      userRepository.sendNotification(params);
}
