import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../core/utils/packages_imprts.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/general_entities/create_entity.dart';
import '../../../domain/use_cases/block_time_usecase.dart';

part 'block_time_state.dart';

class BlockTimeCubit extends Cubit<BlockTimeState> {
  final BlockTimeUsecase blockTimeUsecase;
  BlockTimeCubit({required this.blockTimeUsecase}) : super(BlockTimeInitial());

  static BlockTimeCubit get(context) => BlocProvider.of(context);

  String date = '';
  String time = '';
  int serviceID = 0;
  Future<void> blockTime() async {
    emit(BlockTimeLoadingState());
    Either<Failure, CreateEntity> response =
        await blockTimeUsecase(BlockTimeParams(
      serviceID: serviceID,
      date: date,
      time: time,
    ));

    emit(response
        .fold((failure) => BlockTimeErrorState(message: failure.message),
            (createEntity) {
      time = '';

      return BlockTimeSuccessState(createEntity: createEntity);
    }));
  }
}
