import '../../domain/entities/login_entity.dart';

class LoginModel extends LoginEntity {
  LoginModel({ResultEntity? resultEntity})
      : super(
          resultEntity: resultEntity!,
        );

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        resultEntity: ResultModel.fromJson(json['result']),
      );

  Map<String, dynamic> toJson() => {"result": resultEntity};
}

class ResultModel extends ResultEntity {
  ResultModel({
    bool? status,
    String? message,
    BodyEntity? body,
  }) : super(
          status: status ?? false,
          message: message ?? '',
          body: body!,
        );

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
      status: json['status'],
      body: BodyModel.fromJson(json['body']),
      message: json['message']);

  Map<String, dynamic> toJson() => {
        "success": status,
        "message": message,
      };
}

class BodyModel extends BodyEntity {
  const BodyModel({
    String? token,
    String? expireToken,
    String? type,
    String? role,
    int? id,
    int? partnerId,
  }) : super(
          token: token ?? '',
          expireToken: expireToken ?? '',
          type: type ?? '',
          role: role ?? '',
          id: id ?? 0,
          partnerId: partnerId ?? 0,
        );

  factory BodyModel.fromJson(Map<String, dynamic> json) => BodyModel(
        type: json['type'],
        role: json['role'],
        token: json['token'],
        id: json['uid'],
        partnerId: json['parent_id'],
        expireToken: json['token_expiry_date'],
      );
}
