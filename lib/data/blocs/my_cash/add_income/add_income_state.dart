part of 'add_income_cubit.dart';

abstract class AddIncomeState extends Equatable {
  const AddIncomeState();

  @override
  List<Object> get props => [];
}

class AddIncomeInitial extends AddIncomeState {}

class AddIncomeLoading extends AddIncomeState {}

class AddIncomeSuccess extends AddIncomeState {}

class AddIncomeFailure extends AddIncomeState {
  AddIncomeFailure(this.message);
  final String message;
  @override
  List<Object> get props => [message];

}
