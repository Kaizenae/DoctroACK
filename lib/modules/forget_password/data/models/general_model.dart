import '../../domain/entities/general_entity.dart';

class GeneralModel extends GeneralEntity {
  GeneralModel({ResultEntity? resultEntity})
      : super(generalEntity: resultEntity!);

  factory GeneralModel.fromJson(Map<String, dynamic> json) => GeneralModel(
        resultEntity: ResultModel.fromJson(json['result']),
      );

  Map<String, dynamic> toJson() => {
        "result": generalEntity,
      };
}

class ResultModel extends ResultEntity {
  const ResultModel({
    bool? status,
    String? message,
  }) : super(status: status ?? false, message: message ?? '');

  factory ResultModel.fromJson(Map<String, dynamic> json) =>
      ResultModel(status: json['status'], message: json['message']);

  Map<String, dynamic> toJson() => {
        "success": status,
        "message": message,
      };
}
