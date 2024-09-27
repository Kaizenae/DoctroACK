import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../forget_password/domain/entities/general_entity.dart';
import '../repositories/contact_us_repository.dart';

class ContactUsUsecase implements UseCase<GeneralEntity, ContactUsParams> {
  final ContactUsRepository contactUsRepository;

  ContactUsUsecase(this.contactUsRepository);

  @override
  Future<Either<Failure, GeneralEntity>> call(ContactUsParams params) =>
      contactUsRepository.contactUs(params);
}
