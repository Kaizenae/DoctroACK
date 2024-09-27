import '../../domain/entities/available_times_entity.dart';

class AvailableTimesModel extends AvailableTimesEntity {
  AvailableTimesModel({
    ResultEntity? resultEntity,
  }) : super(
          resultEntity: resultEntity!,
        );

  factory AvailableTimesModel.fromJson(Map<String, dynamic> json) =>
      AvailableTimesModel(
        resultEntity: ResultModel.fromJson(json['result']),
      );
}

class ResultModel extends ResultEntity {
  ResultModel({
    bool? status,
    String? message,
    List<ResponseEntity>? responseEntity,
  }) : super(
          status: status ?? false,
          message: message ?? '',
          response: responseEntity ?? [],
        );

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
        status: json['status'],
        message: json['message'],
        responseEntity: List<ResponseEntity>.from(
            json['result'].map((e) => ResponseModel.fromJson(e))),
      );
}

class ResponseModel extends ResponseEntity {
  const ResponseModel({
    int? serviceID,
    String? start,
    String? reservationDate,
    String? type,
    String? end,
  }) : super(
          serviceID: serviceID ?? 0,
          start: start ?? '00:00:00',
          reservationDate: reservationDate ?? '',
          type: type ?? '',
          end: end ?? '00:00:00',
        );

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        serviceID: json['service_id'],
        start: json['start'],
        end: json['end'],
        reservationDate: json['reservation_date'],
        type: json['type'],
      );
}
