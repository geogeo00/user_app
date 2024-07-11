import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:user_app/feature/user/data/repositories/user_repository_implement.dart';
import 'package:user_app/feature/user/data/sources/user_source.dart';
import 'package:user_app/feature/user/domain/repositories/user_repository.dart';
import 'package:user_app/feature/user/domain/usecases/fetch_user_details.dart';
import 'package:user_app/feature/user/domain/usecases/fetch_users.dart';
import 'package:user_app/feature/user/presentation/bloc/user_bloc.dart';


final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => UserBloc(fetchUsers: sl()));

  // Use cases
  sl.registerLazySingleton(() => FetchUsers(sl()));
  sl.registerLazySingleton(() => FetchUserDetail(sl()));

  // Repository
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(http.Client()));

  // Data sources
  sl.registerLazySingleton<UserRemoteDataSource>(() => UserRemoteDataSourceImpl(client: sl()));

  // External
  sl.registerLazySingleton(() => http.Client());
}
