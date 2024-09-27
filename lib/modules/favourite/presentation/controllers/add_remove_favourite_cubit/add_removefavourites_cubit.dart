import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/general_entities/create_entity.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';
import '../../../../../../core/utils/packages_imprts.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/use_cases/favourite_usecase.dart';
import 'add_remove_favourite_state.dart';

class AddRemoveFavouritesCubit extends Cubit<AddRemoveFavouritesState> {
  final AddRemoveFavouriteUsecase favouriteUsecase;

  AddRemoveFavouritesCubit({required this.favouriteUsecase})
      : super(AddRemoveFavouritesInitial());

  static AddRemoveFavouritesCubit get(context) => BlocProvider.of(context);

  int id = 0;
  bool isClinic = false;
  String endpoint = '';

  addRemoveFavourite() async {
    emit(AddRemoveFavouriteLoadingState());
    Either<Failure, CreateEntity> response = await favouriteUsecase(
        FavouriteParams(id: id, isClinic: isClinic, endpoint: endpoint));

    emit(response.fold(
        (failure) => AddRemoveFavouriteErrorState(message: failure.message),
        (createEntity) =>
            AddRemoveFavouriteSuccessState(createEntity: createEntity)));
  }
}
