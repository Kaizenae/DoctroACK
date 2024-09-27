import '../../domain/entities/finances_entity.dart';

class FinancesModel extends FinancesEntity {
  FinancesModel({
    ResultEntity? resultEntity,
  }) : super(
          resultEntity: resultEntity!,
        );

  factory FinancesModel.fromJson(Map<String, dynamic> json) => FinancesModel(
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
            response: responseEntity!,
            message: message ?? '');

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
        status: json['status'],
        responseEntity: ResponseModel.fromJson(json['result']),
        message: json['message'],
      );
}

class ResponseModel extends ResponseEntity {
  ResponseModel({
    String? nextPayoutDate,
    List<FinanceEntity>? financeEntity,
  }) : super(
          nextPayoutDate: nextPayoutDate ?? '',
          financeEntity: financeEntity ?? [],
        );

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        nextPayoutDate: json['next_payout_date'],
        financeEntity: List<FinanceEntity>.from(
            json['result'].map((e) => FinanceModel.fromJson(e))),
      );
}

class FinanceModel extends FinanceEntity {
  const FinanceModel({
    int? paymentId,
    String? paymentName,
    double? amount,
    String? currency,
    String? date,
    String? pdf,
  }) : super(
          paymentId: paymentId ?? 0,
          paymentName: paymentName ?? '',
          amount: amount ?? 0.0,
          currency: currency ?? '',
          date: date ?? '',
          pdf: pdf ?? '',
        );

  factory FinanceModel.fromJson(Map<String, dynamic> json) => FinanceModel(
        paymentId: json['payment_id'],
        paymentName: json['payment_name'],
        amount: json['amount'],
        currency: json['currency'],
        date: json['date'],
        pdf: json['pdf'],
      );
}
