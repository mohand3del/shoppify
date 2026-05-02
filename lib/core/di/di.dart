import 'package:get_it/get_it.dart';
import 'package:shoppify/core/network/api_client.dart';
import 'package:shoppify/features/auth/data/data_source/auth_data_source.dart';

class Di {
  final sl = GetIt.instance;

  Future<void> init() async {
    sl.registerLazySingleton<ApiClient>(() => ApiClient());

    sl.registerLazySingleton<AuthDataSource>(
      () => AuthDataSourceImpl(sl<ApiClient>().dio),
    );
  }
}
