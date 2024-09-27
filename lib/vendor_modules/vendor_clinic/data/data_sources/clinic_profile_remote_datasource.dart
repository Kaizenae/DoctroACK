import 'package:doctor_ack/core/general_models/create_model.dart';
import 'package:doctor_ack/vendor_modules/vendor_clinic/data/models/bank_model.dart';

import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../models/clinic_profile_model.dart';

abstract class ClinicProfileRemoteDataSource {
  Future<ClinicProfileModel> clinicProfile();
  Future<BankModel> bank();

  Future<CreateModel> editClinicProfile({
    required String? logo,
    required String? cover,
    required String? name,
    required String? street,
    required String? city,
    required int? stateId,
    required String? phoneNumber,
    required String? expertise,
    required int? experience,
    required String? about,
  });
}

class ClinicProfileRemoteDataSourceImpl
    implements ClinicProfileRemoteDataSource {
  ApiConsumer apiConsumer;

  ClinicProfileRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<ClinicProfileModel> clinicProfile() async {
    final response =
        await apiConsumer.get(EndPoints.getClinicProfileEndpoint, data: {});
    return ClinicProfileModel.fromJson(response);
  }

  @override
  Future<BankModel> bank() async {
    final response = await apiConsumer.get(EndPoints.getBankEndpoint, data: {});
    return BankModel.fromJson(response);
  }

  @override
  Future<CreateModel> editClinicProfile({
    required String? logo,
    required String? cover,
    required String? name,
    required String? street,
    required String? city,
    required int? stateId,
    required String? phoneNumber,
    required String? expertise,
    required int? experience,
    required String? about,
  }) async {
    final response =
        await apiConsumer.post(EndPoints.editClinicProfileEndpoint, body: {
      "params": {
        "cover": cover,
        "logo": logo,
        "name": name,
        "street": street,
        "city": city,
        "state_id": stateId,
        "phone": phoneNumber,
        "expertise": expertise,
        "experience": experience,
        "about": about
      }
    });
    return CreateModel.fromJson(response);
  }
}
