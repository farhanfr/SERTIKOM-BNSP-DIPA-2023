import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sertifikasi_bnsp/data/blocs/users/check_user_login/check_user_login_cubit.dart';
import 'package:sertifikasi_bnsp/data/database/db_helper.dart';
import 'package:sertifikasi_bnsp/ui/screens/beranda_screen.dart';
import 'package:sertifikasi_bnsp/ui/screens/login_screen.dart';
import 'package:sertifikasi_bnsp/ui/screens/splash_screen.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final database = DBHelper();

  late CheckUserLoginCubit _checkUserLoginCubit;

  @override
  void initState() {
    _checkUserLoginCubit = CheckUserLoginCubit()..check();
    super.initState();
  }

  void initiateDB() async {
    await database.db();
  }

  @override
  void dispose() {
    _checkUserLoginCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _checkUserLoginCubit,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Sertifikasi BNSP',
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          home: BlocBuilder<CheckUserLoginCubit, CheckUserLoginState>(
              builder: (context, state) => state is CheckUserLoginInitial
                  ? SplashScreen()
                  : state is CheckUserLoginTrue
                      ? BerandaScreen()
                      : state is CheckUserLoginFalse
                          ? LoginScreen()
                          : SizedBox(
                              child: Scaffold(
                                body: Center(
                                  child: Text("kosong"),
                                ),
                              ),
                            ))),
    );
  }
}
