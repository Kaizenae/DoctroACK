import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/general_entities/create_entity.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/customers_entity.dart';
import '../entities/users_entity.dart';
import '../repositories/users_repository.dart';

class UsersUsecase implements UseCase<UsersEntity, NoParams> {
  final UsersRepository profileRepository;

  UsersUsecase(this.profileRepository);

  @override
  Future<Either<Failure, UsersEntity>> call(NoParams params) =>
      profileRepository.users(params);
}

class CustomersUsecase implements UseCase<CustomersEntity, NoParams> {
  final UsersRepository profileRepository;

  CustomersUsecase(this.profileRepository);

  @override
  Future<Either<Failure, CustomersEntity>> call(NoParams params) =>
      profileRepository.customers(params);
}

class ChangeUserRoleUsecase implements UseCase<CreateEntity, UserParams> {
  final UsersRepository profileRepository;

  ChangeUserRoleUsecase(this.profileRepository);

  @override
  Future<Either<Failure, CreateEntity>> call(UserParams params) =>
      profileRepository.changeUserRole(params);
}

class DeleteUserUsecase implements UseCase<CreateEntity, UserParams> {
  final UsersRepository profileRepository;

  DeleteUserUsecase(this.profileRepository);

  @override
  Future<Either<Failure, CreateEntity>> call(UserParams params) =>
      profileRepository.deleteUsers(params);
}
