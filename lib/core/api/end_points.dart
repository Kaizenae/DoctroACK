class EndPoints {
  static const String baseUrl = 'https://';
  // LIVE URL
//   static const String odooBaseUrl = 'doctorack.odoo.com/api/';
  //   LIVE DATABASE
//   static const String database = 'doctorack-doctorack-main-10272173';
// TEST URL
  static const String odooBaseUrl =
      'doctorack-staging-17350342.dev.odoo.com/api/';
  //   TEST DATABASE
  static const String database = 'doctorack-staging-17350342';
  //-----------------------------------------------------------------------------------------------------------------------------------------------------------------\\

  static const String sendNotificationEndpoint = 'fcm.googleapis.com/fcm/send';
  static const String updateNoTokenEndpoint =
      '${odooBaseUrl}update_notification';
  static const String deleteUserAccountEndpoint =
      '${odooBaseUrl}delete_user_account';
  static const String getProfileEndpoint = '${odooBaseUrl}get_patient_profile';
  static const String getWalletEndpoint = '${odooBaseUrl}get_user_balance';

  static const String getOffersEndpoint = '${odooBaseUrl}get_offers';
  static const String getCategoriesEndpoint =
      '${odooBaseUrl}get_all_categories';
  static const String getAllClinicsEndpoint = '${odooBaseUrl}get_all_clinc';
  static const String getAllServicesEndpoint =
      '${odooBaseUrl}get_clinic_services_o_all';
  static const String getAllFeaturedClinicsEndpoint =
      'get_all_clinic_featured_data';
  static const String getClinicEndpoint = '${odooBaseUrl}get_clinic_by_id';
  static const String createReviewsEndpoint =
      '${odooBaseUrl}post_patient_review';
  static const String getReviewsEndpoint = '${odooBaseUrl}get_clinic_reviews';
  static const String getServiceReviewsEndpoint =
      '${odooBaseUrl}get_service_reviews';
  static const String getClinicServicesEndpoint =
      '${odooBaseUrl}get_all_services';
  static const String getServiceEndpoint = '${odooBaseUrl}get_service_by_id';
  static const String getAvailableTimesEndpoint =
      '${odooBaseUrl}get_available_appointments';
  static const String checkPaymentStatusEndpoint =
      '${odooBaseUrl}get_payment_process';

  static const String getFavouritesEndpoint =
      '${odooBaseUrl}get_patient_favorites';
  static const String addFavouriteEndpoint = '${odooBaseUrl}add_patient_fav';
  static const String removeFavouriteEndpoint =
      '${odooBaseUrl}remove_patient_favourites';
  static const String getMyAppointmentsEndpoint =
      '${odooBaseUrl}get_my_appointments';
  static const String getAppointmentEndpoint =
      '${odooBaseUrl}get_appointment_by_id';
  static const String searchServicesEndpoint = '${odooBaseUrl}search_api';
  static const String tagsEndpoint = '${odooBaseUrl}get_all_tags';

  //****************************************************************Create Endpoints****************************************************\\

  static const String loginUrl = '${odooBaseUrl}login';
  static const String registerUrl = '${odooBaseUrl}register';
  static const String sendOtpUrl = '${odooBaseUrl}send_otp';
  static const String verifyOtpUrl = '${odooBaseUrl}verify_otp';
  static const String resetPasswordUrl = '${odooBaseUrl}reset_password';
  static const String changePasswordUrl = '${odooBaseUrl}change_password';
  static const String editProfileUrl = '${odooBaseUrl}edit_patient_profile';
  static const String contactUsUrl = '${odooBaseUrl}contact_us';

  static const String createReservationEndpoint =
      '${odooBaseUrl}post_mobile_appointment';
  static const String cancelReservationEndpoint =
      '${odooBaseUrl}cancel_appointment';
  static const String changeReservationEndpoint =
      '${odooBaseUrl}change_appointment_data';

//****************************************************************//Vendor Endpoints\\****************************************************\\

  static const String getClinicProfileEndpoint =
      '${odooBaseUrl}get_cli_profile';
  static const String getBankEndpoint = '${odooBaseUrl}get_bank_details';
  static const String getUsersEndpoint = '${odooBaseUrl}get_cli_users';
  static const String getCustomersEndpoint = '${odooBaseUrl}get_cli_customers';
  static const String getFinancesEndpoint = '${odooBaseUrl}get_finances';
  static const String getCurrencyEndpoint = '${odooBaseUrl}get_all_currencies';
  static const String getStatesEndpoint = '${odooBaseUrl}get_state_list';
  static const String getBanksEndpoint = '${odooBaseUrl}get_all_banks';
  static const String getAppointmentsEndpoint =
      '${odooBaseUrl}get_cli_appointments';
  static const String getAdvancedSalesEndpoint =
      '${odooBaseUrl}clinic_sales_report';
  static const String getAdvancedCustomersEndpoint =
      '${odooBaseUrl}clinic_customer_report';
  static const String getTopServicesEndpoint = '${odooBaseUrl}get_top_services';
  static const String getSalesEndpoint = '${odooBaseUrl}dashboard_sales_report';
  static const String changeUserRoleEndpoint = '${odooBaseUrl}change_user_role';
  static const String deleteUserEndpoint = '${odooBaseUrl}delete_clinic_user';
  static const String editClinicProfileEndpoint =
      '${odooBaseUrl}edit_clinic_profile';
  static const String blockTimeEndpoint = '${odooBaseUrl}block_time';
  static const String editServiceEndpoint = '${odooBaseUrl}edit_service';
  static const String editBankEndpoint = '${odooBaseUrl}edit_bank_details';
  static const String getNotificationsEndpoint =
      '${odooBaseUrl}fetch_notifications';
}
