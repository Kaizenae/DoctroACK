import 'package:equatable/equatable.dart';

class UserAppointmentEntity extends Equatable {
  final ResultEntity resultEntity;

  const UserAppointmentEntity({required this.resultEntity});

  @override
  List<Object> get props => [resultEntity];
}

class ResultEntity extends Equatable {
  final bool status;
  final String message;
  final ResponseEntity response;

  const ResultEntity(
      {required this.status, required this.response, required this.message});

  @override
  List<Object> get props => [status, response];
}

class ResponseEntity extends Equatable {
  final int id;
  final String clinicName;
  final String name;
  final String service;
  final int serviceId;
  final String icon;
  final String city;
  final double rate;
  final String appointmentDate;
  final String doctor;
  final String aboutDoctor;
  final List<String> notification;
  final List<String> advice;

  const ResponseEntity({
    required this.id,
    required this.service,
    required this.serviceId,
    required this.aboutDoctor,
    required this.clinicName,
    required this.icon,
    required this.name,
    required this.city,
    required this.appointmentDate,
    required this.doctor,
    required this.notification,
    required this.rate,
    required this.advice,
  });

  @override
  List<Object> get props => [
        id,
        clinicName,
        name,
        service,
        serviceId,
        icon,
        city,
        rate,
        appointmentDate,
        doctor,
        aboutDoctor,
        notification,
        advice,
      ];
}
