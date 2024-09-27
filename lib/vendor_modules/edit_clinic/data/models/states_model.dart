import '../../domain/entities/states_entity.dart';

class StatesModel extends StatesEntity {
  StatesModel({
    ResultEntity? resultEntity,
  }) : super(
          resultEntity: resultEntity!,
        );

  factory StatesModel.fromJson(Map<String, dynamic> json) => StatesModel(
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
    String? code,
  }) : super(
          id: id ?? 0,
          name: name ?? '',
          code: code ?? '',
        );

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        id: json['id'],
        name: json['name'],
        code: json['code'],
      );
}
