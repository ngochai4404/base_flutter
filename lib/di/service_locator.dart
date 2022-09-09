import 'package:blocapptest/data/network/api/user_api.dart';
import 'package:blocapptest/data/network/dio_client.dart';
import 'package:blocapptest/data/repository/user_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupDI() async {
  getIt.registerSingleton(Dio());
  getIt.registerSingleton(DioClient(getIt<Dio>()));
  getIt.registerSingleton(UserApi(getIt<DioClient>()));
  getIt.registerSingleton(UserRepository(getIt.get<UserApi>()));
}
