import 'package:doctor_ack/core/general_models/create_model.dart';
import 'package:doctor_ack/modules/clinic/data/models/available_times_model.dart';
import 'package:doctor_ack/modules/clinic/data/models/check_payment_model.dart';
import 'package:doctor_ack/modules/clinic/data/models/clinic_services_model.dart';

import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../models/clinic_model.dart';

abstract class ClinicRemoteDataSource {
  Future<CheckPaymentModel> checkPayment();
  Future<ClinicModel> clinic({required int clinicID});

  Future<ClinicServicesModel> clinicServices({required int clinicID});

  Future<AvailableTimesModel> availableTimes({
    required int serviceID,
    required String date,
    required int doctorID,
  });

  Future<CreateModel> createReservationOrder({
    required int serviceID,
    required String date,
    required bool wallet,
    required int userID,
    required String start,
    required String state,
    required String transId,
  });
}

class ClinicRemoteDataSourceImpl implements ClinicRemoteDataSource {
  ApiConsumer apiConsumer;

  ClinicRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<ClinicModel> clinic({required int clinicID}) async {
    EndPoints.baseUrl;
    final response = await apiConsumer.get(EndPoints.getClinicEndpoint, data: {
      "params": {"clinic_id": clinicID}
    });
    return ClinicModel.fromJson(response);
  }

  @override
  Future<ClinicServicesModel> clinicServices({required int clinicID}) async {
    EndPoints.baseUrl;
    final response =
        await apiConsumer.get(EndPoints.getClinicServicesEndpoint, data: {
      "params": {"clinic_id": clinicID}
    });
    return ClinicServicesModel.fromJson(response);
  }

  @override
  Future<AvailableTimesModel> availableTimes(
      {required int serviceID,
      required int doctorID,
      required String date}) async {
    EndPoints.baseUrl;
    final response =
        await apiConsumer.get(EndPoints.getAvailableTimesEndpoint, data: {
      "params": {
        "service_id": serviceID,
        "reservation_date": date,
        "doctor_id": doctorID
      }
    });
    return AvailableTimesModel.fromJson(response);
  }

  @override
  Future<CreateModel> createReservationOrder(
      {required int serviceID,
      required String date,
      required bool wallet,
      required int userID,
      required String start,
      required String transId,
      required String state}) async {
    EndPoints.baseUrl;
    final response =
        await apiConsumer.post(EndPoints.createReservationEndpoint, body: {
      "params": {
        "service_id": serviceID,
        "reservation_date": date,
        "doctor_id": userID,
        "start": start,
        "state": state,
        "wallet": wallet,
        "from_app": true,
        "trans_id": transId
      }
    });
    return CreateModel.fromJson(response);
  }

  @override
  Future<CheckPaymentModel> checkPayment() async {
    EndPoints.baseUrl;
    final response = await apiConsumer
        .get(EndPoints.checkPaymentStatusEndpoint, data: {"params": {}});
    return CheckPaymentModel.fromJson(response);
  }
}
