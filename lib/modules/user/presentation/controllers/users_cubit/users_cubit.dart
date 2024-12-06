import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/general_entities/notification_entity.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import '../../../../../../core/utils/packages_imprts.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../domain/usecases/user_usecase.dart';
import 'users_state.dart';

class UsersCubit extends Cubit<UsersStates> {
  final UpdateNoTokenUsecase updateNoTokenUsecase;
  final SendNotificationUsecase sendNotificationUsecase;

  UsersCubit({
    required this.updateNoTokenUsecase,
    required this.sendNotificationUsecase,
  }) : super(InitialUsersState());

  static UsersCubit get(context) => BlocProvider.of(context);

  String title = '';
  String body = '';
  List<String> toToken = [];
  String noToken = '';

  Future<void> sendNotification() async {
    Either<Failure, NotificationEntity> response =
        await sendNotificationUsecase(
            SendNotificationParams(title: title, body: body, toToken: toToken));

    response.fold((failure) => failure.message, (noIdEntity) {
      return noIdEntity;
    });
  }

  // Future<void> updateNoTokenFun() async {
  //   // var deviceState = await FirebaseMessaging.instance.getToken();

  //   if (deviceState == null) return;
  //   Either<Failure, GeneralEntity> response =
  //       await updateNoTokenUsecase(StringParams(string: deviceState));

  //   response.fold(
  //       (failure) => failure.message, (createNoIdEntity) => createNoIdEntity);
  // }
}
