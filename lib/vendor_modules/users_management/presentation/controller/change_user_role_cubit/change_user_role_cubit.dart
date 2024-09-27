import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/general_entities/create_entity.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';
import 'package:doctor_ack/languages/locale_keys.g.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../core/utils/packages_imprts.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/usecases/users_usecase.dart';

part 'change_user_role_state.dart';

class ChangeUserRoleCubit extends Cubit<ChangeUserRoleState> {
  final ChangeUserRoleUsecase changeUserRoleUsecase;
  final DeleteUserUsecase deleteUserUsecase;

  ChangeUserRoleCubit({
    required this.changeUserRoleUsecase,
    required this.deleteUserUsecase,
  }) : super(ChangeUserRoleInitial());

  static ChangeUserRoleCubit get(context) => BlocProvider.of(context);

  int userId = 0;

  Future<void> changeUserRoleFun() async {
    emit(ChangeUserLoadingState());
    Either<Failure, CreateEntity> response = await changeUserRoleUsecase(
        UserParams(userID: userId, role: roleValue));
    emit(response.fold((failure) {
      return ChangeUserErrorState(message: failure.message);
    }, (createEntity) {
      return ChangeUserSuccessState(createEntity: createEntity);
    }));
  }

  Future<void> deleteUserFun() async {
    emit(DeleteUserLoadingState());
    Either<Failure, CreateEntity> response =
        await deleteUserUsecase(UserParams(userID: userId));
    emit(response.fold((failure) {
      return DeleteUserErrorState(message: failure.message);
    }, (createEntity) {
      return DeleteUserSuccessState(createEntity: createEntity);
    }));
  }

  String roleValue = '';
  List<Map<String, dynamic>> roleModel = [
    {"name": LocaleKeys.admin.tr(), "id": 'admin'},
    {"name": LocaleKeys.manager.tr(), "id": 'manager'},
    {
      "name": LocaleKeys.receptionist.tr(),
      "id": 'receptionist',
    },
    {
      "name": LocaleKeys.doctor.tr(),
      "id": 'doctor',
    },
  ];

  selectRole(String val) {
    emit(SelectRoleLoadingState());
    roleValue = val;
    emit(SelectRoleState());
  }
}
