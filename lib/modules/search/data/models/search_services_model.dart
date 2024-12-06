import '../../domain/entities/search_services_entity.dart';

class SearchServicesModel extends SearchServicesEntity {
  SearchServicesModel({
    ResultEntity? resultEntity,
  }) : super(
          resultEntity: resultEntity!,
        );

  factory SearchServicesModel.fromJson(Map<String, dynamic> json) =>
      SearchServicesModel(
        resultEntity: ResultModel.fromJson(json['result']),
      );
}

class ResultModel extends ResultEntity {
  ResultModel({
    bool? status,
    String? message,
    ResponseEntity? responseEntity,
  }) : super(
          status: status ?? false,
          message: message ?? '',
          response: responseEntity!,
        );

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
        status: json['status'] == 'success' ? true : false,
        message: json['massage'],
        responseEntity: ResponseModel.fromJson(
          json["result"],
        ),
      );
}

class ResponseModel extends ResponseEntity {
  ResponseModel({List? services, List? clinics})
      : super(clinics: clinics ?? [], services: services ?? []);
  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        services: List<ServicesEntity>.from(
          json["services"].map(
            (e) => ServicesModel.fromJson(e),
          ),
        ),
        clinics: List<ServicesEntity>.from(
          json["clinics"].map(
            (e) => ServicesModel.fromJson(e),
          ),
        ),
      );
}

class ServicesModel extends ServicesEntity {
  const ServicesModel({
    int? id,
    String? name,
    String? city,
    String? image,
    String? description,
    double? rate,
  }) : super(
          id: id ?? 0,
          name: name ?? '',
          city: city ?? '',
          image: image ?? '',
          description: description ?? '',
          rate: rate ?? 0.0,
        );

  factory ServicesModel.fromJson(Map<String, dynamic> json) => ServicesModel(
        name: json['name'],
        city: json['city'],
        id: json['id'],
        image: json['image_1920'] == false ? '' : json['image_1920'],
        rate: double.parse(json['rating'].toString()),
        description: json['description'] == false ? '' : json['description'],
      );
}
