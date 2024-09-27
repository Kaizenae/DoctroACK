import '../../domain/entities/favourite_entity.dart';

class FavouriteModel extends FavouriteEntity {
  FavouriteModel({
    ResultEntity? resultEntity,
  }) : super(
          resultEntity: resultEntity!,
        );

  factory FavouriteModel.fromJson(Map<String, dynamic> json) => FavouriteModel(
        resultEntity: ResultModel.fromJson(json['result']),
      );
}

class ResultModel extends ResultEntity {
  ResultModel({
    bool? status,
    String? message,
    List<ResponseClinicsEntity>? responseClinicsEntity,
    List<ResponseServiceEntity>? responseServicesEntity,
  }) : super(
          status: status ?? false,
          message: message ?? '',
          responseClinics: responseClinicsEntity ?? [],
          responseServices: responseServicesEntity ?? [],
        );

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
        status: json['status'],
        message: json['massage'],
        responseClinicsEntity: json['clinics'] != null
            ? List<ResponseClinicsEntity>.from(
                json['clinics'].map((e) => ResponseClinicsModel.fromJson(e)))
            : List<ResponseClinicsEntity>.from(
                json['products'].map((e) => ResponseClinicsModel.fromJson(e))),
        responseServicesEntity: List<ResponseServiceEntity>.from(
            json['services'].map((e) => ResponseServiceModel.fromJson(e))),
      );
}

class ResponseClinicsModel extends ResponseClinicsEntity {
  const ResponseClinicsModel({
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

  factory ResponseClinicsModel.fromJson(Map<String, dynamic> json) =>
      ResponseClinicsModel(
        name: json['title'],
        city: json['city'],
        id: json['id'],
        image: json['image'] == false ? '' : json['image'],
        rate: double.parse(json['rating'].toString()),
        description: json['description'] == false ? '' : json['description'],
      );
}

class ResponseServiceModel extends ResponseServiceEntity {
  const ResponseServiceModel({
    int? id,
    String? name,
    String? image,
    String? description,
    double? rate,
  }) : super(
          id: id ?? 0,
          name: name ?? '',
          image: image ?? '',
          description: description ?? '',
          rate: rate ?? 0.0,
        );

  factory ResponseServiceModel.fromJson(Map<String, dynamic> json) =>
      ResponseServiceModel(
        name: json['title'],
        id: json['id'],
        image: json['image'] == false ? '' : json['image'],
        rate: double.parse(json['rating'].toString()),
        description: json['description'] == false ? '' : json['description'],
      );
}
