import 'package:equatable/equatable.dart';

class AvailableTimesEntity extends Equatable {
  final ResultEntity resultEntity;

  const AvailableTimesEntity({required this.resultEntity});

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
  final int serviceID;
  final String start;
  final String reservationDate;
  final String type;
  final String end;

  const ResponseEntity({
    required this.start,
    required this.serviceID,
    required this.type,
    required this.reservationDate,
    required this.end,
  });

  @override
  List<Object> get props => [
        serviceID,
        start,
        reservationDate,
        type,
        end,
      ];
}
