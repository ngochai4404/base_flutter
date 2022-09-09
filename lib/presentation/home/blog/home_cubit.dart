import 'package:blocapptest/config/base/base_cubit.dart';
import 'package:blocapptest/data/network/exception/dio_exception.dart';
import 'package:blocapptest/data/repository/user_repository.dart';
import 'package:blocapptest/di/service_locator.dart';
import 'home_state.dart';

class HomeCubit extends BaseCubit<HomeState> {
  HomeCubit() : super(
      HomeDataInitial()
  );
  final userRepository = getIt.get<UserRepository>();
  Future<void> getUserInfo() async {
    showLoading();
    try {
      var name = await userRepository.getUserInfo();
      showContent();
      emit(HomeDataLoadSuccess(name));
    } on DioExceptions catch(ex){
      showError("Api error",ex.message);
    }
  }
}
