import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sertifikasi_bnsp/data/models/my_cash.dart';
import 'package:sertifikasi_bnsp/data/repository/my_cash_repository.dart';

part 'add_income_state.dart';

class AddIncomeCubit extends Cubit<AddIncomeState> {
  AddIncomeCubit() : super(AddIncomeInitial());

  final MyCashRepository _myCashRepository = MyCashRepository();

  void addIncome(MyCash myCash)async{
    emit(AddIncomeLoading());
    try {
      await _myCashRepository.saveIncome(myCash);
      emit(AddIncomeSuccess());
    } catch (e) {
      emit(AddIncomeFailure(e.toString()));
    }
  }

}
