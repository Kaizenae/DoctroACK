import 'package:equatable/equatable.dart';

class AppointmentsEntity extends Equatable {
  final ResultEntity resultEntity;

  const AppointmentsEntity({required this.resultEntity});

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
  List<Object> get props => [status, response, message];
}

class ResponseEntity extends Equatable {
  /*
  *             "service_id": 2,
                "service_name": "Dental Care",
                "service_logo": "",
                "appointments":[
                "break_time": [
  * */
  final int serviceId;
  final String serviceName;
  final String serviceLogo;
  final List<AppointmentEntity> appointments;
  final List<BreakEntity> breakTime;

  const ResponseEntity({
    required this.serviceId,
    required this.serviceName,
    required this.serviceLogo,
    required this.appointments,
    required this.breakTime,
  });

  @override
  List<Object> get props => [
        serviceId,
        serviceName,
        serviceLogo,
        appointments,
        breakTime,
      ];
}

class AppointmentEntity extends Equatable {
  // "name": "3",
  // "id": 42,
  // "date": "2024-01-01",
  // "start_time": "14:00:00",
  // "end_time": "15:00:00"
  final int id;
  final String name;
  final String startTime;
  final String endTime;

  const AppointmentEntity({
    required this.id,
    required this.name,
    required this.startTime,
    required this.endTime,
  });

  @override
  List<Object> get props => [id, name, startTime, endTime];
}

class BreakEntity extends Equatable {
  // "day": "Monday",
  // "from": 12,
  // "to": 14
  final String day;
  final String from;
  final String to;

  const BreakEntity({
    required this.day,
    required this.from,
    required this.to,
  });

  @override
  List<Object> get props => [day, from, to];
}
