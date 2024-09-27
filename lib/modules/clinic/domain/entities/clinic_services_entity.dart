import 'package:equatable/equatable.dart';

class ClinicServicesEntity extends Equatable {
  final ResultEntity resultEntity;

  const ClinicServicesEntity({required this.resultEntity});

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
  final int clinicID;
  final double price;
  final String name;
  final String icon;
  final double rate;
  final String description;

  const ResponseEntity({
    required this.id,
    required this.price,
    required this.clinicID,
    required this.icon,
    required this.name,
    required this.rate,
    required this.description,
  });

  @override
  List<Object> get props => [
        id,
        clinicID,
        price,
        name,
        icon,
        rate,
        description,
      ];
}
