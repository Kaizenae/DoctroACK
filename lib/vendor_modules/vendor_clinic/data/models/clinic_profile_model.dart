import '../../domain/entities/clinic_profile_entity.dart';

class ClinicProfileModel extends ClinicProfileEntity {
  ClinicProfileModel({
    ResultEntity? resultEntity,
  }) : super(
          resultEntity: resultEntity!,
        );

  factory ClinicProfileModel.fromJson(Map<String, dynamic> json) =>
      ClinicProfileModel(
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
    double? rate,
    String? description,
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
          rate: rate ?? 0.0,
        );

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        name: json['name'],
        id: json['id'],
        numPatient: json['num_patient'],
        numExperience: json['num_experience'],
        address: AddressModel.fromJson(json['address']),
        phone: json['phone'] == false ? '' : json['phone'],
        expertise: json['expertise'],
        icon: json['icon_cover'] == false ? '' : json['icon_cover'],
        image: json['image_1920'] == false ? '' : json['image_1920'],
        rate: double.parse(json['rating'].toString()),
        description: json['description'] == false ? '' : json['description'],
      );
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
