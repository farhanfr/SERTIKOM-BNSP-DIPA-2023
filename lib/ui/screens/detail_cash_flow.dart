import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:sertifikasi_bnsp/data/blocs/my_cash/delete_cash/delete_cash_cubit.dart';
import 'package:sertifikasi_bnsp/data/blocs/my_cash/fetch_income/fetch_income_cubit.dart';
import 'package:sertifikasi_bnsp/utils/extension.dart' as AppExt;
import 'package:sertifikasi_bnsp/utils/typography.dart' as AppTypo;

class DetailCashFlow extends StatefulWidget {
  const DetailCashFlow({Key? key}) : super(key: key);

  @override
  State<DetailCashFlow> createState() => _DetailCashFlowState();
}

class _DetailCashFlowState extends State<DetailCashFlow> {
  late FetchIncomeCubit _fetchIncomeCubit;
  late DeleteCashCubit _deleteCashCubit;
  @override
  void initState() {
    _fetchIncomeCubit = FetchIncomeCubit()..load();
    _deleteCashCubit = DeleteCashCubit();
    super.initState();
  }

  @override
  void dispose() {
    _fetchIncomeCubit.close();
    _deleteCashCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        AppExt.popScreen(context,true);
        return true;
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => _fetchIncomeCubit,
          ),
          BlocProvider(
            create: (context) => _deleteCashCubit,
          ),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<FetchIncomeCubit, FetchIncomeState>(
              listener: (context, state) {
                if (state is FetchIncomeSuccess) {
                  Fluttertoast.showToast(msg: "Ambil data cash flow berhasil");
                }
                if (state is FetchIncomeFailure) {
                  Fluttertoast.showToast(msg: "Ambil data cash flow gagal");
                }
              },
            ),
            BlocListener<DeleteCashCubit, DeleteCashState>(
              listener: (context, state) {
                if (state is DeleteCashSuccess) {
                  _fetchIncomeCubit.load();
                  Fluttertoast.showToast(msg: "Hapus data cash flow berhasil");
                }
              },
            ),
          ],
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text("Detail Cash Flow"),
              automaticallyImplyLeading: false,
            ),
            body: BlocBuilder<FetchIncomeCubit, FetchIncomeState>(
              builder: (context, state) {
                return state is FetchIncomeLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : state is FetchIncomeFailure
                        ? Text(state.message)
                        : state is FetchIncomeSuccess
                            ? state.myCash.length > 0
                                ? Column(
                                    children: [
                                      Expanded(
                                        flex: 12,
                                        child: ListView.separated(
                                          separatorBuilder: (context, index) =>
                                              SizedBox(),
                                          itemCount: state.myCash.length,
                                          itemBuilder: (context, index) {
                                            final data = state.myCash[index];
                                            return Slidable(
                                              startActionPane: ActionPane(
                                                  motion: BehindMotion(),
                                                  children: [
                                                    SlidableAction(
                                                        backgroundColor:
                                                            Colors.red,
                                                        icon: Icons.delete,
                                                        label: "Hapus",
                                                        onPressed: (context) {
                                                          _deleteCashCubit.delete(data.id!);
                                                        })
                                                  ]),
                                              child: Container(
                                                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                            "[ ${data.jenisProses == "pemasukan" ? "+ " : "- "} ] Rp.${data.nominal}",style: AppTypo.LatoBold,),
                                                        SizedBox(height: 5,),
                                                        Text(data.keterangan!,style: AppTypo.body1Lato,),
                                                        SizedBox(height: 5,),
                                                        Text(AppExt.toDateFormat(
                                                            data.tanggalProses!),style: AppTypo.body1Lato,)
                                                      ],
                                                    ),
                                                    Icon(
                                                      data.jenisProses ==
                                                              "pemasukan"
                                                          ? Icons.arrow_back
                                                          : Icons.arrow_forward,
                                                      color: data.jenisProses ==
                                                              "pemasukan"
                                                          ? Colors.green
                                                          : Colors.red,
                                                          size: 40,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              child: Text('Kembali'),
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.amber,
                                              ),  
                                              onPressed: () {
                                                AppExt.popScreen(context,true);
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Center(
                                    child: Text("Data kosong"),
                                  )
                            : SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  }
}
