import 'package:get_it/get_it.dart';
import 'package:supercycle_app/core/repos/social_auth_repo_imp.dart';
import 'package:supercycle_app/core/services/api_services.dart';
import 'package:supercycle_app/core/services/dosh_types_manager.dart';
import 'package:supercycle_app/features/home/data/repos/home_repo_imp.dart';
import 'package:supercycle_app/features/sign_in/data/repos/signin_repo_imp.dart';
import 'package:supercycle_app/features/sign_up/data/repos/signup_repo_imp.dart'
    show SignUpRepoImp;

GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<ApiServices>(ApiServices());
  getIt.registerSingleton<DoshTypesManager>(DoshTypesManager());

  getIt.registerSingleton<SignInRepoImp>(
    SignInRepoImp(apiServices: getIt.get<ApiServices>()),
  );

  getIt.registerSingleton<SignUpRepoImp>(
    SignUpRepoImp(apiServices: getIt.get<ApiServices>()),
  );

  getIt.registerSingleton<SocialAuthRepoImp>(
    SocialAuthRepoImp(apiServices: getIt.get<ApiServices>()),
  );

  getIt.registerSingleton<HomeRepoImp>(
    HomeRepoImp(apiServices: getIt.get<ApiServices>()),
  );
}
