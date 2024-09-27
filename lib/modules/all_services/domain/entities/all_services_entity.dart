import 'package:equatable/equatable.dart';

class AllServicesEntity extends Equatable {
  final ResultEntity resultEntity;

  const AllServicesEntity({required this.resultEntity});

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
  final String name;
  final ClinicServiceEntity clinicServiceEntity;
  final String image;
  final String city;
  final double rate;
  final double price;
  final String description;

  const ResponseEntity({
    required this.id,
    required this.name,
    required this.clinicServiceEntity,
    required this.image,
    required this.city,
    required this.rate,
    required this.price,
    required this.description,
  });

  @override
  List<Object> get props => [
        id,
        name,
        image,
        city,
        rate,
        description,
      ];
}

class ClinicServiceEntity extends Equatable {
  final int id;
  final String name;

  const ClinicServiceEntity({required this.id, required this.name});

  @override
  List<Object> get props => [id, name];
}
