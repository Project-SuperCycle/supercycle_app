import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:supercycle_app/features/sign_in/data/cubits/sign-in-cubit/sign_in_state.dart';
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
          emit(
            SignInFailure(
              message: failure.errMessage,
              statusCode: failure.statusCode,
            ),
          );
        },
        (user) {
          emit(SignInSuccess(user: user));
        },
      );
    } catch (error) {
      emit(SignInFailure(message: error.toString(), statusCode: 520));
    }
  }
}
