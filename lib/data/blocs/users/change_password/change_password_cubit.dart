import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sertifikasi_bnsp/data/repository/user_repository.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(ChangePasswordInitial());

  final UserRepository _userRepo = UserRepository();
  
  void updatePassword(String oldPassword,String newPassword) async{
    emit(ChangePasswordLoading());
    try {
      final response = await _userRepo.changePassword(oldPassword, newPassword);
      emit(ChangePasswordSuccess(response));
    } catch (e) {
      emit(ChangePasswordFailure(e.toString()));
    }
  }
  
}
