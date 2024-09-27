import 'package:doctor_ack/core/general_entities/create_entity.dart';

class CreateModel extends CreateEntity {
  CreateModel({
    ResultEntity? resultEntity,
  }) : super(
          resultEntity: resultEntity!,
        );

  factory CreateModel.fromJson(Map<String, dynamic> json) => CreateModel(
        resultEntity: ResultModel.fromJson(json['result']),
      );
}

class ResultModel extends ResultEntity {
  const ResultModel({
    bool? status,
    String? message,
  }) : super(
          status: status ?? false,
          message: message ?? '',
        );

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
        status: json['status'],
        message: json['message'],
      );
}
