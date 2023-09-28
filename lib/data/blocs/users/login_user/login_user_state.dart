part of 'login_user_cubit.dart';

abstract class LoginUserState extends Equatable {
  const LoginUserState();

  @override
  List<Object> get props => [];
}

class LoginUserInitial extends LoginUserState {}

class  LoginUserLoading extends LoginUserState {}

class  LoginUserSuccess extends LoginUserState {
   LoginUserSuccess(this.isLogin);
  final bool isLogin;
  @override
  List<Object> get props => [isLogin];
}

class  LoginUserFailure extends LoginUserState {}
