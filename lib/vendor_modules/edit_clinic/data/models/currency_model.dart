import '../../domain/entities/currency_entity.dart';

class CurrencyModel extends CurrencyEntity {
  CurrencyModel({
    ResultEntity? resultEntity,
  }) : super(
          resultEntity: resultEntity!,
        );

  factory CurrencyModel.fromJson(Map<String, dynamic> json) => CurrencyModel(
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
    String? symbol,
  }) : super(
          id: id ?? 0,
          name: name ?? '',
          symbol: symbol ?? '',
        );

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        id: json['id'],
        name: json['name'],
        symbol: json['symbol'],
      );
}
