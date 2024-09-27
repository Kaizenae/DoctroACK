import '../../domain/entities/service_entity.dart';

class ServiceModel extends ServiceEntity {
  ServiceModel({
    ResultEntity? resultEntity,
  }) : super(
          resultEntity: resultEntity!,
        );

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
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
    int? reviews,
    double? discount,
    String? clinicID,
    double? price,
    String? name,
    String? city,
    String? icon,
    bool? favourite,
    double? rate,
    double? appointmentDuration,
    String? description,
    List<String>? notification,
    List<WorkingDaysEntity>? workingDays,
    List<DoctorEntity>? doctors,
    List<String>? advice,
    int? maxScheduleDays,
  }) : super(
          id: id ?? 0,
          reviews: reviews ?? 0,
          discount: discount ?? 0.0,
          clinicID: clinicID ?? '',
          price: price ?? 0.0,
          name: name ?? "",
          city: city ?? "",
          icon: icon ?? "",
          favourite: favourite ?? false,
          rate: rate ?? 0.0,
          appointmentDuration: appointmentDuration ?? 0.0,
          description: description ?? '',
          notification: notification ?? [],
          workingDays: workingDays ?? [],
          doctors: doctors ?? [],
          advice: advice ?? [],
          maxScheduleDays: maxScheduleDays ?? 0,
        );

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        name: json['name'],
        reviews: json['reviews'],
        id: json['id'],
        favourite: json['favourite'],
        discount: double.parse(json['discount'].toString()),
        clinicID: json['clinic_id'] == false ? '' : json['clinic_id'],
        price: json['price'],
        city: json['city'],
        icon: json['icon'] == false ? '' : json['icon'],
        rate: json['rating'],
        maxScheduleDays: json['max_schedule_days'],
        advice: json['advice'].cast<String>(),
        appointmentDuration: json['appointment_duration'],
        workingDays: List<WorkingDaysEntity>.from(
            json['working_days'].map((e) => WorkingDaysModel.fromJson(e))),
        doctors: List<DoctorEntity>.from(
            json['doctors'].map((e) => DoctorModel.fromJson(e))),
        description: json['description'] == false ? '' : json['description'],
        notification: List.from(json['notification']),
      );
}

class WorkingDaysModel extends WorkingDaysEntity {
  const WorkingDaysModel({
    String? id,
    String? name,
    String? day,
  }) : super(
          id: id ?? '0',
          name: name ?? "",
          day: day ?? "",
        );

  factory WorkingDaysModel.fromJson(Map<String, dynamic> json) =>
      WorkingDaysModel(
        name: json['name'],
        id: json['id'],
        day: json['day'] == false ? '' : json['day'],
      );
}

class DoctorModel extends DoctorEntity {
  const DoctorModel({
    int? id,
    String? name,
  }) : super(
          id: id ?? 0,
          name: name ?? "",
        );

  factory DoctorModel.fromJson(Map<String, dynamic> json) => DoctorModel(
        name: json['name'],
        id: json['id'],
      );
}
