import '../../domain/entities/banks_entity.dart';

class BanksModel extends BanksEntity {
  BanksModel({
    ResultEntity? resultEntity,
  }) : super(
          resultEntity: resultEntity!,
        );

  factory BanksModel.fromJson(Map<String, dynamic> json) => BanksModel(
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
            response: responseEntity ?? [],
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
  }) : super(
          id: id ?? 0,
          name: name ?? '',
        );

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        id: json['id'],
        name: json['name'],
      );
}
