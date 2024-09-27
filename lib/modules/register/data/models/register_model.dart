import '../../domain/entities/register_entity.dart';

class RegisterModel extends RegisterEntity {
  RegisterModel({ResultEntity? resultEntity})
      : super(resultEntity: resultEntity!);

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        resultEntity: ResultModel.fromJson(json['result']),
      );

  Map<String, dynamic> toJson() => {
        "result": resultEntity,
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
