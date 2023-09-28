part of 'fetch_cash_summary_cubit.dart';

abstract class FetchCashSummaryState extends Equatable {
  const FetchCashSummaryState();

  @override
  List<Object> get props => [];
}

class FetchCashSummaryInitial extends FetchCashSummaryState {}

class FetchCashSummaryLoading extends FetchCashSummaryState {}

class FetchCashSummarySuccess extends FetchCashSummaryState {
  FetchCashSummarySuccess(this.myCash);
  final Map<String,dynamic> myCash;
  @override
  List<Object> get props => [myCash];
}

class FetchCashSummaryFailure extends FetchCashSummaryState {
  FetchCashSummaryFailure(this.message);
  final String message;
  @override
  List<Object> get props => [message];
}
