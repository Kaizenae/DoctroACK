import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:doctor_ack/core/api/end_points.dart';
import 'package:doctor_ack/modules/notifications/model/notifications_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/constants_manager.dart';
import 'states.dart';

class NotificationsBLoc extends Cubit<NotificationsStates> {
  NotificationsBLoc() : super(NotificationsInitialState());

  static NotificationsBLoc get(context) => BlocProvider.of(context);
  NotificationsModel notificationsModel = NotificationsModel();
  // ignore: missing_return
  Future<void> getNotifications() async {
    emit(NotificationsLoadingState());
    Dio()
        .get("https://${EndPoints.getNotificationsEndpoint}",
            data: {"jsonrpc": "2.0", "params": {}},
            options: Options(
              headers: {
                "Content-Type": "application/json",
                'Authorization': AppConstants.token.toString(),
              },
            ))
        .then((value) {
      notificationsModel = NotificationsModel.fromJson(value.data);
      emit(NotificationsSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(NotificationsErrorState());
    });
  }
}
