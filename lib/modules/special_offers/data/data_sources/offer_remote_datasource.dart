import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../models/offer_model.dart';

abstract class OfferRemoteDataSource {
  Future<OfferModel> offers();
}

class OfferRemoteDataSourceImpl implements OfferRemoteDataSource {
  ApiConsumer apiConsumer;

  OfferRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<OfferModel> offers() async {
    final response =
        await apiConsumer.get(EndPoints.getOffersEndpoint, data: {});

    return OfferModel.fromJson(response);
  }
}
