import '../../domain/entities/reviews_entity.dart';

class ReviewsModel extends ReviewsEntity {
  ReviewsModel({
    ResultEntity? resultEntity,
  }) : super(
          resultEntity: resultEntity!,
        );

  factory ReviewsModel.fromJson(Map<String, dynamic> json) => ReviewsModel(
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
    PatientData? patient,
    String? reviewStar,
    String? description,
    String? date,
    int? clinicID,
    ServiceData? service,
  }) : super(
          id: id ?? 0,
          patient: patient!,
          reviewStar: reviewStar ?? '',
          description: description ?? '',
          date: date ?? '2023-12-28',
          clinicID: clinicID ?? 0,
          service: service!,
        );

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        // id: json['id'],
        patient: PatientDataModel.fromJson(json['patient_data']),
        description: json['description'],
        date: json['date'],
        reviewStar: json['review_star'].toString(),
        clinicID: json['clinic_id'],
        service: ServiceDataModel.fromJson(json['service_data']),
      );
}

class PatientDataModel extends PatientData {
  const PatientDataModel({
    int? id,
    String? name,
  }) : super(
          id: id ?? 0,
          name: name ?? '',
        );

  factory PatientDataModel.fromJson(Map<String, dynamic> json) =>
      PatientDataModel(
        id: json['patient_id'],
        name: json['patient_name'],
      );
}

class ServiceDataModel extends ServiceData {
  const ServiceDataModel({
    int? id,
    String? name,
  }) : super(
          id: id ?? 0,
          name: name ?? '',
        );

  factory ServiceDataModel.fromJson(Map<String, dynamic> json) =>
      ServiceDataModel(
        id: json['service_id'],
        name: json['service_name'],
      );
}
