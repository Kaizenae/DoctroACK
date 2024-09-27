import '../../domain/entities/categories_entity.dart';

class CategoriesModel extends CategoriesEntity {
  CategoriesModel({
    ResultEntity? resultEntity,
  }) : super(
          resultEntity: resultEntity!,
        );

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(
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
    String? name,
    String? icon,
  }) : super(
          id: id ?? 0,
          name: name ?? '',
          icon: icon ?? '',
        );

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        name: json['name'],
        id: json['id'],
        icon: json['icon'],
      );
}
