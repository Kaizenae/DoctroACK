import 'package:equatable/equatable.dart';

class AdvancedCustomersEntity extends Equatable {
  final ResultEntity resultEntity;

  const AdvancedCustomersEntity({required this.resultEntity});

  @override
  List<Object> get props => [resultEntity];
}

class ResultEntity extends Equatable {
  final bool status;
  final String message;
  final List<AdvancedCustomerEntity> response;

  const ResultEntity(
      {required this.status, required this.response, required this.message});

  @override
  List<Object> get props => [status, response, message];
}

class AdvancedCustomerEntity extends Equatable {
  final String hour;
  final String number;

  const AdvancedCustomerEntity({
    required this.hour,
    required this.number,
  });

  @override
  List<Object> get props => [hour, number];
}
