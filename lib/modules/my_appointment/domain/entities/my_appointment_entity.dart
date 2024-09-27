import 'package:equatable/equatable.dart';

class MyAppointmentEntity extends Equatable {
  final ResultEntity resultEntity;

  const MyAppointmentEntity({required this.resultEntity});

  @override
  List<Object> get props => [resultEntity];
}

class ResultEntity extends Equatable {
  final bool status;
  final String message;
  final List<AppointmentEntity> upComingAppointments;
  final List<AppointmentPastEntity> pastAppointments;

  const ResultEntity(
      {required this.status,
      required this.upComingAppointments,
      required this.pastAppointments,
      required this.message});

  @override
  List<Object> get props => [status, upComingAppointments, pastAppointments];
}

class AppointmentEntity extends Equatable {
  final int id;
  final String name;
  final String clinicName;
  final String image;
  final String date;
  final String city;
  final double rate;
  final int numReviews;
  final List<String> advice;

  const AppointmentEntity({
    required this.id,
    required this.name,
    required this.clinicName,
    required this.image,
    required this.date,
    required this.numReviews,
    required this.city,
    required this.rate,
    required this.advice,
  });

  @override
  List<Object> get props => [
        id,
        name,
        clinicName,
        image,
        date,
        city,
        rate,
        numReviews,
        advice,
      ];
}

class AppointmentPastEntity extends Equatable {
  final int id;
  final int serviceId;
  final String name;
  final String clinicName;
  final String image;
  final String date;
  final String city;
  final double rate;
  final bool isRated;
  final bool isReviewed;
  final int numReviews;
  final List<String> advice;

  const AppointmentPastEntity({
    required this.id,
    required this.serviceId,
    required this.name,
    required this.clinicName,
    required this.image,
    required this.date,
    required this.numReviews,
    required this.city,
    required this.rate,
    required this.isRated,
    required this.isReviewed,
    required this.advice,
  });

  @override
  List<Object> get props => [
        id,
        serviceId,
        name,
        clinicName,
        image,
        date,
        city,
        rate,
        isRated,
        isReviewed,
        numReviews,
        advice,
      ];
}
