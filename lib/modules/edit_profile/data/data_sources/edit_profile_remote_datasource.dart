import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../../../forget_password/data/models/general_model.dart';

abstract class EditProfileRemoteDataSource {
  Future<GeneralModel> editProfile({
    required String image,
    required String userName,
    required String phoneNumber,
    required String email,
  });
}

class EditProfileRemoteDataSourceImpl implements EditProfileRemoteDataSource {
  ApiConsumer apiConsumer;

  EditProfileRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<GeneralModel> editProfile({
    required String image,
    required String userName,
    required String phoneNumber,
    required String email,
  }) async {
    final response = await apiConsumer.post(EndPoints.editProfileUrl, body: {
      "params": {
        "name": userName,
        "email": email,
        "phone": phoneNumber,
        "image": image,
      }
    });
    return GeneralModel.fromJson(response);
  }
}
