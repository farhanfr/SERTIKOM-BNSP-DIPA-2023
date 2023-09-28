import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:sertifikasi_bnsp/data/blocs/my_cash/add_income/add_income_cubit.dart';
import 'package:sertifikasi_bnsp/data/models/my_cash.dart';
import 'package:sertifikasi_bnsp/data/repository/user_repository.dart';
import 'package:sertifikasi_bnsp/ui/widgets/edit_text.dart';
import 'package:sertifikasi_bnsp/utils/extension.dart' as AppExt;
import 'package:sertifikasi_bnsp/utils/typography.dart' as AppTypo;

class EntryScreen extends StatefulWidget {
  const EntryScreen({Key? key, this.isIncome = true}) : super(key: key);

  final bool isIncome;

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  final _formKey = GlobalKey<FormState>();
  late AddIncomeCubit _addIncomeCubit;
  late UserRepository _userRepo = UserRepository();

  TextEditingController? dateCtrl;
  TextEditingController? nominalCtrl;
  TextEditingController? keteranganCtrl;

  DateTime? valueForInsert;

  @override
  void initState() {
    _addIncomeCubit = AddIncomeCubit();
    dateCtrl = TextEditingController(text: '');
    nominalCtrl = TextEditingController(text: '');
    keteranganCtrl = TextEditingController(text: '-');
    super.initState();
  }

  void reset() {
    dateCtrl!.text = "01/01/2021";
    nominalCtrl!.clear();
    keteranganCtrl!.clear();
  }

  String? validation(String? value) {
    if (value!.isEmpty) {
      return "Wajib diisi";
    }
  }

  @override
  void dispose() {
    _addIncomeCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        AppExt.popScreen(context, true);
        return true;
      },
      child: BlocProvider(
        create: (context) => _addIncomeCubit,
        child: BlocListener<AddIncomeCubit, AddIncomeState>(
          listener: (context, state) {
            if (state is AddIncomeSuccess) {
              FocusScope.of(context).requestFocus(FocusNode());
              reset();
              Fluttertoast.showToast(
                  msg:
                      "Tambah ${widget.isIncome ? "Pemasukan" : "Pengeluaran"}  Berhasil !!");
              AppExt.popScreen(context, true);
            }
            if (state is AddIncomeFailure) {
              Fluttertoast.showToast(
                  msg:
                      "Tambah ${widget.isIncome ? "Pemasukan" : "Pengeluaran"} Gagal !!");
            }
          },
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text("Tambah ${widget.isIncome ? "Pemasukan" : "Pengeluaran"}"),
              centerTitle: true,
            ),
            body: SafeArea(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(widget.isIncome
                      //     ? "tambah pemasukan"
                      //     : "tambah pengeluaran",style: AppTypo.LatoBold,),
                      Text("Tanggal :",style: AppTypo.LatoBold,),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                            Expanded(
                              flex: 5,
                            child: EditText(
                              controller: dateCtrl,
                              hintText: "Masukkan tanggal",
                              inputType: InputType.option,
                              validator: validation,
                             
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(), //get today's date
                                    firstDate: DateTime(
                                        2000), //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2101));
                                String formattedDate =
                                    DateFormat('dd/MM/yyyy').format(pickedDate!);
                                setState(() {
                                  dateCtrl!.text = formattedDate;
                                  valueForInsert = pickedDate;
                                });
                              },
                            ),
                          ),
                          Expanded(child: Icon(Icons.calendar_today))
                        ],
                      ),
                      Text("Nominal :",style: AppTypo.LatoBold,),
                      SizedBox(height: 10,),
                      EditText(
                        controller: nominalCtrl,
                        hintText: "Masukkan nominal",
                        keyboardType: TextInputType.number,
                        validator:validation,
                      ),
                      Text("Keterangan : ",style: AppTypo.LatoBold,),
                      SizedBox(height: 10,),
                      EditText(
                        controller: keteranganCtrl,
                        hintText: "Masukkan Keterangan",
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          child: Text('Reset'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.amber,
                          ),
                          onPressed: reset,
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          child: Text('Simpan'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _addIncomeCubit.addIncome(MyCash(
                                  userId: _userRepo.getUserId().toString(),
                                  jenisProses:
                                      widget.isIncome ? "pemasukan" : "pengeluaran",
                                  keterangan: keteranganCtrl!.text,
                                  nominal: nominalCtrl!.text,
                                  tanggalProses: valueForInsert.toString()));
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          child: Text('Kembali'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue[300],
                          ),
                          onPressed: () {
                            AppExt.popScreen(context, true);
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
      ),
    );
  }
}
