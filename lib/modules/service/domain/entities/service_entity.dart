import 'package:equatable/equatable.dart';

class ServiceEntity extends Equatable {
  final ResultEntity resultEntity;

  const ServiceEntity({required this.resultEntity});

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
  final int reviews;
  final double discount;
  final int clinicID;
  final double priceWithDiscount;
  final double priceWithoutDiscount;
  final String name;
  final String icon;
  final String city;
  final double rate;
  final double appointmentDuration;
  final String description;
  final List<String> notification;
  final bool favourite;
  final int maxScheduleDays;
  final String clinicName;

  final List<WorkingDaysEntity> workingDays;
  final List<DoctorEntity> doctors;
  final List<String> advice;

  const ResponseEntity({
    required this.id,
    required this.reviews,
    required this.discount,
    required this.priceWithDiscount,
    required this.priceWithoutDiscount,
    required this.clinicID,
    required this.icon,
    required this.clinicName,
    required this.favourite,
    required this.name,
    required this.city,
    required this.appointmentDuration,
    required this.workingDays,
    required this.doctors,
    required this.rate,
    required this.description,
    required this.notification,
    required this.advice,
    required this.maxScheduleDays,
  });

  @override
  List<Object> get props => [
        id,
        clinicID,
        priceWithDiscount,
        priceWithoutDiscount,
        name,
        icon,
        rate,
        appointmentDuration,
        description,
        notification,
        maxScheduleDays,
        workingDays
      ];
}

class WorkingDaysEntity extends Equatable {
  final String id;

  final String name;
  final String day;

  const WorkingDaysEntity({
    required this.id,
    required this.name,
    required this.day,
  });

  @override
  List<Object> get props => [id, name, day];
}

class DoctorEntity extends Equatable {
  final int id;

  final String name;

  const DoctorEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object> get props => [id, name];
}
