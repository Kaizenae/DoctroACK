import 'package:equatable/equatable.dart';

class FavouriteEntity extends Equatable {
  final ResultEntity resultEntity;

  const FavouriteEntity({required this.resultEntity});

  @override
  List<Object> get props => [resultEntity];
}

class ResultEntity extends Equatable {
  final bool status;
  final String message;
  final List<ResponseClinicsEntity> responseClinics;
  final List<ResponseServiceEntity> responseServices;

  const ResultEntity(
      {required this.status,
      required this.responseClinics,
      required this.responseServices,
      required this.message});

  @override
  List<Object> get props => [status, responseClinics, responseServices];
}

class ResponseClinicsEntity extends Equatable {
  final int id;
  final String name;
  final String image;
  final String city;
  final double rate;
  final String description;

  const ResponseClinicsEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.city,
    required this.rate,
    required this.description,
  });

  @override
  List<Object> get props => [id, name, image, city, rate, description];
}

class ResponseServiceEntity extends Equatable {
  final int id;
  final String name;
  final String image;
  final double rate;
  final String description;

  const ResponseServiceEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.rate,
    required this.description,
  });

  @override
  List<Object> get props => [id, name, image, rate, description];
}
