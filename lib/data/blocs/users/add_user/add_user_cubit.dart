import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sertifikasi_bnsp/data/models/user.dart';
import 'package:sertifikasi_bnsp/data/repository/user_repository.dart';

part 'add_user_state.dart';

class AddUserCubit extends Cubit<AddUserState> {
  AddUserCubit() : super(AddUserInitial());

  final UserRepository _userRepo = UserRepository();

  Future<void> addUser(User user)async{
    emit(AddUserLoading());
    try {
      await _userRepo.saveUser(user);
      emit(AddUserSuccess());
    } catch (e) {
      emit(AddUserFailure());
    }
  }
}
