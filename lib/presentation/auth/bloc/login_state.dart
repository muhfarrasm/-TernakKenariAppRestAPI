part of 'login_bloc.dart';

//@immutable
sealed class LoginState {}

// Initial state
final class LoginInitial extends LoginState {}

// Loading state
final class LoginLoading extends LoginState {}

// Success state
final class LoginSuccess extends LoginState {
  final AuthResponseModel responseModel;

  LoginSuccess({required this.responseModel});
}

// Failure state
final class LoginFailure extends LoginState {
  final String error;

  LoginFailure({required this.error});
}
