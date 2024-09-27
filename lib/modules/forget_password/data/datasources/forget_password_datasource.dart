import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../models/general_model.dart';

abstract class ForgetPasswordRemoteDataSource {
  Future<GeneralModel> sendOTP({
    required String email,
  });

  Future<GeneralModel> verifyOTP({
    required String otp,
  });

  Future<GeneralModel> newPassword({
    required String newPassword,
    required String email,
  });
}

class ForgetPasswordRemoteDataSourceImpl
    implements ForgetPasswordRemoteDataSource {
  ApiConsumer apiConsumer;

  ForgetPasswordRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<GeneralModel> sendOTP({
    required String email,
  }) async {
    final response = await apiConsumer.post(EndPoints.sendOtpUrl, body: {
      "jsonrpc": "2.0",
      "params": {
        "email": email,
      }
    });
    return GeneralModel.fromJson(response);
  }

  @override
  Future<GeneralModel> verifyOTP({
    required String otp,
  }) async {
    final response = await apiConsumer.post(EndPoints.verifyOtpUrl, body: {
      "jsonrpc": "2.0",
      "params": {
        "otp": otp,
      }
    });
    return GeneralModel.fromJson(response);
  }

  @override
  Future<GeneralModel> newPassword({
    required String newPassword,
    required String email,
  }) async {
    final response = await apiConsumer.post(EndPoints.resetPasswordUrl, body: {
      "jsonrpc": "2.0",
      "params": {
        "email": email,
        "new_password": newPassword,
      }
    });
    return GeneralModel.fromJson(response);
  }
}
