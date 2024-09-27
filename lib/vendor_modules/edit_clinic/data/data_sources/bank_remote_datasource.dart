import 'package:doctor_ack/core/general_models/create_model.dart';
import 'package:doctor_ack/vendor_modules/edit_clinic/data/models/banks_model.dart';
import 'package:doctor_ack/vendor_modules/edit_clinic/data/models/states_model.dart';

import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../models/currency_model.dart';

abstract class BankRemoteDataSource {
  Future<CurrencyModel> currency();
  Future<StatesModel> states();
  Future<BanksModel> banks();
  Future<CreateModel> editBank({
    required int bankId,
    required String holderName,
    required int accountNumber,
  });
}

class BankRemoteDataSourceImpl implements BankRemoteDataSource {
  ApiConsumer apiConsumer;

  BankRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<CurrencyModel> currency() async {
    final response = await apiConsumer.get(EndPoints.getCurrencyEndpoint,
        data: {"jsonrpc": "2.0", "params": {}});
    return CurrencyModel.fromJson(response);
  }

  @override
  Future<StatesModel> states() async {
    final response = await apiConsumer.get(EndPoints.getStatesEndpoint,
        data: {"jsonrpc": "2.0", "params": {}});
    return StatesModel.fromJson(response);
  }

  @override
  Future<BanksModel> banks() async {
    final response = await apiConsumer.get(EndPoints.getBanksEndpoint,
        data: {"jsonrpc": "2.0", "params": {}});
    return BanksModel.fromJson(response);
  }

  @override
  Future<CreateModel> editBank({
    required int bankId,
    required String holderName,
    required int accountNumber,
  }) async {
    final response = await apiConsumer.post(EndPoints.editBankEndpoint, body: {
      "jsonrpc": "2.0",
      "params": {
        "bank_id": bankId,
        "acc_holder_name": holderName,
        "account_number": accountNumber
      }
    });
    return CreateModel.fromJson(response);
  }
}
