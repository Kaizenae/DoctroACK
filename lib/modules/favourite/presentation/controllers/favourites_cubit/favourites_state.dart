part of 'favourites_cubit.dart';

abstract class FavouritesState extends Equatable {
  const FavouritesState();
}

class FavouritesInitial extends FavouritesState {
  @override
  List<Object> get props => [];
}

class GetFavouriteLoadingState extends FavouritesState {
  @override
  List<Object> get props => [];
}

class GetFavouriteSuccessState extends FavouritesState {
  final FavouriteEntity favouriteEntity;

  const GetFavouriteSuccessState({required this.favouriteEntity});

  @override
  List<Object> get props => [favouriteEntity];
}

class GetFavouriteErrorState extends FavouritesState {
  final String message;

  const GetFavouriteErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
