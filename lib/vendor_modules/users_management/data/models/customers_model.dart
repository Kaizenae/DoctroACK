import '../../domain/entities/customers_entity.dart';

class CustomersModel extends CustomersEntity {
  CustomersModel({
    ResultEntity? resultEntity,
  }) : super(
          resultEntity: resultEntity!,
        );

  factory CustomersModel.fromJson(Map<String, dynamic> json) => CustomersModel(
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
    String? mobilePhone,
    String? email,
  }) : super(
          id: id ?? 0,
          name: name ?? '',
          email: email ?? '',
          mobilePhone: mobilePhone ?? '',
        );

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        name: json['name'],
        id: json['id'],
        mobilePhone: json['phone'],
        email: json['email'],
      );
}
