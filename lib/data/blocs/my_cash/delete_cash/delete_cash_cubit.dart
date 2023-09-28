import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sertifikasi_bnsp/data/repository/my_cash_repository.dart';

part 'delete_cash_state.dart';

class DeleteCashCubit extends Cubit<DeleteCashState> {
  DeleteCashCubit() : super(DeleteCashInitial());

  final MyCashRepository _myCash = MyCashRepository();
  
  void delete(int id) async{
    emit(DeleteCashLoading());
    try {
      await _myCash.deleteCash(id);
      emit(DeleteCashSuccess());
    } catch (e) {
      emit(DeleteCashFailure(e.toString()));
    }
  }
  
}
