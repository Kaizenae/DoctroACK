import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../core/utils/packages_imprts.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/entities/favourite_entity.dart';
import '../../../domain/use_cases/favourite_usecase.dart';

part 'favourites_state.dart';

class FavouritesCubit extends Cubit<FavouritesState> {
  final FavouriteUsecase favouriteUsecase;
  FavouritesCubit({required this.favouriteUsecase})
      : super(FavouritesInitial());

  static FavouritesCubit get(context) => BlocProvider.of(context);

  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  RefreshController refreshFavServicesController =
      RefreshController(initialRefresh: false);
  getFavourite() async {
    emit(GetFavouriteLoadingState());
    Either<Failure, FavouriteEntity> response =
        await favouriteUsecase(NoParams());
    refreshController.refreshCompleted();
    refreshFavServicesController.refreshCompleted();

    emit(response.fold(
        (failure) => GetFavouriteErrorState(message: failure.message),
        (favouriteEntity) =>
            GetFavouriteSuccessState(favouriteEntity: favouriteEntity)));
  }
}
