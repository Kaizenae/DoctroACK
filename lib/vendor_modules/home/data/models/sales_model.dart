import '../../domain/entities/sales_entity.dart';

class SalesModel extends SalesEntity {
  SalesModel({
    ResultEntity? resultEntity,
  }) : super(
          resultEntity: resultEntity!,
        );

  factory SalesModel.fromJson(Map<String, dynamic> json) => SalesModel(
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
    ReportEntity? report1,
    ReportEntity? report2,
    ReportEntity? report3,
  }) : super(
          report1: report1!,
          report2: report2!,
          report3: report3!,
        );

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        report1: ReportModel.fromJson(json['report1']),
        report2: ReportModel.fromJson(json['report2']),
        report3: ReportModel.fromJson(json['report3']),
      );
}

class ReportModel extends ReportEntity {
  const ReportModel({
    int? appointments,
    String? name,
    double? sales,
    String? currency,
  }) : super(
          appointments: appointments ?? 0,
          name: name ?? '',
          sales: sales ?? 0.0,
          currency: currency ?? '',
        );

  factory ReportModel.fromJson(Map<String, dynamic> json) => ReportModel(
        appointments: json['appointments'],
        name: json['name'],
        sales: double.parse(json['sales'].toString()),
        currency: json['currency'],
      );
}
