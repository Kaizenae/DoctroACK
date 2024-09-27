import 'package:doctor_ack/core/general_entities/create_entity.dart';
import 'package:equatable/equatable.dart';

abstract class EditBankState extends Equatable {
  const EditBankState();
}

class EditBankInitial extends EditBankState {
  @override
  List<Object> get props => [];
}

class EditBankLoadingState extends EditBankState {
  @override
  List<Object> get props => [];
}

class EditBankSuccessState extends EditBankState {
  final CreateEntity createEntity;

  const EditBankSuccessState({required this.createEntity});
  @override
  List<Object> get props => [createEntity];
}

class EditBankErrorState extends EditBankState {
  final String message;

  const EditBankErrorState({required this.message});
  @override
  List<Object> get props => [message];
}
