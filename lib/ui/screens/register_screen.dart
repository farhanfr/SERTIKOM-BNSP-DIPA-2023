import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hero_button/hero_button.dart';
import 'package:sertifikasi_bnsp/data/blocs/users/add_user/add_user_cubit.dart';
import 'package:sertifikasi_bnsp/data/database/db_helper.dart';
import 'package:sertifikasi_bnsp/data/models/user.dart';
import 'package:sertifikasi_bnsp/ui/widgets/edit_text.dart';
import 'package:sertifikasi_bnsp/utils/typography.dart' as AppTypo;
import 'package:sertifikasi_bnsp/utils/extension.dart' as AppExt;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late AddUserCubit _addUserCubit;

  TextEditingController? usernameCtrl;
  TextEditingController? passwordCtrl;

  @override
  void initState() {
    _addUserCubit = AddUserCubit();

    usernameCtrl = TextEditingController(
        text: '');

    passwordCtrl = TextEditingController(
        text:'');
    super.initState();
  }

  @override
  void dispose() {
    _addUserCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _addUserCubit,
      child: BlocListener<AddUserCubit, AddUserState>(
        listener: (context, state) {
          if (state is AddUserSuccess) {
            FocusScope.of(context).requestFocus(FocusNode());
            Fluttertoast.showToast(msg: "Registerasi berhasil");
            usernameCtrl!.clear();
            passwordCtrl!.clear();
          } 
        },
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                children: [
                  Image.asset('assets/icons/book.png',width: 100,),
                    SizedBox(height: 10,),
                  Text(
                    "MyCashBook v1.0",
                    style: AppTypo.LatoBold,
                  ),
                   SizedBox(height: 10,),
                  Text(
                    "Register",
                    style: AppTypo.LatoBold,
                  ),
                   SizedBox(height: 10,),
                  EditText(controller: usernameCtrl,hintText: "Username"),
                   SizedBox(height:10,),
                  EditText(
                    controller: passwordCtrl,
                    hintText: "password",
                    inputType: InputType.password,
                  ),
                   SizedBox(height: 20,),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text('Daftar'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                      ),
                      onPressed: () async{
                         await _addUserCubit.addUser(User(
                          username: usernameCtrl!.text,
                          password: passwordCtrl!.text
                         ));
                         debugPrint("${usernameCtrl!.text} ${passwordCtrl!.text}");
                      },
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      child: Text('Sudah punya akun ?'),
                      onPressed: () {
                        AppExt.popScreen(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
