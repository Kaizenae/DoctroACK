// ignore_for_file: non_constant_identifier_names

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../error/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}

class AdvancedReportParams extends Equatable {
  final String filter;
  final String sort;
  final int serviceId;

  const AdvancedReportParams(
      {required this.filter, required this.sort, required this.serviceId});

  @override
  List<Object> get props => [filter, sort, serviceId];
}

class SalesParams extends Equatable {
  final String filter;
  final String start;
  final String end;

  const SalesParams(
      {required this.filter, required this.start, required this.end});

  @override
  List<Object> get props => [filter, start, end];
}

class AppointmentsParams extends Equatable {
  final int serviceId;
  final int filter;
  final String start;
  final String end;

  const AppointmentsParams(
      {required this.serviceId,
      required this.filter,
      required this.start,
      required this.end});

  @override
  List<Object> get props => [serviceId, filter, start, end];
}

class UserParams extends Equatable {
  final int userID;
  final String? role;

  const UserParams({required this.userID, this.role = ''});

  @override
  List<Object?> get props => [userID, role];
}

class IDParams extends Equatable {
  final int id;

  const IDParams({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

class CancelAppointmentParams extends Equatable {
  final int id;
  final String reason;

  const CancelAppointmentParams({required this.id, required this.reason});

  @override
  List<Object?> get props => [id, reason];
}

class ChangeAppointmentParams extends Equatable {
  final int id;
  final String date;
  final String time;

  const ChangeAppointmentParams(
      {required this.id, required this.date, required this.time});

  @override
  List<Object?> get props => [id, date, time];
}

class FavouriteParams extends Equatable {
  final int id;
  final bool isClinic;
  final String endpoint;

  const FavouriteParams(
      {required this.id, required this.isClinic, required this.endpoint});

  @override
  List<Object?> get props => [id, isClinic, endpoint];
}

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class RegisterParams extends Equatable {
  final String email;
  final String password;
  final String userName;
  final String phone;

  const RegisterParams({
    required this.email,
    required this.password,
    required this.userName,
    required this.phone,
  });

  @override
  List<Object> get props => [email, password, userName, phone];
}

class ContactUsParams extends Equatable {
  final String email;
  final String message;
  final String name;
  final String subject;

  const ContactUsParams({
    required this.email,
    required this.message,
    required this.name,
    required this.subject,
  });

  @override
  List<Object> get props => [email, message, name, subject];
}

class StringParams extends Equatable {
  final String string;

  const StringParams({
    required this.string,
  });

  @override
  List<Object> get props => [string];
}

class SendNotificationParams extends Equatable {
  final String title;
  final String body;
  final List<String> toToken;

  const SendNotificationParams({
    required this.title,
    required this.body,
    required this.toToken,
  });

  @override
  List<Object> get props => [title, body, toToken];
}

class EditClinicProfileParams extends Equatable {
  final String logo;
  final String cover;
  final String name;
  final String street;
  final String city;
  final int stateId;
  final String phoneNumber;
  final String expertise;
  final int experience;
  final String about;

  const EditClinicProfileParams(
      {required this.logo,
      required this.cover,
      required this.name,
      required this.street,
      required this.city,
      required this.stateId,
      required this.phoneNumber,
      required this.expertise,
      required this.experience,
      required this.about});

  @override
  List<Object> get props => [
        logo,
        cover,
        name,
        street,
        city,
        stateId,
        phoneNumber,
        expertise,
        experience,
        about,
      ];
}

class EditServiceParams extends Equatable {
  final int serviceId;
  final String? logo;
  final double price;
  final String name;
  final String about;

  const EditServiceParams(
      {this.logo = '',
      required this.serviceId,
      required this.price,
      required this.name,
      required this.about});

  @override
  List<Object> get props => [
        price,
        name,
        about,
      ];
}

class EditBankParams extends Equatable {
  final int bankId;
  final String holderName;
  final int accountNumber;

  const EditBankParams({
    required this.holderName,
    required this.bankId,
    required this.accountNumber,
  });

  @override
  List<Object?> get props => [
        bankId,
        holderName,
        accountNumber,
      ];
}

class EditProfileParams extends Equatable {
  final String image;
  final String userName;
  final String phoneNumber;
  final String email;

  const EditProfileParams({
    required this.image,
    required this.userName,
    required this.phoneNumber,
    required this.email,
  });

  @override
  List<Object> get props => [
        image,
        userName,
        phoneNumber,
        email,
      ];
}

class ChangePasswordParams extends Equatable {
  final String oldPassword;
  final String newPassword;

  const ChangePasswordParams({
    required this.oldPassword,
    required this.newPassword,
  });

  @override
  List<Object> get props => [oldPassword, newPassword];
}

class NewPasswordParams extends Equatable {
  final String email;
  final String newPassword;

  const NewPasswordParams({
    required this.email,
    required this.newPassword,
  });

  @override
  List<Object> get props => [email, newPassword];
}

class AllClinicsEndpointParams extends Equatable {
  final String endpoint;
  final String? sortBy;
  final int? categoryId;
  final int? clinicId;
  final int? tagId;
  final double? lat;
  final double? long;

  const AllClinicsEndpointParams(
      {required this.endpoint,
      this.categoryId = 0,
      this.clinicId = 0,
      this.tagId = 0,
      this.long = 0.0,
      this.lat = 0.0,
      this.sortBy = ''});

  @override
  List<Object?> get props => [
        endpoint,
        sortBy,
        categoryId,
        clinicId,
        tagId,
      ];
}

class ClinicParams extends Equatable {
  final int clinicID;

  const ClinicParams({required this.clinicID});

  @override
  List<Object?> get props => [clinicID];
}

class ReviewsParams extends Equatable {
  final int clinicID;
  final bool isClinic;
  final int filter;

  const ReviewsParams({
    required this.clinicID,
    required this.isClinic,
    required this.filter,
  });

  @override
  List<Object?> get props => [clinicID, isClinic, filter];
}

class CreateReviewsParams extends Equatable {
  final int serviceID;
  final String rate;
  final String note;

  const CreateReviewsParams({
    required this.serviceID,
    required this.rate,
    required this.note,
  });

  @override
  List<Object> get props => [serviceID, rate, note];
}

class AvailableTimesParams extends Equatable {
  final int serviceID;
  final int doctorID;
  final String date;

  const AvailableTimesParams(
      {required this.serviceID, required this.doctorID, required this.date});

  @override
  List<Object?> get props => [serviceID, date, doctorID];
}

class CreateReservationOrderParams extends Equatable {
  final int serviceID;
  final int userID;
  final String date;
  final String start;
  final String state;
  final String transId;
  final bool from_app;
  final bool wallet;

  const CreateReservationOrderParams({
    required this.serviceID,
    required this.userID,
    required this.date,
    required this.start,
    required this.state,
    required this.from_app,
    required this.wallet,
    required this.transId,
  });

  @override
  List<Object> get props => [
        serviceID,
        userID,
        date,
        from_app,
        start,
        state,
        wallet,
        transId,
      ];
}

class BlockTimeParams extends Equatable {
  final int serviceID;
  final String date;
  final String time;

  const BlockTimeParams({
    required this.serviceID,
    required this.date,
    required this.time,
  });

  @override
  List<Object?> get props => [serviceID, date];
}

class CheckoutParams extends Equatable {
  final String orderReferenceId;
  final TotalAmount totalAmount;
  final String description;
  final String countryCode;
  final String paymentType;
  final int instalments;
  final List<Map<String, dynamic>> items;
  final Consumer consumer;
  final Discount discount;
  final UnitPrice taxAmount;
  final UnitPrice shippingAmount;
  final MerchantUrl merchantUrl;
  final ShippingAddress shippingAddress;
  final String platform;
  final bool isMobile;
  final int expiresInMinutes;

  const CheckoutParams(
      {required this.orderReferenceId,
      required this.totalAmount,
      required this.description,
      required this.countryCode,
      required this.paymentType,
      required this.instalments,
      required this.items,
      required this.consumer,
      required this.discount,
      required this.taxAmount,
      required this.shippingAmount,
      required this.shippingAddress,
      required this.merchantUrl,
      required this.platform,
      required this.isMobile,
      required this.expiresInMinutes});

  @override
  List<Object> get props => [
        orderReferenceId,
        totalAmount,
        description,
        countryCode,
        paymentType,
        instalments,
        items,
        consumer,
        discount,
        taxAmount,
        shippingAmount,
        merchantUrl,
        platform,
        isMobile,
        expiresInMinutes,
      ];
}

class TotalAmount extends Equatable {
  final double amount;
  final String currency;

  const TotalAmount({required this.amount, required this.currency});

  @override
  List<Object> get props => [amount, currency];
}

class ShippingAddress extends Equatable {
  final String firstName;
  final String lastName;
  final String line1;

  final String city;
  final String countryCode;

  const ShippingAddress(
      {required this.firstName,
      required this.lastName,
      required this.line1,
      required this.city,
      required this.countryCode});

  @override
  List<Object> get props => [
        firstName,
        lastName,
        line1,
        city,
        countryCode,
      ];
}

class Items extends Equatable {
  final String referenceId;
  final String type;
  final String name;
  final String sku;
  final int quantity;
  final UnitPrice unitPrice;
  final UnitPrice discountAmount;
  final UnitPrice taxAmount;
  final UnitPrice totalAmount;

  const Items(
      {required this.referenceId,
      required this.type,
      required this.name,
      required this.sku,
      required this.quantity,
      required this.unitPrice,
      required this.discountAmount,
      required this.taxAmount,
      required this.totalAmount});

  @override
  List<Object> get props => [
        referenceId,
        type,
        name,
        sku,
        quantity,
        unitPrice,
        discountAmount,
        taxAmount,
        totalAmount,
      ];
}

class Consumer extends Equatable {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;

  const Consumer(
      {required this.firstName,
      required this.lastName,
      required this.phoneNumber,
      required this.email});

  @override
  List<Object> get props => [firstName, lastName, phoneNumber, email];
}

class Discount extends Equatable {
  final String name;
  final UnitPrice amount;

  const Discount({required this.name, required this.amount});

  @override
  List<Object> get props => [name, amount];
}

class UnitPrice extends Equatable {
  final String amount;
  final String currency;

  const UnitPrice({required this.amount, required this.currency});

  @override
  List<Object> get props => [amount, currency];
}

class MerchantUrl extends Equatable {
  final String success;
  final String failure;
  final String cancel;
  final String notification;

  const MerchantUrl(
      {required this.success,
      required this.failure,
      required this.cancel,
      required this.notification});

  @override
  List<Object> get props => [success, failure, cancel, notification];
}
