part of 'fetch_income_cubit.dart';

abstract class FetchIncomeState extends Equatable {
  const FetchIncomeState();

  @override
  List<Object> get props => [];
}

class FetchIncomeInitial extends FetchIncomeState {}

class FetchIncomeLoading extends FetchIncomeState {}

class FetchIncomeSuccess extends FetchIncomeState {
  FetchIncomeSuccess(this.myCash);
  final List<MyCash> myCash;
  @override
  List<Object> get props => [myCash];
}

class FetchIncomeFailure extends FetchIncomeState {
  FetchIncomeFailure(this.message);
  final String message;
  @override
  List<Object> get props => [message];
}
