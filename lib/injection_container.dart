import 'package:doctor_ack/modules/all_clinics/presentation/controllers/all_featured_clinics_cubit/all_featured_clinics_cubit.dart';
import 'package:doctor_ack/modules/all_services/presentation/controllers/all_clinics_cubit/all_services_cubit.dart';
import 'package:doctor_ack/modules/clinic/presentaion/controllers/check_payment_cubit/check_payment_cubit.dart';
import 'package:doctor_ack/modules/reviews/presentation/manager/controllers/reviews_cubit/reviews_cubit.dart';
import 'package:doctor_ack/vendor_modules/edit_clinic/presentation/manager/states_cubit/states_cubit.dart';

import 'injection_imports.dart';
import 'modules/user/data/datasources/user_datasource.dart';
import 'modules/user/data/repositories/user_repository_impl.dart';
import 'modules/user/domain/repositories/user_repository.dart';
import 'modules/user/domain/usecases/user_usecase.dart';
import 'modules/user/presentation/controllers/users_cubit/users_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features

  //********************************************// Blocs \\*************************************\\
  sl.registerLazySingleton<UsersCubit>(() => UsersCubit(
      sendNotificationUsecase: sl(),
      updateNoTokenUsecase: sl(),
      deleteUserAccountUsecase: sl()));

  sl.registerLazySingleton<LoginCubit>(() => LoginCubit(loginUsecase: sl()));
  sl.registerLazySingleton<RegisterCubit>(
      () => RegisterCubit(registerUsecase: sl()));
  sl.registerLazySingleton<ForgetPasswordCubit>(() => ForgetPasswordCubit(
        sendOTPUsecase: sl(),
        verifyOTPUsecase: sl(),
        newPasswordUsecase: sl(),
      ));
  sl.registerLazySingleton<ChangePasswordCubit>(() => ChangePasswordCubit(
        changePasswordUsecase: sl(),
      ));
  sl.registerLazySingleton<ProfileCubit>(() => ProfileCubit(
        profileUsecase: sl(),
      ));
  sl.registerLazySingleton<EditProfileCubit>(() => EditProfileCubit(
        editProfileUsecase: sl(),
      ));
  sl.registerLazySingleton<WalletCubit>(() => WalletCubit(
        walletUsecase: sl(),
      ));
  sl.registerLazySingleton<ContactUsCubit>(() => ContactUsCubit(
        contactUsUsecase: sl(),
      ));

  sl.registerLazySingleton<GetCategoriesCubit>(
      () => GetCategoriesCubit(categoriesUsecase: sl()));
  sl.registerLazySingleton<AllClinicsCubit>(
      () => AllClinicsCubit(allClinicsUsecase: sl()));
  sl.registerLazySingleton<AllServicesCubit>(
      () => AllServicesCubit(allServicesUsecase: sl()));
  sl.registerLazySingleton<AllFeaturedClinicsCubit>(
      () => AllFeaturedClinicsCubit(allClinicsUsecase: sl()));
  sl.registerLazySingleton<ClinicCubit>(() => ClinicCubit(clinicUsecase: sl()));
  sl.registerLazySingleton<ClinicServicesCubit>(
      () => ClinicServicesCubit(clinicServicesUsecase: sl()));
  sl.registerLazySingleton<ServiceCubit>(
      () => ServiceCubit(serviceUsecase: sl()));
  sl.registerLazySingleton<OfferCubit>(() => OfferCubit(offerUsecase: sl()));

  sl.registerLazySingleton<AvailableTimesCubit>(
      () => AvailableTimesCubit(availableTimesUsecase: sl()));
  sl.registerLazySingleton<CreateReservationOrderCubit>(
      () => CreateReservationOrderCubit(createReservationOrderUsecase: sl()));
  sl.registerLazySingleton<ReviewsCubit>(
      () => ReviewsCubit(reviewsUsecase: sl()));
  sl.registerLazySingleton<CreateReviewsCubit>(
      () => CreateReviewsCubit(reviewsUsecase: sl()));
  sl.registerLazySingleton<FavouritesCubit>(
      () => FavouritesCubit(favouriteUsecase: sl()));
  sl.registerLazySingleton<AddRemoveFavouritesCubit>(
      () => AddRemoveFavouritesCubit(favouriteUsecase: sl()));
  sl.registerLazySingleton<MyAppointmentsCubit>(
      () => MyAppointmentsCubit(myAppointmentUsecase: sl()));
  sl.registerLazySingleton<AppointmentCubit>(
      () => AppointmentCubit(appointmentUsecase: sl()));
  sl.registerLazySingleton<CancelChangeAppointmentsCubit>(() =>
      CancelChangeAppointmentsCubit(
          cancelAppointmentUsecase: sl(), changeAppointmentUsecase: sl()));
  sl.registerLazySingleton<SearchServicesCubit>(
      () => SearchServicesCubit(searchServicesUsecase: sl()));

  sl.registerLazySingleton<VendorClinicCubit>(
      () => VendorClinicCubit(clinicProfileUsecase: sl()));

  sl.registerLazySingleton<EditClinicCubit>(
      () => EditClinicCubit(editClinicProfileUsecase: sl()));

  sl.registerLazySingleton<BankCubit>(() => BankCubit(bankUsecase: sl()));

  sl.registerLazySingleton<UserManagementCubit>(
      () => UserManagementCubit(usersUsecase: sl()));

  sl.registerLazySingleton<ChangeUserRoleCubit>(() => ChangeUserRoleCubit(
      deleteUserUsecase: sl(), changeUserRoleUsecase: sl()));

  sl.registerLazySingleton<CustomersCubit>(
      () => CustomersCubit(customersUsecase: sl()));

  sl.registerLazySingleton<BlockTimeCubit>(
      () => BlockTimeCubit(blockTimeUsecase: sl()));

  sl.registerLazySingleton<ServicesCubit>(
      () => ServicesCubit(editServiceUsecase: sl()));

  sl.registerLazySingleton<FinancesCubit>(
      () => FinancesCubit(financesUsecase: sl()));

  sl.registerLazySingleton<SalesCubit>(() => SalesCubit(salesUsecase: sl()));

  sl.registerLazySingleton<CurrencyCubit>(
      () => CurrencyCubit(currencyUsecase: sl()));

  sl.registerLazySingleton<BanksCubit>(() => BanksCubit(banksUsecase: sl()));

  sl.registerLazySingleton<EditBankCubit>(
      () => EditBankCubit(editBankUsecase: sl()));

  sl.registerLazySingleton<AppointmentsCubit>(
      () => AppointmentsCubit(appointmentsUsecase: sl()));

  sl.registerLazySingleton<AdvancedSalesCubit>(
      () => AdvancedSalesCubit(advancedSalesUsecase: sl()));

  sl.registerLazySingleton<AdvancedCustomersCubit>(
      () => AdvancedCustomersCubit(advancedCustomersUsecase: sl()));

  sl.registerLazySingleton<TopServicesCubit>(
      () => TopServicesCubit(topServicesUsecase: sl()));

  sl.registerLazySingleton<TagsCubit>(() => TagsCubit(tagsUsecase: sl()));
  sl.registerLazySingleton<CheckPaymentCubit>(
      () => CheckPaymentCubit(checkPaymentUsecase: sl()));
  sl.registerLazySingleton<StatesCubit>(() => StatesCubit(statesUsecase: sl()));

  //***************************************// Use cases \\********************************************\\
  sl.registerLazySingleton<SendNotificationUsecase>(
      () => SendNotificationUsecase(sl()));
  sl.registerLazySingleton<UpdateNoTokenUsecase>(
      () => UpdateNoTokenUsecase(sl()));
  sl.registerLazySingleton<DeleteUserAccountUsecase>(
      () => DeleteUserAccountUsecase(sl()));

  sl.registerLazySingleton<LoginUsecase>(() => LoginUsecase(sl()));
  sl.registerLazySingleton<RegisterUsecase>(() => RegisterUsecase(sl()));
  sl.registerLazySingleton<SendOTPUsecase>(() => SendOTPUsecase(sl()));
  sl.registerLazySingleton<VerifyOTPUsecase>(() => VerifyOTPUsecase(sl()));
  sl.registerLazySingleton<NewPasswordUsecase>(() => NewPasswordUsecase(sl()));
  sl.registerLazySingleton<ChangePasswordUsecase>(
      () => ChangePasswordUsecase(sl()));
  sl.registerLazySingleton<ProfileUsecase>(() => ProfileUsecase(sl()));
  sl.registerLazySingleton<EditProfileUsecase>(() => EditProfileUsecase(sl()));
  sl.registerLazySingleton<WalletUsecase>(() => WalletUsecase(sl()));
  sl.registerLazySingleton<ContactUsUsecase>(() => ContactUsUsecase(sl()));

  sl.registerLazySingleton<CategoriesUsecase>(() => CategoriesUsecase(sl()));
  sl.registerLazySingleton<AllClinicsUsecase>(() => AllClinicsUsecase(sl()));
  sl.registerLazySingleton<AllServicesUsecase>(() => AllServicesUsecase(sl()));
  sl.registerLazySingleton<ClinicUsecase>(() => ClinicUsecase(sl()));
  sl.registerLazySingleton<ClinicServicesUsecase>(
      () => ClinicServicesUsecase(sl()));
  sl.registerLazySingleton<ServiceUsecase>(() => ServiceUsecase(sl()));
  sl.registerLazySingleton<OfferUsecase>(() => OfferUsecase(sl()));

  sl.registerLazySingleton<AvailableTimesUsecase>(
      () => AvailableTimesUsecase(sl()));
  sl.registerLazySingleton<CreateReservationOrderUsecase>(
      () => CreateReservationOrderUsecase(sl()));
  sl.registerLazySingleton<ReviewsUsecase>(() => ReviewsUsecase(sl()));
  sl.registerLazySingleton<CreateReviewsUsecase>(
      () => CreateReviewsUsecase(sl()));
  sl.registerLazySingleton<FavouriteUsecase>(() => FavouriteUsecase(sl()));
  sl.registerLazySingleton<AddRemoveFavouriteUsecase>(
      () => AddRemoveFavouriteUsecase(sl()));
  sl.registerLazySingleton<MyAppointmentUsecase>(
      () => MyAppointmentUsecase(sl()));
  sl.registerLazySingleton<AppointmentUsecase>(() => AppointmentUsecase(sl()));
  sl.registerLazySingleton<CancelAppointmentUsecase>(
      () => CancelAppointmentUsecase(sl()));
  sl.registerLazySingleton<ChangeAppointmentUsecase>(
      () => ChangeAppointmentUsecase(sl()));
  sl.registerLazySingleton<SearchServicesUsecase>(
      () => SearchServicesUsecase(sl()));

  sl.registerLazySingleton<ClinicProfileUsecase>(
      () => ClinicProfileUsecase(sl()));

  sl.registerLazySingleton<EditClinicProfileUsecase>(
      () => EditClinicProfileUsecase(sl()));

  sl.registerLazySingleton<BankUsecase>(() => BankUsecase(sl()));

  sl.registerLazySingleton<UsersUsecase>(() => UsersUsecase(sl()));

  sl.registerLazySingleton<ChangeUserRoleUsecase>(
      () => ChangeUserRoleUsecase(sl()));

  sl.registerLazySingleton<DeleteUserUsecase>(() => DeleteUserUsecase(sl()));

  sl.registerLazySingleton<CustomersUsecase>(() => CustomersUsecase(sl()));
  sl.registerLazySingleton<BlockTimeUsecase>(() => BlockTimeUsecase(sl()));
  sl.registerLazySingleton<EditServiceUsecase>(() => EditServiceUsecase(sl()));
  sl.registerLazySingleton<FinancesUsecase>(() => FinancesUsecase(sl()));
  sl.registerLazySingleton<SalesUsecase>(() => SalesUsecase(sl()));
  sl.registerLazySingleton<CurrencyUsecase>(() => CurrencyUsecase(sl()));
  sl.registerLazySingleton<BanksUsecase>(() => BanksUsecase(sl()));
  sl.registerLazySingleton<EditBankUsecase>(() => EditBankUsecase(sl()));
  sl.registerLazySingleton<AppointmentsUsecase>(
      () => AppointmentsUsecase(sl()));
  sl.registerLazySingleton<AdvancedSalesUsecase>(
      () => AdvancedSalesUsecase(sl()));
  sl.registerLazySingleton<AdvancedCustomersUsecase>(
      () => AdvancedCustomersUsecase(sl()));
  sl.registerLazySingleton<TopServicesUsecase>(() => TopServicesUsecase(sl()));
  sl.registerLazySingleton<TagsUsecase>(() => TagsUsecase(sl()));
  sl.registerLazySingleton<CheckPaymentUsecase>(
      () => CheckPaymentUsecase(sl()));
  sl.registerLazySingleton<StatesUsecase>(() => StatesUsecase(sl()));

  //*******************************************// Repository \\****************************************\\
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
        userRemoteDataSource: sl(),
        networkInfo: sl(),
      ));

  sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(
        loginLocalDataSource: sl(),
        loginRemoteDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<RegisterRepository>(() => RegisterRepositoryImpl(
        registerLocalDataSource: sl(),
        registerRemoteDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<ForgetPasswordRepository>(
      () => ForgetPasswordRepositoryImpl(
            forgetPasswordRemoteDataSource: sl(),
            networkInfo: sl(),
          ));
  sl.registerLazySingleton<ChangePasswordRepository>(
      () => ChangePasswordRepositoryImpl(
            changePasswordRemoteDataSource: sl(),
            networkInfo: sl(),
          ));
  sl.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl(
        profileRemoteDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<EditProfileRepository>(
      () => EditProfileRepositoryImpl(
            editProfileRemoteDataSource: sl(),
            networkInfo: sl(),
          ));
  sl.registerLazySingleton<WalletRepository>(() => WalletRepositoryImpl(
        walletRemoteDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<ContactUsRepository>(() => ContactUsRepositoryImpl(
        contactUsRemoteDataSource: sl(),
        networkInfo: sl(),
      ));

  sl.registerLazySingleton<CategoriesRepository>(() => CategoriesRepositoryImpl(
        categoriesRemoteDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<AllClinicsRepository>(() => AllClinicsRepositoryImpl(
        allClinicsRemoteDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<AllServicesRepository>(
      () => AllServicesRepositoryImpl(
            allClinicsRemoteDataSource: sl(),
            networkInfo: sl(),
          ));
  sl.registerLazySingleton<ServiceRepository>(() => ServiceRepositoryImpl(
        clinicRemoteDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<OfferRepository>(() => OfferRepositoryImpl(
        offerRemoteDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<ClinicRepository>(() => ClinicRepositoryImpl(
        clinicRemoteDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<ReviewsRepository>(() => ReviewsRepositoryImpl(
        reviewsRemoteDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<FavouriteRepository>(() => FavouriteRepositoryImpl(
        favouriteRemoteDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<MyAppointmentRepository>(
      () => MyAppointmentRepositoryImpl(
            myAppointmentRemoteDataSource: sl(),
            networkInfo: sl(),
          ));
  sl.registerLazySingleton<SearchServicesRepository>(
      () => SearchServicesRepositoryImpl(
            allClinicsRemoteDataSource: sl(),
            networkInfo: sl(),
          ));

  sl.registerLazySingleton<ClinicProfileRepository>(
      () => ClinicProfileRepositoryImpl(
            clinicRemoteDataSource: sl(),
            networkInfo: sl(),
          ));

  sl.registerLazySingleton<UsersRepository>(() => UsersRepositoryImpl(
        profileRemoteDataSource: sl(),
        networkInfo: sl(),
      ));

  sl.registerLazySingleton<BlockTimeRepository>(() => BlockTimeRepositoryImpl(
        blockTimeRemoteDataSource: sl(),
        networkInfo: sl(),
      ));

  sl.registerLazySingleton<EditServiceRepository>(
      () => EditServiceRepositoryImpl(
            editServiceRemoteDataSource: sl(),
            networkInfo: sl(),
          ));

  sl.registerLazySingleton<FinancesRepository>(() => FinancesRepositoryImpl(
        financesRemoteDataSource: sl(),
        networkInfo: sl(),
      ));

  sl.registerLazySingleton<SalesRepository>(() => SalesRepositoryImpl(
        salesRemoteDataSource: sl(),
        networkInfo: sl(),
      ));

  sl.registerLazySingleton<BankRepository>(() => BankRepositoryImpl(
        currencyRemoteDataSource: sl(),
        networkInfo: sl(),
      ));

  sl.registerLazySingleton<AppointmentsRepository>(
      () => AppointmentsRepositoryImpl(
            appointmentsRemoteDataSource: sl(),
            networkInfo: sl(),
          ));

  sl.registerLazySingleton<AdvancedReportRepository>(
      () => AdvancedReportRepositoryImpl(
            advancedReportRemoteDataSource: sl(),
            networkInfo: sl(),
          ));
  //*************************************************// Data Sources \\***********************************\\
  sl.registerLazySingleton<UserRemoteDataSource>(() => UserRemoteDataSourceImpl(
        apiConsumer: sl(),
      ));

  sl.registerLazySingleton<LoginRemoteDataSource>(
      () => LoginRemoteDataSourceImpl(
            apiConsumer: sl(),
          ));
  sl.registerLazySingleton<LoginLocalDataSource>(() => LoginLocalDataSourceImpl(
        sharedPreferences: sl(),
      ));
  sl.registerLazySingleton<RegisterRemoteDataSource>(
      () => RegisterRemoteDataSourceImpl(
            apiConsumer: sl(),
          ));
  sl.registerLazySingleton<RegisterLocalDataSource>(
      () => RegisterLocalDataSourceImpl(
            sharedPreferences: sl(),
          ));

  sl.registerLazySingleton<ForgetPasswordRemoteDataSource>(
      () => ForgetPasswordRemoteDataSourceImpl(
            apiConsumer: sl(),
          ));

  sl.registerLazySingleton<ChangePasswordRemoteDataSource>(
      () => ChangePasswordRemoteDataSourceImpl(
            apiConsumer: sl(),
          ));

  sl.registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(
            apiConsumer: sl(),
          ));

  sl.registerLazySingleton<EditProfileRemoteDataSource>(
      () => EditProfileRemoteDataSourceImpl(
            apiConsumer: sl(),
          ));

  sl.registerLazySingleton<WalletRemoteDataSource>(
      () => WalletRemoteDataSourceImpl(
            apiConsumer: sl(),
          ));

  sl.registerLazySingleton<ContactUsRemoteDataSource>(
      () => ContactUsRemoteDataSourceImpl(
            apiConsumer: sl(),
          ));

  sl.registerLazySingleton<CategoriesRemoteDataSource>(
      () => CategoriesRemoteDataSourceImpl(
            apiConsumer: sl(),
          ));
  sl.registerLazySingleton<AllClinicsRemoteDataSource>(
      () => AllClinicsRemoteDataSourceImpl(
            apiConsumer: sl(),
          ));
  sl.registerLazySingleton<AllServicesRemoteDataSource>(
      () => AllServicesRemoteDataSourceImpl(
            apiConsumer: sl(),
          ));
  sl.registerLazySingleton<ServiceRemoteDataSource>(
      () => ServiceRemoteDataSourceImpl(
            apiConsumer: sl(),
          ));
  sl.registerLazySingleton<OfferRemoteDataSource>(
      () => OfferRemoteDataSourceImpl(
            apiConsumer: sl(),
          ));
  sl.registerLazySingleton<ClinicRemoteDataSource>(
      () => ClinicRemoteDataSourceImpl(
            apiConsumer: sl(),
          ));
  sl.registerLazySingleton<ReviewsRemoteDataSource>(
      () => ReviewsRemoteDataSourceImpl(
            apiConsumer: sl(),
          ));
  sl.registerLazySingleton<FavouriteRemoteDataSource>(
      () => FavouriteRemoteDataSourceImpl(
            apiConsumer: sl(),
          ));
  sl.registerLazySingleton<MyAppointmentRemoteDataSource>(
      () => MyAppointmentRemoteDataSourceImpl(
            apiConsumer: sl(),
          ));
  sl.registerLazySingleton<SearchServicesRemoteDataSource>(
      () => SearchServicesRemoteDataSourceImpl(
            apiConsumer: sl(),
          ));

  sl.registerLazySingleton<ClinicProfileRemoteDataSource>(
      () => ClinicProfileRemoteDataSourceImpl(
            apiConsumer: sl(),
          ));

  sl.registerLazySingleton<UsersRemoteDataSource>(
      () => UsersRemoteDataSourceImpl(
            apiConsumer: sl(),
          ));

  sl.registerLazySingleton<BlockTimeRemoteDataSource>(
      () => BlockTimeRemoteDataSourceImpl(
            apiConsumer: sl(),
          ));

  sl.registerLazySingleton<EditServiceRemoteDataSource>(
      () => EditServiceRemoteDataSourceImpl(
            apiConsumer: sl(),
          ));

  sl.registerLazySingleton<FinancesRemoteDataSource>(
      () => FinancesRemoteDataSourceImpl(
            apiConsumer: sl(),
          ));

  sl.registerLazySingleton<SalesRemoteDataSource>(
      () => SalesRemoteDataSourceImpl(
            apiConsumer: sl(),
          ));

  sl.registerLazySingleton<BankRemoteDataSource>(() => BankRemoteDataSourceImpl(
        apiConsumer: sl(),
      ));

  sl.registerLazySingleton<AppointmentsRemoteDataSource>(
      () => AppointmentsRemoteDataSourceImpl(
            apiConsumer: sl(),
          ));

  sl.registerLazySingleton<AdvancedReportDataSource>(
      () => AdvancedReportRemoteDataSourceImpl(
            apiConsumer: sl(),
          ));

  //!*************************************************// Core \\********************************************\\
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => AppInterceptors());
  sl.registerLazySingleton(() => LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
      error: true));
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => Dio());
}
