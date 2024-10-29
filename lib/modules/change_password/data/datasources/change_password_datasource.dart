import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../../../forget_password/data/models/general_model.dart';

abstract class ChangePasswordRemoteDataSource {
  Future<GeneralModel> changePassword({
    required String oldPassword,
    required String newPassword,
  });
}

class ChangePasswordRemoteDataSourceImpl
    implements ChangePasswordRemoteDataSource {
  ApiConsumer apiConsumer;

  ChangePasswordRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<GeneralModel> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    final response = await apiConsumer.post(
      EndPoints.changePasswordUrl,
      body: {
        "jsonrpc": "2.0",
        "params": {
          "old_password": oldPassword,
          "new_password": newPassword,
        }
      },
    );
    return GeneralModel.fromJson(response);
  }
}
