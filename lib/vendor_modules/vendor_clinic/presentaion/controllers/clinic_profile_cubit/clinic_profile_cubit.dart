import 'package:dartz/dartz.dart';
import 'package:doctor_ack/core/usecases/usecase.dart';
import 'package:doctor_ack/vendor_modules/vendor_clinic/domain/entities/clinic_profile_entity.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../core/utils/packages_imprts.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/utils/assets_manager.dart';
import '../../../../../core/utils/routes_manager.dart';
import '../../../../../languages/locale_keys.g.dart';
import '../../../domain/use_cases/clinic_profile_usecase.dart';

part 'clinic_profile_state.dart';

class VendorClinicCubit extends Cubit<ClinicProfileState> {
  final ClinicProfileUsecase clinicProfileUsecase;
  VendorClinicCubit({
    required this.clinicProfileUsecase,
  }) : super(ClinicProfileInitial());
  static VendorClinicCubit get(context) => BlocProvider.of(context);

  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  RefreshController refreshAboutController =
      RefreshController(initialRefresh: false);
  Future<void> getClinicProfile() async {
    emit(ClinicProfileLoadingState());
    Either<Failure, ClinicProfileEntity> response =
        await clinicProfileUsecase(NoParams());
    refreshController.refreshCompleted();
    refreshAboutController.refreshCompleted();

    emit(response
        .fold((failure) => ClinicProfileErrorState(message: failure.message),
            (clinicProfileEntity) {
      return ClinicProfileSuccessState(
          clinicProfileEntity: clinicProfileEntity);
    }));
  }

  final List<String> iconName = [
    IconAssets.editProfile,
    IconAssets.ratingIcons,
    IconAssets.bank,
    IconAssets.finances,
    IconAssets.userManagement,
    IconAssets.language,
    IconAssets.privacy,
    IconAssets.terms,
    IconAssets.contactUs,
    IconAssets.aboutUs,
    IconAssets.logout,
    IconAssets.delete,
  ];
  final List<String> name = [
    LocaleKeys.editProfile,
    LocaleKeys.ratingAndReviews,
    LocaleKeys.bankDetails,
    LocaleKeys.finances,
    LocaleKeys.userManagement,
    LocaleKeys.language,
    LocaleKeys.privacyPolicy,
    LocaleKeys.termsAndConditions,
    LocaleKeys.contactUs,
    LocaleKeys.aboutUs,
    LocaleKeys.logout,
    LocaleKeys.delete,
  ];
  final List<String> routeName = [
    Routes.editClinicRoute,
    Routes.clinicReviewsRoute,
    Routes.bankRoute,
    Routes.financesRoute,
    Routes.userManagementRoute,
    'null',
    'null',
    'null',
    Routes.contactUsRoute,
    Routes.aboutUSRoute,
    'null',
    'null',
  ];

  bool isPressed = false;
  int value = 1;
  List<Map<String, dynamic>> serviceModel = [
    {
      "name": "Botox near problem areas",
      "logo": ImageNetwork.clinicLogo,
      "price": "170",
      "rate": "4.5",
      "id": 1
    },
    {
      "name": "Hair removal, by laser or electrolysis",
      "logo": ImageNetwork.clinicLogo,
      "price": "140",
      "id": 2,
      "rate": "3.5"
    },
    {
      "name": "Wrinkle reduction",
      "logo": ImageNetwork.clinicLogo,
      "price": "300",
      "id": 3,
      "rate": "4.8"
    },
  ];

  selectService(int val) {
    emit(SelectServiceLoadingState());
    value = val;
    emit(SelectServiceState());
  }
}
