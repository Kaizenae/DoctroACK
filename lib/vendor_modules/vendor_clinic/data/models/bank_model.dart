import '../../domain/entities/bank_entity.dart';

class BankModel extends BankEntity {
  BankModel({
    ResultEntity? resultEntity,
  }) : super(
          resultEntity: resultEntity!,
        );

  factory BankModel.fromJson(Map<String, dynamic> json) => BankModel(
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
          response: responseEntity!,
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
    String? bankName,
    String? holderName,
    String? iban,
    String? holderNumber,
    String? currency,
  }) : super(
          bankName: bankName ?? '',
          currency: currency ?? '',
          holderName: holderName ?? '',
          iban: iban ?? '',
          holderNumber: holderNumber ?? '',
        );

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        bankName: json['bank_name'],
        currency: json['currency'],
        iban: json['iban'] == false ? '' : json['iban'],
        holderName: json['account_holder_name'],
        holderNumber: json['account_number'],
      );
}
