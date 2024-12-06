import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../forget_password/domain/entities/general_entity.dart';
import '../repositories/edit_profile_repository.dart';

class EditProfileUsecase implements UseCase<GeneralEntity, EditProfileParams> {
  final EditProfileRepository editProfileRepository;

  EditProfileUsecase(this.editProfileRepository);

  @override
  Future<Either<Failure, GeneralEntity>> call(EditProfileParams params) =>
      editProfileRepository.editProfile(params);
}

class DeleteUserAccountUsecase implements UseCase<GeneralEntity, NoParams> {
  final EditProfileRepository userRepository;

  DeleteUserAccountUsecase(this.userRepository);

  @override
  Future<Either<Failure, GeneralEntity>> call(NoParams params) =>
      userRepository.deleteUserAccount(params);
}
