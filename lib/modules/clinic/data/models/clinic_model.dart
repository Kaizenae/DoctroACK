import '../../domain/entities/clinic_entity.dart';

class ClinicModel extends ClinicEntity {
  ClinicModel({
    ResultEntity? resultEntity,
  }) : super(
          resultEntity: resultEntity!,
        );

  factory ClinicModel.fromJson(Map<String, dynamic> json) => ClinicModel(
        resultEntity: ResultModel.fromJson(json['result']),
      );
}

class ResultModel extends ResultEntity {
  ResultModel({
    bool? status,
    String? message,
    ResponseEntity? responseEntity,
  }) : super(
          status: status ?? false,
          message: message ?? '',
          response: responseEntity!,
        );

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
        status: json['status'],
        message: json['message'],
        responseEntity: ResponseModel.fromJson(json['result']),
      );
}

class ResponseModel extends ResponseEntity {
  ResponseModel({
    int? id,
    int? numExperience,
    int? numPatient,
    AddressEntity? address,
    String? phone,
    String? expertise,
    String? name,
    String? image,
    String? icon,
    bool? favourite,
    double? rate,
    double? lat,
    double? long,
    String? description,
    String? createdAt,
    String? updatedAt,
    List<ClinicServiceEntity>? services,
  }) : super(
          id: id ?? 0,
          numPatient: numPatient ?? 0,
          numExperience: numExperience ?? 0,
          address: address!,
          phone: phone ?? '',
          expertise: expertise ?? '',
          icon: icon ?? '',
          name: name ?? '',
          image: image ?? '',
          description: description ?? '',
          favourite: favourite ?? false,
          rate: rate ?? 0.0,
          lat: lat ?? 0.0,
          long: long ?? 0.0,
          createdAt: createdAt ?? '',
          updatedAt: updatedAt ?? '',
          services: services ?? [],
        );

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
      name: json['name'],
      id: json['id'],
      favourite: json['favourite'],
      numPatient: json['num_patient'],
      numExperience: json['num_experience'],
      address: AddressModel.fromJson(json['address']),
      phone: json['phone'] == false ? '' : json['phone'],
      expertise: json['expertise'],
      icon: json['icon_cover'] == false ? '' : json['icon_cover'],
      image: json['image_1920'] == false ? '' : json['image_1920'],
      lat: json['latitude'] == false ? 0.0 : json['latitude'],
      long: json['longitude'] == false ? 0.0 : json['longitude'],
      rate: double.parse(json['rating'].toString()),
      description: json['description'] == false ? '' : json['description'],
      createdAt: json['create_date'],
      updatedAt: json['update_on'],
      services: List<ClinicServiceEntity>.from(
          json['clinic_service'].map((e) => ClinicServiceModel.fromJson(e))));
}

class AddressModel extends AddressEntity {
  const AddressModel({
    String? street,
    String? city,
    String? state,
    String? country,
  }) : super(
          street: street ?? '',
          city: city ?? '',
          state: state ?? '',
          country: country ?? '',
        );

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        street: json['street'] == false ? '' : json['street'],
        city: json['city'] == false ? '' : json['city'],
        state: json['state'] == false ? '' : json['state'],
        // country:json['country'],
      );
}

class ClinicServiceModel extends ClinicServiceEntity {
  const ClinicServiceModel({
    int? id,
    double? discount,
    String? name,
    String? icon,
    double? rate,
    double? price,
    String? description,
  }) : super(
          id: id ?? 0,
          discount: discount ?? 0.0,
          icon: icon ?? '',
          name: name ?? '',
          description: description ?? '',
          rate: rate ?? 0.0,
          price: price ?? 0.0,
        );

  factory ClinicServiceModel.fromJson(Map<String, dynamic> json) =>
      ClinicServiceModel(
        name: json['name'],
        id: json['id'],
        price: json['price'],
        discount: double.parse(json['discount'].toString()),
        icon: json['icon'] == false ? '' : json['icon'],
        rate: double.parse(json['rating'].toString()),
        description: json['description'] == false ? '' : json['description'],
      );
}
