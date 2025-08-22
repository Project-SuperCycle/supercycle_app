import 'package:get_it/get_it.dart';
import 'package:supercycle_app/core/services/api_services.dart';
import 'package:supercycle_app/core/services/auth_services.dart' show AuthService;
import 'package:supercycle_app/features/home/data/repos/home_repo_imp.dart';
import 'package:supercycle_app/features/sign_in/data/repos/signin_repo_imp.dart';
import 'package:supercycle_app/features/sign_up/data/repos/signup_repo_imp.dart'
    show SignUpRepoImp;

GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<ApiServices>(ApiServices());

  getIt.registerSingleton<AuthService>(AuthService());

  getIt.registerSingleton<SignInRepoImp>(
    SignInRepoImp(apiServices: getIt.get<ApiServices>()),
  );

  getIt.registerSingleton<SignUpRepoImp>(
    SignUpRepoImp(apiServices: getIt.get<ApiServices>()),
  );

  getIt.registerSingleton<HomeRepoImp>(
    HomeRepoImp(apiServices: getIt.get<ApiServices>()),
  );
}
