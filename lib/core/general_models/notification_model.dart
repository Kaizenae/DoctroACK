import '../general_entities/notification_entity.dart';

class NotificationModel extends NotificationEntity {
  const NotificationModel({
    int? success,
    int? failure,
  }) : super(
          success: success ?? 0,
          failure: failure ?? 0,
        );

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        success: json['success'],
        failure: json['failure'],
      );
}
