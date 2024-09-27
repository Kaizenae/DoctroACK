import '../../domain/entities/appointments_entity.dart';

class AppointmentsModel extends AppointmentsEntity {
  AppointmentsModel({
    ResultEntity? resultEntity,
  }) : super(
          resultEntity: resultEntity!,
        );

  factory AppointmentsModel.fromJson(Map<String, dynamic> json) =>
      AppointmentsModel(
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
            response: responseEntity ?? [],
            message: message ?? '');

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
        status: json['status'],
        responseEntity: List<ResponseEntity>.from(
            json['result'].map((e) => ResponseModel.fromJson(e))),
        message: json['message'],
      );
}

class ResponseModel extends ResponseEntity {
  ResponseModel({
    int? serviceId,
    String? serviceName,
    String? serviceLogo,
    List<AppointmentEntity>? appointments,
    List<BreakEntity>? breakTime,
  }) : super(
          serviceId: serviceId ?? 0,
          serviceName: serviceName ?? '',
          serviceLogo: serviceLogo ?? '',
          appointments: appointments ?? [],
          breakTime: breakTime ?? [],
        );

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        serviceId: json['service_id'],
        serviceName: json['service_name'],
        serviceLogo: json['service_logo'],
        appointments: List<AppointmentEntity>.from(
            json['appointments'].map((e) => AppointmentModel.fromJson(e))),
        breakTime: List<BreakEntity>.from(
            json['break_time'].map((e) => BreakModel.fromJson(e))),
      );
}

class AppointmentModel extends AppointmentEntity {
  const AppointmentModel({
    int? id,
    String? name,
    String? startTime,
    String? endTime,
  }) : super(
          id: id ?? 0,
          name: name ?? '',
          startTime: startTime ?? '',
          endTime: endTime ?? '',
        );

  factory AppointmentModel.fromJson(Map<String, dynamic> json) =>
      AppointmentModel(
        id: json['id'],
        name: json['name'],
        startTime: json['start'],
        endTime: json['end'],
      );
}

class BreakModel extends BreakEntity {
  const BreakModel({
    String? day,
    String? from,
    String? to,
  }) : super(
          day: day ?? '',
          from: from ?? '',
          to: to ?? '',
        );

  factory BreakModel.fromJson(Map<String, dynamic> json) => BreakModel(
        day: json['day'],
        from: json['from'],
        to: json['to'],
      );
}
