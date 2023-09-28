import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sertifikasi_bnsp/data/models/user.dart';
import 'package:sertifikasi_bnsp/data/repository/user_repository.dart';

part 'fetch_user_state.dart';

class FetchUserCubit extends Cubit<FetchUserState> {
  FetchUserCubit() : super(FetchUserInitial());

  final UserRepository _userRepo = UserRepository();
  
  void load() async{
    try {
      final response = await _userRepo.getAllUser();
      emit(FetchUserSuccess(response!));
    } catch (e) {
      emit(FetchUserFailure());
    }
  }
}
