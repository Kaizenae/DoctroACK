import 'package:doctor_ack/vendor_modules/advanced_reports/data/models/top_services_model.dart';

import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../models/advanced_customer_model.dart';
import '../models/advanced_sales_model.dart';

abstract class AdvancedReportDataSource {
  Future<AdvancedSalesModel> advancedSales({
    required String filter,
    required String sort,
    required int serviceId,
  });

  Future<AdvancedCustomersModel> advancedCustomers({
    required String filter,
    required String sort,
    required int serviceId,
  });

  Future<TopServicesModel> topServices();
}

class AdvancedReportRemoteDataSourceImpl implements AdvancedReportDataSource {
  ApiConsumer apiConsumer;

  AdvancedReportRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<AdvancedSalesModel> advancedSales({
    required String filter,
    required String sort,
    required int serviceId,
  }) async {
    final response =
        await apiConsumer.get(EndPoints.getAdvancedSalesEndpoint, data: {
      "jsonrpc": "2.0",
      "params": {"filter": filter, "sort": sort, "service_id": serviceId}
    });
    return AdvancedSalesModel.fromJson(response);
  }

  @override
  Future<AdvancedCustomersModel> advancedCustomers({
    required String filter,
    required String sort,
    required int serviceId,
  }) async {
    final response =
        await apiConsumer.get(EndPoints.getAdvancedCustomersEndpoint, data: {
      "jsonrpc": "2.0",
      "params": {"filter": filter, "sort": sort, "service_id": serviceId}
    });
    return AdvancedCustomersModel.fromJson(response);
  }

  @override
  Future<TopServicesModel> topServices() async {
    final response = await apiConsumer.get(EndPoints.getTopServicesEndpoint,
        data: {"jsonrpc": "2.0", "params": {}});
    return TopServicesModel.fromJson(response);
  }
}
