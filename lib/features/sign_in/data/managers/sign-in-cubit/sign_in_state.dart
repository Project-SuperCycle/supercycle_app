import 'package:equatable/equatable.dart' show Equatable;
import 'package:supercycle_app/features/sign_in/data/models/logined_user_model.dart';

sealed class SignInState extends Equatable {
  const SignInState();
}

final class SignInInitial extends SignInState {
  @override
  List<Object> get props => [];
}

final class SignInLoading extends SignInState {
  @override
  List<Object> get props => [];
}

final class SignInSuccess extends SignInState {
  final LoginedUserModel user;

  const SignInSuccess({required this.user});
  @override
  List<Object> get props => [];
}

final class SignInFailure extends SignInState {
  final String message;

  const SignInFailure({required this.message});
  @override
  List<Object> get props => [];
}
