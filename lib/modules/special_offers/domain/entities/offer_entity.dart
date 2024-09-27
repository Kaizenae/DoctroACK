import 'package:equatable/equatable.dart';

class OfferEntity extends Equatable {
  final ResultEntity resultEntity;

  const OfferEntity({required this.resultEntity});

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
  final int serviceId;
  final String title;
  final String description;
  final String image;

  const ResponseEntity(
      {required this.id,
      required this.serviceId,
      required this.title,
      required this.description,
      required this.image});

  @override
  List<Object> get props => [id, serviceId, title, description, image];
}
