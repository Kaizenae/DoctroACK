import 'package:doctor_ack/core/api/end_points.dart';

import '../../../../core/api/api_consumer.dart';
import '../models/search_services_model.dart';

abstract class SearchServicesRemoteDataSource {
  Future<SearchServicesModel> searchServices({required String keyWord});
}

class SearchServicesRemoteDataSourceImpl
    implements SearchServicesRemoteDataSource {
  ApiConsumer apiConsumer;

  SearchServicesRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<SearchServicesModel> searchServices({required String keyWord}) async {
    final response =
        await apiConsumer.get(EndPoints.searchServicesEndpoint, data: {
      "params": {"keyword": keyWord}
    });

    return SearchServicesModel.fromJson(response);
  }
}
