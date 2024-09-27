import 'package:dartz/dartz.dart';
import '../../../../../../core/utils/packages_imprts.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../../core/utils/constants_manager.dart';
import '../../../domain/entities/available_times_entity.dart';
import '../../../domain/use_cases/clinic_usecase.dart';
import 'available_times_state.dart';

class AvailableTimesCubit extends Cubit<AvailableTimesState> {
  final AvailableTimesUsecase availableTimesUsecase;

  AvailableTimesCubit({required this.availableTimesUsecase})
      : super(ClinicInitial());

  static AvailableTimesCubit get(context) => BlocProvider.of(context);

  int serviceID = 0;
  int doctorID = 0;
  String date = DateTime.now().toString().split(' ')[0];

  Future<void> getAvailableTimes() async {
    emit(GetAvailableTimesLoadingState());
    Either<Failure, AvailableTimesEntity> response =
        await availableTimesUsecase(AvailableTimesParams(
            serviceID: serviceID, date: date, doctorID: doctorID));

    emit(response.fold(
        (failure) => GetAvailableTimesErrorState(message: failure.message),
        (availableTimesEntity) => GetAvailableTimesSuccessState(
            availableTimesEntity: availableTimesEntity)));
  }

  String convert24To12HourFormat(String time24) {
    final DateFormat inputFormat = DateFormat('HH:mm:ss');
    final DateFormat outputFormat =
        DateFormat('h:mm a', AppConstants.language ? 'ar' : 'en');

    final DateTime dateTime = inputFormat.parse(time24, true);
    return outputFormat.format(dateTime);
  }

  String convert24HourFormat(String time24) {
    final DateFormat inputFormat = DateFormat('HH:mm:ss');
    final DateFormat outputFormat = DateFormat('HH:mm');

    final DateTime dateTime = inputFormat.parse(time24);
    return outputFormat.format(dateTime);
  }

  String getMinuteString(double decimalValue) {
    return '${((decimalValue * 10).round() * 10).toInt()}'.padLeft(2, '0');
  }

  String getHourString(int flooredValue) {
    return '${flooredValue % 24}'.padLeft(2, '0');
  }
}
