part of 'change_password_cubit.dart';

abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object> get props => [];
}

class ChangePasswordInitial extends ChangePasswordState {}

class ChangePasswordLoading extends ChangePasswordState {}

class ChangePasswordSuccess extends ChangePasswordState {
  ChangePasswordSuccess(this.isPasswordChange);
  final Map<String,dynamic> isPasswordChange;
  @override
  List<Object> get props => [isPasswordChange];
}

class ChangePasswordFailure extends ChangePasswordState {
  ChangePasswordFailure(this.message);
  final String message;
  @override
  List<Object> get props => [message];
}