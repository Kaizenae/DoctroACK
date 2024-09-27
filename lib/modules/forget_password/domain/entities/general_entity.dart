import 'package:equatable/equatable.dart';

class GeneralEntity extends Equatable {
  final ResultEntity generalEntity;

  const GeneralEntity({required this.generalEntity});

  @override
  List<Object?> get props => [generalEntity];
}

class ResultEntity extends Equatable {
  final bool status;
  final String message;

  const ResultEntity({
    required this.status,
    required this.message,
  });

  @override
  List<Object?> get props => [status, message];
}
