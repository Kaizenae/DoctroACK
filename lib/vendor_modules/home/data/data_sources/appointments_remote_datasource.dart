import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../models/appointments_model.dart';

abstract class AppointmentsRemoteDataSource {
  Future<AppointmentsModel> appointments({
    required int filter,
    required int serviceId,
    required String start,
    required String end,
  });
}

class AppointmentsRemoteDataSourceImpl implements AppointmentsRemoteDataSource {
  ApiConsumer apiConsumer;

  AppointmentsRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<AppointmentsModel> appointments({
    required int filter,
    required int serviceId,
    required String start,
    required String end,
  }) async {
    final response =
        await apiConsumer.get(EndPoints.getAppointmentsEndpoint, data: {
      "params": filter != 0
          ? {"service_id": serviceId, "filter": filter}
          : start.isNotEmpty
              ? {"service_id": serviceId, "start": start, "end": end}
              : {"service_id": serviceId}
    });
    return AppointmentsModel.fromJson(response);
  }
}
