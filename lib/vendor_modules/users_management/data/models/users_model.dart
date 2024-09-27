import '../../domain/entities/users_entity.dart';

class UsersModel extends UsersEntity {
  UsersModel({
    ResultEntity? resultEntity,
  }) : super(
          resultEntity: resultEntity!,
        );

  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
        resultEntity: ResultModel.fromJson(json['result']),
      );
}

class ResultModel extends ResultEntity {
  ResultModel({
    bool? status,
    String? message,
    List<ResponseEntity>? responseEntity,
  }) : super(
            status: status ?? false,
            response: responseEntity!,
            message: message ?? '');

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
        status: json['status'],
        responseEntity:
            List.from(json['result'].map((e) => ResponseModel.fromJson(e))),
        message: json['message'],
      );
}

class ResponseModel extends ResponseEntity {
  const ResponseModel({
    int? id,
    String? name,
    String? imageUrl,
    String? mobilePhone,
    String? email,
    String? role,
  }) : super(
          id: id ?? 0,
          name: name ?? '',
          imageUrl: imageUrl ?? '',
          email: email ?? '',
          mobilePhone: mobilePhone ?? '',
          role: role ?? '',
        );

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        name: json['name'],
        id: json['uid'],
        mobilePhone: json['phone'],
        email: json['email'],
        imageUrl: json['image'],
        role: json['role'],
      );
}
