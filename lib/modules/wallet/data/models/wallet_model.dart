import '../../domain/entities/wallet_entity.dart';

class WalletModel extends WalletEntity {
  WalletModel({
    ResultEntity? resultEntity,
  }) : super(
          resultEntity: resultEntity!,
        );

  factory WalletModel.fromJson(Map<String, dynamic> json) => WalletModel(
        resultEntity: ResultModel.fromJson(json['result']),
      );
}

class ResultModel extends ResultEntity {
  const ResultModel({
    bool? status,
    String? message,
    double? balance,
  }) : super(
            status: status ?? false,
            balance: balance ?? 0.0,
            message: message ?? '');

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
        status: json['status'],
        balance: double.parse(json['balance'].toString()),
        message: json['message'],
      );
}
