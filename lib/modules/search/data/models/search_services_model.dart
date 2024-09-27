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
    List<ResponseEntity>? responseEntity,
  }) : super(
          status: status ?? false,
          message: message ?? '',
          response: responseEntity ?? [],
        );

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
        status: json['status'] == 'success' ? true : false,
        message: json['massage'],
        responseEntity: List<ResponseEntity>.from(
            json['result'].map((e) => ResponseModel.fromJson(e))),
      );
}

class ResponseModel extends ResponseEntity {
  const ResponseModel({
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

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        name: json['name'],
        city: json['city'],
        id: json['id'],
        image: json['image_1920'] == false ? '' : json['image_1920'],
        rate: double.parse(json['rating'].toString()),
        description: json['description'] == false ? '' : json['description'],
      );
}
