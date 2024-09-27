import 'package:doctor_ack/core/general_entities/create_entity.dart';
import 'package:equatable/equatable.dart';

abstract class ServicesState extends Equatable {
  const ServicesState();
}

class ServicesInitial extends ServicesState {
  @override
  List<Object> get props => [];
}

class EditServiceLoadingState extends ServicesState {
  @override
  List<Object> get props => [];
}

class EditServiceSuccessState extends ServicesState {
  final CreateEntity createEntity;

  const EditServiceSuccessState({required this.createEntity});
  @override
  List<Object> get props => [];
}

class EditServiceErrorState extends ServicesState {
  final String message;

  const EditServiceErrorState({required this.message});
  @override
  List<Object> get props => [];
}

class SelectSortLoadingState extends ServicesState {
  @override
  List<Object> get props => [];
}

class ChangeImageState extends ServicesState {
  @override
  List<Object> get props => [];
}

class SelectSortState extends ServicesState {
  @override
  List<Object> get props => [];
}

class SelectFilterLoadingState extends ServicesState {
  @override
  List<Object> get props => [];
}

class SelectFilterState extends ServicesState {
  @override
  List<Object> get props => [];
}
