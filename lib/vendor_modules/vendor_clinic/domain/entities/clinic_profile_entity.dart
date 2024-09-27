import 'package:equatable/equatable.dart';

class ClinicProfileEntity extends Equatable {
  final ResultEntity resultEntity;

  const ClinicProfileEntity({required this.resultEntity});

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
  final int numExperience;
  final int numPatient;
  final String expertise;
  final AddressEntity address;
  final String phone;
  final String name;
  final String image;
  final String icon;
  final double rate;
  final String description;
  const ResponseEntity({
    required this.id,
    required this.numPatient,
    required this.expertise,
    required this.numExperience,
    required this.address,
    required this.phone,
    required this.icon,
    required this.name,
    required this.image,
    required this.rate,
    required this.description,
  });

  @override
  List<Object> get props => [
        id,
        numExperience,
        numPatient,
        address,
        name,
        image,
        icon,
        rate,
        description,
      ];
}

class AddressEntity extends Equatable {
  final String street;
  final String city;
  final String state;
  final String country;

  const AddressEntity(
      {required this.street,
      required this.city,
      required this.state,
      required this.country});

  @override
  List<Object> get props => [street, city, state, country];
}
