import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sertifikasi_bnsp/data/repository/my_cash_repository.dart';

part 'fetch_cash_summary_state.dart';

class FetchCashSummaryCubit extends Cubit<FetchCashSummaryState> {
  FetchCashSummaryCubit() : super(FetchCashSummaryInitial());

  final MyCashRepository _myCash = MyCashRepository();
  
  void load() async{
    emit(FetchCashSummaryLoading());
    try {
      final response = await _myCash.getMonthSummary();
      emit(FetchCashSummarySuccess(response));
    } catch (e) {
      emit(FetchCashSummaryFailure(e.toString()));
    }
  }

  
}
