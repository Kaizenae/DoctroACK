import 'package:equatable/equatable.dart';

class SearchServicesEntity extends Equatable {
  final ResultEntity resultEntity;

  const SearchServicesEntity({required this.resultEntity});

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
  final String image;
  final String city;
  final double rate;
  final String description;

  const ResponseEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.city,
    required this.rate,
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
