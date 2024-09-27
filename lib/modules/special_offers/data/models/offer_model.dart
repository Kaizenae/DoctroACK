import 'package:doctor_ack/modules/special_offers/domain/entities/offer_entity.dart';

class OfferModel extends OfferEntity {
  OfferModel({ResultEntity? resultEntity})
      : super(
          resultEntity: resultEntity!,
        );

  factory OfferModel.fromJson(json) => OfferModel(
        resultEntity: ResultModel.fromJson(json['result']),
      );
}

class ResultModel extends ResultEntity {
  ResultModel({
    bool? status,
    String? message,
    List<ResponseEntity>? response,
  }) : super(
          message: message ?? '',
          response: response ?? [],
          status: status ?? false,
        );

  factory ResultModel.fromJson(json) => ResultModel(
        status: json['status'],
        response: List<ResponseEntity>.from(
            json['result'].map((e) => ResponseModel.fromJson(e))),
        message: json['message'],
      );
}

class ResponseModel extends ResponseEntity {
  const ResponseModel({
    int? id,
    int? serviceId,
    String? title,
    String? description,
    String? image,
  }) : super(
          description: description ?? '',
          id: id ?? 0,
          image: image ?? '',
          serviceId: serviceId ?? 0,
          title: title ?? '',
        );

  factory ResponseModel.fromJson(json) => ResponseModel(
        title: json['title'],
        serviceId: json['service_id'],
        image: json['image'],
        id: json['id'],
        description: json['description'],
      );
}
