import 'package:equatable/equatable.dart';

class CreateEntity extends Equatable {
  final ResultEntity resultEntity;

  const CreateEntity({required this.resultEntity});

  @override
  List<Object> get props => [resultEntity];
}

class ResultEntity extends Equatable {
  final bool status;
  final String message;

  const ResultEntity({required this.status, required this.message});

  @override
  List<Object> get props => [status, message];
}
