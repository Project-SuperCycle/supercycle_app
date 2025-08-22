import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:supercycle_app/core/services/auth_services.dart' show AuthService;
import 'package:supercycle_app/core/services/services_locator.dart';
import 'package:supercycle_app/features/sign_in/data/managers/sign-in-cubit/sign_in_state.dart';
import 'package:supercycle_app/features/sign_in/data/models/signin_credentials_model.dart'
    show SigninCredentialsModel;
import 'package:supercycle_app/features/sign_in/data/repos/signin_repo_imp.dart'
    show SignInRepoImp;

class SignInCubit extends Cubit<SignInState> {
  final SignInRepoImp signInRepo;
  SignInCubit({required this.signInRepo}) : super(SignInInitial());

  Future<void> signIn(SigninCredentialsModel credentials) async {
    emit(SignInLoading());
    try {
      var result = await signInRepo.userSignin(credentials: credentials);
      result.fold(
        (failure) {
          emit(SignInFailure(message: failure.errMessage));
        },
        (user) {
          emit(SignInSuccess(user: user));
          getIt<AuthService>().setUser(user); // Store user globally
        },
      );
    } catch (error) {
      emit(SignInFailure(message: error.toString()));
    }
  }
}
