import '../../domain/entities/all_clinics_entity.dart';

class AllClinicsModel extends AllClinicsEntity {
  AllClinicsModel({
    ResultEntity? resultEntity,
  }) : super(
          resultEntity: resultEntity!,
        );

  factory AllClinicsModel.fromJson(Map<String, dynamic> json) =>
      AllClinicsModel(
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
  const ResponseModel({
    int? id,
    String? name,
    String? city,
    String? image,
    String? description,
    double? rate,
    bool? favourite,
    String? createdAt,
    String? updatedAt,
  }) : super(
          id: id ?? 0,
          name: name ?? '',
          city: city ?? '',
          image: image ?? '',
          description: description ?? '',
          favourite: favourite ?? false,
          rate: rate ?? 0.0,
          createdAt: createdAt ?? '',
          updatedAt: updatedAt ?? '',
        );

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        name: json['name'],
        city: json['city'],
        id: json['id'],
        favourite: json['favourite'],
        image: json['image_1920'] == false ? '' : json['image_1920'],
        rate: double.parse(json['rating'].toString()),
        description: json['description'] == false ? '' : json['description'],
        createdAt: json['create_date'],
        updatedAt: json['update_on'],
      );
}
