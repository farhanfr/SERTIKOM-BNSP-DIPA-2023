part of 'check_user_login_cubit.dart';

abstract class CheckUserLoginState extends Equatable {
  const CheckUserLoginState();

  @override
  List<Object> get props => [];
}

class CheckUserLoginInitial extends CheckUserLoginState {}

class CheckUserLoginLoading extends CheckUserLoginState {}

class CheckUserLoginTrue extends CheckUserLoginState {}

class CheckUserLoginFalse extends CheckUserLoginState {}
