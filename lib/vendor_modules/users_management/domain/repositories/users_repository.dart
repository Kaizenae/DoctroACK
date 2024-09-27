import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/general_entities/create_entity.dart';
import 'package:doctor_ack/vendor_modules/users_management/domain/entities/customers_entity.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/users_entity.dart';

abstract class UsersRepository {
  Future<Either<Failure, UsersEntity>> users(NoParams params);
  Future<Either<Failure, CustomersEntity>> customers(NoParams params);
  Future<Either<Failure, CreateEntity>> changeUserRole(UserParams params);
  Future<Either<Failure, CreateEntity>> deleteUsers(UserParams params);
}
