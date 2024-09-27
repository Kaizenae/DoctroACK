import 'package:doctor_ack/modules/clinic/domain/entities/clinic_services_entity.dart';

class ClinicServicesModel extends ClinicServicesEntity {
  ClinicServicesModel({
    ResultEntity? resultEntity,
  }) : super(
          resultEntity: resultEntity!,
        );

  factory ClinicServicesModel.fromJson(Map<String, dynamic> json) =>
      ClinicServicesModel(
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
          message: message ?? '',
          response: responseEntity ?? [],
        );

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
        status: json['status'],
        message: json['message'],
        responseEntity: List<ResponseEntity>.from(
            json['result'].map((e) => ResponseModel.fromJson(e))),
      );
}

class ResponseModel extends ResponseEntity {
  const ResponseModel({
    int? id,
    int? clinicID,
    double? price,
    String? name,
    String? icon,
    double? rate,
    String? description,
  }) : super(
          id: id ?? 0,
          clinicID: clinicID ?? 0,
          price: price ?? 0.0,
          icon: icon ?? '',
          name: name ?? '',
          description: description ?? '',
          rate: rate ?? 0.0,
        );

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        name: json['name'],
        id: json['id'],
        clinicID: json['clinic_id'],
        price: json['price'],
        icon: json['icon'] == false ? '' : json['icon'],
        rate: json['rating'],
        // description: json['description'] == false ? '' : json['description'],
      );
}
