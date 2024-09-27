import 'package:equatable/equatable.dart';

class ClinicEntity extends Equatable {
  final ResultEntity resultEntity;

  const ClinicEntity({required this.resultEntity});

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
  final double lat;
  final double long;
  final String description;
  final bool favourite;

  final String createdAt;
  final String updatedAt;
  final List<ClinicServiceEntity> services;

  const ResponseEntity({
    required this.id,
    required this.numPatient,
    required this.expertise,
    required this.numExperience,
    required this.address,
    required this.phone,
    required this.icon,
    required this.name,
    required this.favourite,
    required this.image,
    required this.rate,
    required this.lat,
    required this.long,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.services,
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
        lat,
        long,
        description,
        createdAt,
        updatedAt,
        services,
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

class ClinicServiceEntity extends Equatable {
  final int id;
  final double discount;
  final String name;
  final String icon;
  final double rate;
  final double price;
  final String description;

  const ClinicServiceEntity({
    required this.id,
    required this.discount,
    required this.price,
    required this.icon,
    required this.name,
    required this.rate,
    required this.description,
  });

  @override
  List<Object> get props => [
        id,
        name,
        icon,
        rate,
        description,
      ];
}
