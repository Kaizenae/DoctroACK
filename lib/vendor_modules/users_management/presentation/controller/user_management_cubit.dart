import 'package:dartz/dartz.dart';
import '../../../../../../core/utils/packages_imprts.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/users_entity.dart';
import '../../domain/usecases/users_usecase.dart';
import 'user_management_state.dart';

class UserManagementCubit extends Cubit<UserManagementState> {
  final UsersUsecase usersUsecase;
  UserManagementCubit({required this.usersUsecase})
      : super(UserManagementInitial());
  static UserManagementCubit get(context) => BlocProvider.of(context);

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  Future<void> getUsersFun() async {
    emit(GetUsersLoadingState());
    Either<Failure, UsersEntity> response = await usersUsecase(NoParams());
    refreshController.refreshCompleted();
    emit(response.fold((failure) {
      return GetUsersErrorState(message: failure.message);
    }, (usersEntity) {
      return GetUsersSuccessState(usersEntity: usersEntity);
    }));
  }
}
