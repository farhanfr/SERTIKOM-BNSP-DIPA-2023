import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sertifikasi_bnsp/data/blocs/users/change_password/change_password_cubit.dart';
import 'package:sertifikasi_bnsp/data/repository/user_repository.dart';
import 'package:sertifikasi_bnsp/ui/screens/login_screen.dart';
import 'package:sertifikasi_bnsp/ui/widgets/edit_text.dart';
import 'package:sertifikasi_bnsp/utils/extension.dart' as AppExt;
import 'package:sertifikasi_bnsp/utils/typography.dart' as AppTypo;

class PengaturanScreen extends StatefulWidget {
  const PengaturanScreen({Key? key}) : super(key: key);

  @override
  State<PengaturanScreen> createState() => _PengaturanScreenState();
}

class _PengaturanScreenState extends State<PengaturanScreen> {
  final UserRepository _userRepo = UserRepository();
  late ChangePasswordCubit _changePasswordCubit;

  TextEditingController? _oldPasswordCtrl;
  TextEditingController? _newPasswordCtrl;

  @override
  void initState() {
    _changePasswordCubit = ChangePasswordCubit();

    _oldPasswordCtrl = TextEditingController(text: '');
    _newPasswordCtrl = TextEditingController(text: '');
    super.initState();
  }

  @override
  void dispose() {
    _changePasswordCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _changePasswordCubit,
      child: BlocListener<ChangePasswordCubit, ChangePasswordState>(
        listener: (context, state) {
          if (state is ChangePasswordSuccess) {
            FocusScope.of(context).requestFocus(FocusNode());
            if (state.isPasswordChange['status'] == true) {
              _newPasswordCtrl!.clear();
              _oldPasswordCtrl!.clear();
              Fluttertoast.showToast(msg: state.isPasswordChange['message']);
            }else{
              Fluttertoast.showToast(msg:state.isPasswordChange['message']);
            }
          }
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Pengaturan"),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  Text("Ganti Password",style: AppTypo.LatoBold,),
                  SizedBox(height: 10,),
                  Text("Password Saat ini",style: AppTypo.body1Lato,),
                   SizedBox(height: 5,),
                  EditText(
                    controller: _oldPasswordCtrl,
                    hintText: "Masukkan password saat ini"),
                  Text("Password Baru",style: AppTypo.body1Lato,),
                   SizedBox(height: 5,),
                  EditText(controller: _newPasswordCtrl,hintText: "Masukkan password baru"),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text('Simpan'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                      ),
                      onPressed: () {
                        _changePasswordCubit.updatePassword(_oldPasswordCtrl!.text, _newPasswordCtrl!.text);
                      },
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text('Kembali'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue[400],
                      ),
                      onPressed: () {
                        AppExt.popScreen(context);
                      },
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text('Logout'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red[400],
                      ),
                      onPressed: () {
                        _userRepo.deleteUserId();
                        AppExt.pushAndRemoveScreen(context, pageRef: LoginScreen());                    
                        },
                    ),
                  ),
                  SizedBox(height: 50,),
                  Row(children: [
                    Expanded(child: Image.asset('assets/images/myphoto.jpg')),
                    SizedBox(width: 15,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("About this App..",style: AppTypo.latoBold,),
                          SizedBox(height: 10,),
                          Text("Aplikasi ini dibuat oleh: "),
                          SizedBox(height: 5,),
                          Text("Nama : Mochamad Farhan Fitrahtur Rachmad"),
                          SizedBox(height: 5,),
                          Text("NIM : 1941720133 "),
                          SizedBox(height: 5,),
                          Text("Tanggal : 24 September 2023 "),
                          SizedBox(height: 5,),
                        ],
                      ),
                    )
                  ],)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
