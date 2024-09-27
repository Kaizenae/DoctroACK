import 'package:equatable/equatable.dart';

class ReviewsEntity extends Equatable {
  final ResultEntity resultEntity;

  const ReviewsEntity({required this.resultEntity});

  @override
  List<Object> get props => [resultEntity];
}

class ResultEntity extends Equatable {
  final bool status;
  final String message;
  final List<ResponseEntity> response;

  const ResultEntity(
      {required this.status, required this.response, required this.message});

  @override
  List<Object> get props => [status, response];
}

class ResponseEntity extends Equatable {
  final int id;
  final PatientData patient;
  final String reviewStar;
  final String description;
  final String date;
  final int clinicID;
  final ServiceData service;

  const ResponseEntity({
    required this.id,
    required this.patient,
    required this.reviewStar,
    required this.date,
    required this.description,
    required this.clinicID,
    required this.service,
  });

  @override
  List<Object> get props =>
      [id, patient, reviewStar, clinicID, service, description];
}

class PatientData extends Equatable {
  final int id;
  final String name;

  const PatientData({
    required this.id,
    required this.name,
  });

  @override
  List<Object> get props => [id, name];
}

class ServiceData extends Equatable {
  final int id;
  final String name;

  const ServiceData({
    required this.id,
    required this.name,
  });

  @override
  List<Object> get props => [
        id,
        name,
      ];
}
