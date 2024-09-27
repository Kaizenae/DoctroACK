import 'package:equatable/equatable.dart';

class TopServicesEntity extends Equatable {
  final ResultEntity resultEntity;

  const TopServicesEntity({required this.resultEntity});

  @override
  List<Object> get props => [resultEntity];
}

class ResultEntity extends Equatable {
  final bool status;
  final String message;
  final String image;
  final List<TopServiceEntity> response;

  const ResultEntity(
      {required this.status,
      required this.response,
      required this.message,
      required this.image});

  @override
  List<Object> get props => [status, response, message];
}

class TopServiceEntity extends Equatable {
  final String name;

  const TopServiceEntity({
    required this.name,
  });

  @override
  List<Object> get props => [name];
}
