import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:sertifikasi_bnsp/data/repository/user_repository.dart';

part 'check_user_login_state.dart';

class CheckUserLoginCubit extends Cubit<CheckUserLoginState> {
  CheckUserLoginCubit() : super(CheckUserLoginInitial());
  final UserRepository _userRepo = UserRepository();

  void check(){
    emit(CheckUserLoginInitial());
    try {
       final res = _userRepo.getUserId();
       if (res != null) {
         emit(CheckUserLoginTrue());
       }else{
        emit(CheckUserLoginFalse());
       }
    } catch (e) {
      emit(CheckUserLoginFalse());
    }
   

  }

}
