import '../../domain/entities/advanced_sales_entity.dart';

class AdvancedSalesModel extends AdvancedSalesEntity {
  AdvancedSalesModel({
    ResultEntity? resultEntity,
  }) : super(
          resultEntity: resultEntity!,
        );

  factory AdvancedSalesModel.fromJson(Map<String, dynamic> json) =>
      AdvancedSalesModel(
        resultEntity: ResultModel.fromJson(json['result']),
      );
}

class ResultModel extends ResultEntity {
  ResultModel({
    bool? status,
    String? message,
    List<AdvancedSaleEntity>? advancedSaleEntity,
  }) : super(
            status: status ?? false,
            response: advancedSaleEntity ?? [],
            message: message ?? '');

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
        status: json['status'],
        advancedSaleEntity: List<AdvancedSaleEntity>.from(
            json['result'].map((e) => AdvancedSaleModel.fromJson(e))),
        message: json['message'],
      );
}

class AdvancedSaleModel extends AdvancedSaleEntity {
  const AdvancedSaleModel({
    String? date,
    double? amount,
  }) : super(
          date: date ?? '',
          amount: amount ?? 0.0,
        );

  factory AdvancedSaleModel.fromJson(Map<String, dynamic> json) =>
      AdvancedSaleModel(
        date: json['date'],
        amount: json['amount'],
      );
}
