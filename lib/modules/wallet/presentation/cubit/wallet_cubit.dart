import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';
import '../../../../../../core/utils/packages_imprts.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/wallet_entity.dart';
import '../../domain/usecases/wallet_usecase.dart';
import 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  final WalletUsecase walletUsecase;
  WalletCubit({required this.walletUsecase}) : super(WalletInitial());

  static WalletCubit get(context) => BlocProvider.of(context);

  Future<void> getWalletFun() async {
    emit(GetWalletLoadingState());
    Either<Failure, WalletEntity> response = await walletUsecase(NoParams());

    emit(response.fold((failure) {
      return GetWalletErrorState(message: failure.message);
    }, (walletEntity) {
      return GetWalletSuccessState(walletEntity: walletEntity);
    }));
  }
}
