import 'package:equatable/equatable.dart';
import '../../../../../../core/utils/packages_imprts.dart';

part 'web_view_state.dart';

class WebViewCubit extends Cubit<WebViewState> {
  WebViewCubit() : super(WebViewInitial());
  static WebViewCubit get(context) => BlocProvider.of(context);

  String url = 'https://ahmedemad007.github.io/DoctorAck_Privacy/';
  String termsUrl =
      'https://ahmedemad007.github.io/DoctorAck_Terms_Conditions/';
  bool terms = false;
}
