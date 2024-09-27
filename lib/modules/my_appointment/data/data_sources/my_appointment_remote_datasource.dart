import 'package:doctor_ack/core/general_models/create_model.dart';
import 'package:doctor_ack/modules/my_appointment/data/models/appointment_model.dart';

import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../models/my_appointment_model.dart';

abstract class MyAppointmentRemoteDataSource {
  Future<MyAppointmentModel> myAppointment();

  Future<UserAppointmentModel> appointment({required int id});

  Future<CreateModel> cancelAppointment({
    required int? id,
    required String? reason,
  });

  Future<CreateModel> changeAppointment({
    required int? id,
    required String? date,
    required String? time,
  });
}

class MyAppointmentRemoteDataSourceImpl
    implements MyAppointmentRemoteDataSource {
  ApiConsumer apiConsumer;

  MyAppointmentRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<MyAppointmentModel> myAppointment() async {
    final response =
        await apiConsumer.get(EndPoints.getMyAppointmentsEndpoint, data: {});

    return MyAppointmentModel.fromJson(response);
  }

  @override
  Future<CreateModel> cancelAppointment({
    required int? id,
    required String? reason,
  }) async {
    final response =
        await apiConsumer.post(EndPoints.cancelReservationEndpoint, body: {
      "params": {"appointment_id": id, "reason": reason}
    });

    return CreateModel.fromJson(response);
  }

  @override
  Future<CreateModel> changeAppointment({
    required int? id,
    required String? date,
    required String? time,
  }) async {
    final response =
        await apiConsumer.post(EndPoints.changeReservationEndpoint, body: {
      "params": {"appointment_id": id, "date": date, "time": time}
    });

    return CreateModel.fromJson(response);
  }

  @override
  Future<UserAppointmentModel> appointment({required int id}) async {
    final response =
        await apiConsumer.get(EndPoints.getAppointmentEndpoint, data: {
      "params": {"appointment_id": id}
    });

    return UserAppointmentModel.fromJson(response);
  }
}
