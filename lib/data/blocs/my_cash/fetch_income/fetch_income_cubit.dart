import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sertifikasi_bnsp/data/models/my_cash.dart';
import 'package:sertifikasi_bnsp/data/repository/my_cash_repository.dart';

part 'fetch_income_state.dart';

class FetchIncomeCubit extends Cubit<FetchIncomeState> {
  FetchIncomeCubit() : super(FetchIncomeInitial());

  final MyCashRepository _myCash = MyCashRepository();
  
  void load() async{
    emit(FetchIncomeLoading());
    try {
      final response = await _myCash.getAllMyCash();
      emit(FetchIncomeSuccess(response!));
    } catch (e) {
      emit(FetchIncomeFailure(e.toString()));
    }
  }
  
}
