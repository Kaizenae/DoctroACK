import '../../domain/entities/top_services_entity.dart';

class TopServicesModel extends TopServicesEntity {
  TopServicesModel({
    ResultEntity? resultEntity,
  }) : super(
          resultEntity: resultEntity!,
        );

  factory TopServicesModel.fromJson(Map<String, dynamic> json) =>
      TopServicesModel(
        resultEntity: ResultModel.fromJson(json['result']),
      );
}

class ResultModel extends ResultEntity {
  ResultModel({
    bool? status,
    String? message,
    String? image,
    List<TopServiceEntity>? advancedCustomerEntity,
  }) : super(
          status: status ?? false,
          response: advancedCustomerEntity ?? [],
          message: message ?? '',
          image: image ?? '',
        );

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
        status: json['status'],
        advancedCustomerEntity: List<TopServiceEntity>.from(
            json['result'].map((e) => TopServiceModel.fromJson(e))),
        message: json['message'],
        image: json['img'] == false ? '' : json['img'],
      );
}

class TopServiceModel extends TopServiceEntity {
  const TopServiceModel({
    String? name,
  }) : super(
          name: name ?? '',
        );

  factory TopServiceModel.fromJson(Map<String, dynamic> json) =>
      TopServiceModel(
        name: json['name'],
      );
}
