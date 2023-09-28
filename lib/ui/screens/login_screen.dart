import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hero_button/hero_button.dart';
import 'package:sertifikasi_bnsp/data/blocs/users/fetch_user/fetch_user_cubit.dart';
import 'package:sertifikasi_bnsp/data/blocs/users/login_user/login_user_cubit.dart';
import 'package:sertifikasi_bnsp/data/database/db_helper.dart';
import 'package:sertifikasi_bnsp/data/models/user.dart';
import 'package:sertifikasi_bnsp/ui/screens/beranda_screen.dart';
import 'package:sertifikasi_bnsp/ui/screens/register_screen.dart';
import 'package:sertifikasi_bnsp/ui/widgets/edit_text.dart';
import 'package:sertifikasi_bnsp/utils/typography.dart' as AppTypo;
import 'package:sertifikasi_bnsp/utils/extension.dart' as AppExt;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late LoginUserCubit _loginUserCubit;

  TextEditingController? usernameCtrl;
  TextEditingController? passwordCtrl;

  @override
  void initState() {
    _loginUserCubit = LoginUserCubit();
    usernameCtrl = TextEditingController(text: '');

    passwordCtrl = TextEditingController(text: '');
    super.initState();
  }

  String? validation(String? value) {
    if (value!.isEmpty) {
      return "Wajib diisi";
    }
  }

  @override
  void dispose() {
    _loginUserCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _loginUserCubit,
      child: BlocListener<LoginUserCubit, LoginUserState>(
        listener: (context, state) {
          if (state is LoginUserSuccess) {
            FocusScope.of(context).requestFocus(FocusNode());
            usernameCtrl!.clear();
            passwordCtrl!.clear();
            if (state.isLogin) {
              Fluttertoast.showToast(msg: "login berhasil");
              AppExt.pushAndRemoveScreen(context, pageRef: BerandaScreen());
            } else {
              Fluttertoast.showToast(msg: "login gagal");
            }
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Form(
                key: _formKey,
                // autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      "Login",
                      style: AppTypo.LatoBold,
                    ),
                    SizedBox(height: 10,),
                    EditText(
                      controller: usernameCtrl,
                      hintText: "Username",
                      validator: validation,
                    ),
                     SizedBox(height: 10,),
                    EditText(
                      controller: passwordCtrl,
                      hintText: "password",
                      inputType: InputType.password,
                      validator: (value) {
                        if ( value!.isEmpty) {
                          return 'Wajib diisi !!';
                        }
                        return null;
                      },
                    ),
                     SizedBox(height: 20,),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        child: Text('Login'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _loginUserCubit.login(User(
                                username: usernameCtrl!.text,
                                password: passwordCtrl!.text));
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        child: Text('Belum punya akun ?'),
                        onPressed: () {
                          AppExt.pushScreen(context, RegisterScreen());
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
