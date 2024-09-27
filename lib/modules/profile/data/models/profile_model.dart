import '../../domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  ProfileModel({
    ResultEntity? resultEntity,
  }) : super(
          resultEntity: resultEntity!,
        );

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        resultEntity: ResultModel.fromJson(json['result']),
      );
}

class ResultModel extends ResultEntity {
  ResultModel({
    int? status,
    String? message,
    ResponseEntity? responseEntity,
  }) : super(
            status: status ?? 400,
            response: responseEntity!,
            message: message ?? '');

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
        status: json['status'],
        responseEntity: ResponseModel.fromJson(json['customer']),
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
  }) : super(
          id: id ?? 0,
          name: name ?? '',
          imageUrl: imageUrl ?? '',
          email: email ?? '',
          mobilePhone: mobilePhone ?? '',
        );

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        name: json['name'],
        id: json['id'],
        mobilePhone: json['phone'],
        email: json['email'],
        imageUrl: json['image'],
      );
}
