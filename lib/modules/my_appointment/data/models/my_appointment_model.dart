import '../../domain/entities/my_appointment_entity.dart';

class MyAppointmentModel extends MyAppointmentEntity {
  MyAppointmentModel({
    ResultEntity? resultEntity,
  }) : super(
          resultEntity: resultEntity!,
        );

  factory MyAppointmentModel.fromJson(Map<String, dynamic> json) =>
      MyAppointmentModel(
        resultEntity: ResultModel.fromJson(json['result']),
      );
}

class ResultModel extends ResultEntity {
  ResultModel({
    bool? status,
    String? message,
    List<AppointmentEntity>? responseAppointmentEntity,
    List<AppointmentPastEntity>? responsePastAppointmentEntity,
  }) : super(
          status: status ?? false,
          message: message ?? '',
          upComingAppointments: responseAppointmentEntity ?? [],
          pastAppointments: responsePastAppointmentEntity ?? [],
        );

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
        status: json['status'],
        message: json['massage'],
        responseAppointmentEntity: List<AppointmentEntity>.from(
            json['up_coming'].map((e) => AppointmentModel.fromJson(e))),
        responsePastAppointmentEntity: List<AppointmentPastEntity>.from(
            json['past'].map((e) => AppointmentPastModel.fromJson(e))),
      );
}

class AppointmentModel extends AppointmentEntity {
  AppointmentModel({
    int? id,
    String? name,
    String? clinicName,
    String? date,
    String? city,
    String? image,
    List<String>? advice,
    double? rate,
    int? numReviews,
  }) : super(
          id: id ?? 0,
          name: name ?? '',
          city: city ?? '',
          image: image ?? '',
          advice: advice ?? [],
          rate: rate ?? 0.0,
          clinicName: clinicName ?? '',
          date: date ?? '',
          numReviews: numReviews ?? 0,
        );

  factory AppointmentModel.fromJson(Map<String, dynamic> json) =>
      AppointmentModel(
        name: json['name'],
        city: json['city'],
        id: json['id'],
        image: json['icon'] == false ? '' : json['icon'],
        rate: json['rating']== false ? 0.0: double.parse(json['rating'].toString()),
        advice: json['advices'].cast<String>(),
        numReviews: json['num_reviews'],
        date: json['date'],
        clinicName: json['clinic'],
      );
}

class AppointmentPastModel extends AppointmentPastEntity {
  AppointmentPastModel({
    int? id,
    int? serviceId,
    String? name,
    String? clinicName,
    String? date,
    String? city,
    String? image,
    List<String>? advice,
    double? rate,
    bool? isRated,
    bool? isReviewed,
    int? numReviews,
  }) : super(
          id: id ?? 0,
          serviceId: serviceId ?? 0,
          name: name ?? '',
          city: city ?? '',
          image: image ?? '',
          advice: advice ?? [],
          rate: rate ?? 0.0,
          isRated: isRated ?? false,
          isReviewed: isReviewed ?? false,
          clinicName: clinicName ?? '',
          date: date ?? '',
          numReviews: numReviews ?? 0,
        );

  factory AppointmentPastModel.fromJson(Map<String, dynamic> json) =>
      AppointmentPastModel(
        name: json['name'],
        city: json['city'],
        id: json['id'],
        serviceId: json['service_id'] == false ? 0 : json['service_id'],
        isRated: json['rated'],
        isReviewed: json['reviewed'],
        image: json['icon'] == false ? '' : json['icon'],
        rate: double.parse(json['rating'].toString()),
        advice: json['advices'].cast<String>(),
        numReviews: json['num_reviews'],
        date: json['date'],
        clinicName: json['clinic'],
      );
}
