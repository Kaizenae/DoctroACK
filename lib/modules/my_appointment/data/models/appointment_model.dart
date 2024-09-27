import '../../domain/entities/appointment_entity.dart';

class UserAppointmentModel extends UserAppointmentEntity {
  UserAppointmentModel({
    ResultEntity? resultEntity,
  }) : super(
          resultEntity: resultEntity!,
        );

  factory UserAppointmentModel.fromJson(Map<String, dynamic> json) =>
      UserAppointmentModel(
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
          message: message ?? '',
          response: responseEntity!,
        );

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
        status: json['status'],
        message: json['message'],
        responseEntity: ResponseModel.fromJson(json['result']),
      );
}

class ResponseModel extends ResponseEntity {
  ResponseModel({
    int? id,
    String? clinicName,
    String? name,
    String? service,
    int? serviceId,
    String? city,
    String? icon,
    double? rate,
    String? appointmentDate,
    String? doctor,
    List<String>? notification,
    String? aboutDoctor,
    List<String>? advice,
  }) : super(
          id: id ?? 0,
          serviceId: serviceId ?? 0,
          clinicName: clinicName ?? '',
          service: service ?? '',
          name: name ?? "",
          city: city ?? "",
          icon: icon ?? "",
          rate: rate ?? 0.0,
          appointmentDate: appointmentDate ?? '',
          aboutDoctor: aboutDoctor ?? '',
          doctor: doctor ?? '',
          notification: notification ?? [],
          advice: advice ?? [],
        );

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        name: json['name'],
        id: json['id'],
        clinicName: json['clinic'] == false ? '' : json['clinic'],
        city: json['city'],
        icon: json['icon'] == false ? '' : json['icon'],
        rate: json['rating'],
        advice: json['advices'].cast<String>(),
        appointmentDate: json['appointment_date'],
        service: json['service'],
        serviceId: json['service_id'],
        doctor: json['doctor'],
        notification: List.from(json['notification']),
        aboutDoctor: json['about_doctor'] == false ? '' : json['about_doctor'],
      );
}
