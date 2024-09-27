import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/general_entities/create_entity.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/block_time_repository.dart';

class BlockTimeUsecase implements UseCase<CreateEntity, BlockTimeParams> {
  final BlockTimeRepository blockTimeRepository;

  BlockTimeUsecase(this.blockTimeRepository);

  @override
  Future<Either<Failure, CreateEntity>> call(BlockTimeParams params) =>
      blockTimeRepository.blockTime(params);
}
