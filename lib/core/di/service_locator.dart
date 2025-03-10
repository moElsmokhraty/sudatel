import 'package:get_it/get_it.dart';
import '../../features/home/data/repos/auth_repo/auth_repo.dart';
import '../../features/home/data/repos/auth_repo/auth_repo_impl.dart';
import '../service/location_service.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton<AuthRepo>(() => AuthRepoImpl());
  getIt.registerLazySingleton<LocationService>(() => LocationService());
}
