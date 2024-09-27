import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../../../forget_password/data/models/general_model.dart';

abstract class ContactUsRemoteDataSource {
  Future<GeneralModel> contactUs({
    required String name,
    required String message,
    required String email,
    required String subject,
  });
}

class ContactUsRemoteDataSourceImpl implements ContactUsRemoteDataSource {
  ApiConsumer apiConsumer;

  ContactUsRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<GeneralModel> contactUs({
    required String name,
    required String message,
    required String email,
    required String subject,
  }) async {
    final response = await apiConsumer.post(EndPoints.contactUsUrl, body: {
      "params": {
        "name": name,
        "email": email,
        "message": message,
        "subject": subject,
      }
    });
    return GeneralModel.fromJson(response);
  }
}
