import 'package:equatable/equatable.dart';
import '../../../../../../core/utils/packages_imprts.dart';

part 'toggle_state.dart';

class ToggleCubit extends Cubit<ToggleState> {
  ToggleCubit() : super(ToggleInitial());
  static ToggleCubit get(context) => BlocProvider.of(context);

  bool isFavourite = false;
  void toggleFav() {
    emit(ToggleLoadingState());
    isFavourite = !isFavourite;
    emit(ToggleSuccessState());
  }
}
