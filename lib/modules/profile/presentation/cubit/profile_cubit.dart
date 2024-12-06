import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/utils/packages_imprts.dart';
import '../../../../../core/utils/assets_manager.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/routes_manager.dart';
import '../../../../languages/locale_keys.g.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/usecases/profile_usecase.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileUsecase profileUsecase;
  ProfileCubit({required this.profileUsecase}) : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);

  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  Future<void> getProfileFun() async {
    emit(GetProfileLoadingState());
    Either<Failure, ProfileEntity> response = await profileUsecase(NoParams());
    refreshController.refreshCompleted();
    emit(response.fold((failure) {
      userId = null;
      return GetProfileErrorState(message: failure.message);
    }, (profileEntity) {
      userId = null;
      return GetProfileSuccessState(profileEntity: profileEntity);
    }));
  }

  final List<String> iconName = [
    IconAssets.editProfile,
    IconAssets.wallet,
    IconAssets.lock,
    IconAssets.language,
    IconAssets.privacy,
    IconAssets.terms,
    IconAssets.contactUs,
    IconAssets.logout,
  ];
  final List<String> name = [
    LocaleKeys.editProfile,
    LocaleKeys.wallet,
    LocaleKeys.changePassword,
    LocaleKeys.language,
    LocaleKeys.privacyPolicy,
    LocaleKeys.termsAndConditions,
    LocaleKeys.contactUs,
    LocaleKeys.logout,
  ];
  final List<String> routeName = [
    Routes.editProfileRoute,
    Routes.walletRoute,
    Routes.changePasswordRoute,
    'null',
    'null',
    'null',
    Routes.contactUsRoute,
    'null',
  ];
  int? userId;
  ImagePicker imagePicker = ImagePicker();

  Future<void> logout(BuildContext context) async {
    // await  CacheHelper.removeData(key: AppStrings.token);
    // await  CacheHelper.removeData(key: AppStrings.cachedLogin);
    // await  CacheHelper.removeData(key: AppStrings.cachedRegister);
    // await  CacheHelper.removeData(key: AppStrings.admin);
    // await  CacheHelper.removeData(key: AppStrings.company);
    //
    // AppConstants.token = CacheHelper.get(key: AppStrings.token) ?? 0;
    // AppConstants.admin = CacheHelper.get(key: AppStrings.admin) ?? false;
    // AppConstants.companyId = CacheHelper.get(key: AppStrings.company) ?? 0;

    emit(LogoutState());
  }

  formatDate({required String format, required String dateTime}) {
    var date = DateFormat(format);
    var formatDate = date.format(DateTime.parse(dateTime));
    return formatDate;
  }
}
