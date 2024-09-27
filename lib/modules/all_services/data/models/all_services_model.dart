import '../../domain/entities/all_services_entity.dart';

class AllServicesModel extends AllServicesEntity {
  AllServicesModel({
    ResultEntity? resultEntity,
  }) : super(
          resultEntity: resultEntity!,
        );

  factory AllServicesModel.fromJson(Map<String, dynamic> json) =>
      AllServicesModel(
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
        message: json['massage'],
        responseEntity: List<ResponseEntity>.from(
            json['result'].map((e) => ResponseModel.fromJson(e))),
      );
}

class ResponseModel extends ResponseEntity {
  ResponseModel({
    int? id,
    String? name,
    String? city,
    String? image,
    String? description,
    double? rate,
    double? price,
    ClinicServiceEntity? clinicServiceEntity,
  }) : super(
            id: id ?? 0,
            name: name ?? '',
            city: city ?? '',
            image: image ?? '',
            description: description ?? '',
            rate: rate ?? 0.0,
            price: price ?? 0.0,
            clinicServiceEntity: clinicServiceEntity!);

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        name: json['name'],
        city: json['city'],
        id: json['id'],
        image: json['icon'] == false ? '' : json['icon'],
        rate: double.parse(json['rating'].toString()),
        price: json['price'],
        // description: json['description'] == false ? '' : json['description'],
        clinicServiceEntity: ClinicServiceModel.fromJson(json['clinic']),
      );
}

class ClinicServiceModel extends ClinicServiceEntity {
  const ClinicServiceModel({
    int? id,
    String? name,
  }) : super(
          id: id ?? 0,
          name: name ?? '',
        );

  factory ClinicServiceModel.fromJson(Map<String, dynamic> json) =>
      ClinicServiceModel(
        id: json['clinic_id'] == false ? 0 : json['clinic_id'],
        name: json['clinic_name'],
      );
}
