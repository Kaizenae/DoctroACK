import '../../domain/entities/check_payment_entity.dart';

class CheckPaymentModel extends CheckPaymentEntity {
  CheckPaymentModel({
    ResultEntity? resultEntity,
  }) : super(
          resultEntity: resultEntity!,
        );

  factory CheckPaymentModel.fromJson(Map<String, dynamic> json) =>
      CheckPaymentModel(
        resultEntity: ResultModel.fromJson(json['result']),
      );
}

class ResultModel extends ResultEntity {
  const ResultModel({
    bool? status,
    String? message,
    bool? paymentStatus,
  }) : super(
          status: status ?? false,
          message: message ?? '',
          paymentStatus: paymentStatus ?? false,
        );

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
        status: json['status'],
        message: json['message'],
        paymentStatus: json['payment_status'],
      );
}
