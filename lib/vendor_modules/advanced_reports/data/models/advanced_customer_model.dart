import '../../domain/entities/advanced_customers_entity.dart';

class AdvancedCustomersModel extends AdvancedCustomersEntity {
  AdvancedCustomersModel({
    ResultEntity? resultEntity,
  }) : super(
          resultEntity: resultEntity!,
        );

  factory AdvancedCustomersModel.fromJson(Map<String, dynamic> json) =>
      AdvancedCustomersModel(
        resultEntity: ResultModel.fromJson(json['result']),
      );
}

class ResultModel extends ResultEntity {
  ResultModel({
    bool? status,
    String? message,
    List<AdvancedCustomerEntity>? advancedCustomerEntity,
  }) : super(
            status: status ?? false,
            response: advancedCustomerEntity ?? [],
            message: message ?? '');

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
        status: json['status'],
        advancedCustomerEntity: List<AdvancedCustomerEntity>.from(
            json['report'].map((e) => AdvancedCustomerModel.fromJson(e))),
        message: json['message'],
      );
}

class AdvancedCustomerModel extends AdvancedCustomerEntity {
  const AdvancedCustomerModel({
    String? hour,
    String? number,
  }) : super(
          hour: hour ?? '',
          number: number ?? '',
        );

  factory AdvancedCustomerModel.fromJson(Map<String, dynamic> json) =>
      AdvancedCustomerModel(
        hour: json['hour'] ?? json['day'],
        number: json['num'],
      );
}
