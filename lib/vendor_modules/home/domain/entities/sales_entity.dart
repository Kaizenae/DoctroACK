import 'package:equatable/equatable.dart';

class SalesEntity extends Equatable {
  final ResultEntity resultEntity;

  const SalesEntity({required this.resultEntity});

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
  List<Object> get props => [status, response, message];
}

class ResponseEntity extends Equatable {
  final ReportEntity report1;
  final ReportEntity report2;
  final ReportEntity report3;

  const ResponseEntity({
    required this.report1,
    required this.report2,
    required this.report3,
  });

  @override
  List<Object> get props => [
        report1,
        report2,
        report3,
      ];
}

class ReportEntity extends Equatable {
  // "name": "30 days",
  // "sales": 0,
  // "currency": "",
  // "appointments": 0
  final int appointments;
  final String name;
  final double sales;
  final String currency;

  const ReportEntity({
    required this.appointments,
    required this.name,
    required this.sales,
    required this.currency,
  });

  @override
  List<Object> get props => [appointments, name, sales, currency];
}
