import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sertifikasi_bnsp/data/models/user.dart';
import 'package:sertifikasi_bnsp/data/repository/user_repository.dart';

part 'login_user_state.dart';

class LoginUserCubit extends Cubit<LoginUserState> {
  LoginUserCubit() : super(LoginUserInitial());

  final UserRepository _userRepo = UserRepository();
  
  void login(User user) async{
    emit(LoginUserLoading());
    try {
      final response = await _userRepo.login(user);
      emit(LoginUserSuccess(response));
    } catch (e) {
      emit(LoginUserFailure());
    }
  }

  
}
