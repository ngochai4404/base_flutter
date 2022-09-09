import 'package:blocapptest/config/base/base_cubit.dart';
import 'package:blocapptest/data/network/exception/dio_exception.dart';
import 'package:blocapptest/data/repository/user_repository.dart';
import 'package:blocapptest/di/service_locator.dart';
import 'package:blocapptest/presentation/login/blog/login_state.dart';
import 'package:blocapptest/utils/prefs_service.dart';

class LoginCubit extends BaseCubit<LoginState> {
  LoginCubit() : super(LoginDataInitial());
  final userRepository = getIt.get<UserRepository>();
  Future<void> login(String username, String password) async {
    showLoading();
    try {
      await PrefsService.init();
      var token = await userRepository.login("haipham", "haipn123");
      await PrefsService.saveToken(token);
      showContent();
      emit(LoginSuccess(token: token));
    } on DioExceptions catch(ex){
      showError("Error api",ex.message);
    }
  }
}
