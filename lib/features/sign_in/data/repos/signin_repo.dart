import 'package:dartz/dartz.dart';
import 'package:supercycle/core/errors/failures.dart' show Failure;
import 'package:supercycle/features/sign_in/data/models/logined_user_model.dart';
import 'package:supercycle/features/sign_in/data/models/signin_credentials_model.dart'
    show SigninCredentialsModel;

abstract class SignInRepo {
  Future<Either<Failure, LoginedUserModel>> userSignin({
    required SigninCredentialsModel credentials,
  });
}
