import 'package:doctor_ack/core/general_models/notification_model.dart';

import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../../../forget_password/data/models/general_model.dart';

abstract class UserRemoteDataSource {
  Future<GeneralModel> updateNoToken({
    required String noToken,
  });

  Future<NotificationModel> sendNotification({
    required String title,
    required String body,
    required List<String> toToken,
  });

  Future<GeneralModel> deleteUserAccount();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  ApiConsumer apiConsumer;

  UserRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<GeneralModel> updateNoToken({
    required String noToken,
  }) async {
    final response =
        await apiConsumer.post(EndPoints.updateNoTokenEndpoint, body: {
      "jsonrpc": "2.0",
      "params": {
        "notification": noToken,
      }
    });
    return GeneralModel.fromJson(response);
  }

  @override
  Future<NotificationModel> sendNotification(
      {required String title,
      required String body,
      required List<String> toToken}) async {
    final response =
        await apiConsumer.post(EndPoints.sendNotificationEndpoint, body: {
      "notification": {"body": body, "title": title},
      "registration_ids": toToken
    }, headers: {
      "Authorization":
          "key=AAAAeLI0T4g:APA91bG-8HbI570CfQQmMxrD4nKjawRTBRTbMUYlEyd1O2pYi_vXeUbkgQtq4qpVi6C95TkCmJowLbaNdau7xWbqpMfNVZo58Y0Wt7cQJSgzrYP0Z5ri9HOuWGBA1-iTbjbrmDDmIlNZ"
    });
    return NotificationModel.fromJson(response);
  }

  @override
  Future<GeneralModel> deleteUserAccount() async {
    final response = await apiConsumer.post(EndPoints.deleteUserAccountEndpoint,
        body: {"jsonrpc": "2.0", "params": {}});
    return GeneralModel.fromJson(response);
  }
}
