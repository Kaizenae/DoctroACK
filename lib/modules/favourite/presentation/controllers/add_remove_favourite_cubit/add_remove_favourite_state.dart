import 'package:doctor_ack/core/general_entities/create_entity.dart';
import 'package:equatable/equatable.dart';

abstract class AddRemoveFavouritesState extends Equatable {
  const AddRemoveFavouritesState();
}

class AddRemoveFavouritesInitial extends AddRemoveFavouritesState {
  @override
  List<Object> get props => [];
}

class AddRemoveFavouriteLoadingState extends AddRemoveFavouritesState {
  @override
  List<Object> get props => [];
}

class AddRemoveFavouriteSuccessState extends AddRemoveFavouritesState {
  final CreateEntity createEntity;

  const AddRemoveFavouriteSuccessState({required this.createEntity});

  @override
  List<Object> get props => [createEntity];
}

class AddRemoveFavouriteErrorState extends AddRemoveFavouritesState {
  final String message;

  const AddRemoveFavouriteErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
