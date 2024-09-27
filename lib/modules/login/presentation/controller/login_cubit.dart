import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/utils/packages_imprts.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/usecases/login_usecase.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUsecase loginUsecase;
  LoginCubit({required this.loginUsecase}) : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> loginFun() async {
    emit(LoginLoadingState());
    Either<Failure, LoginEntity> response = await loginUsecase(LoginParams(
      email: emailController.text,
      password: passwordController.text,
    ));

    emit(response.fold((failure) => LoginErrorState(message: failure.message),
        (loginEntity) => LoginSuccessState(loginEntity: loginEntity)));
  }

  String suffix = IconAssets.hide;
  bool isPassword = true;

  // LoginModel? loginModel;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    if (isPassword) {
      suffix = IconAssets.hide;
      emit(LoginChangePasswordVisibilityState());
    } else {
      suffix = IconAssets.hidden2;
      emit(LoginChangePasswordVisibilityState1());
    }
  }
}
