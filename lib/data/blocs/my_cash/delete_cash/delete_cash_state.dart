part of 'delete_cash_cubit.dart';

abstract class DeleteCashState extends Equatable {
  const DeleteCashState();

  @override
  List<Object> get props => [];
}

class DeleteCashInitial extends DeleteCashState {}

class DeleteCashLoading extends DeleteCashState {}

class DeleteCashSuccess extends DeleteCashState {}

class DeleteCashFailure extends DeleteCashState {
  DeleteCashFailure(this.message);
  final String message;
  @override
  List<Object> get props => [message];

}
