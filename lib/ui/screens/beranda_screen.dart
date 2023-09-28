import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sertifikasi_bnsp/data/blocs/my_cash/fetch_cash_summary/fetch_cash_summary_cubit.dart';
import 'package:sertifikasi_bnsp/ui/screens/detail_cash_flow.dart';
import 'package:sertifikasi_bnsp/ui/screens/entry_screen.dart';
import 'package:sertifikasi_bnsp/ui/screens/pengaturan_screen.dart';
import 'package:sertifikasi_bnsp/utils/typography.dart' as AppTypo;
import 'package:sertifikasi_bnsp/utils/extension.dart' as AppExt;

class BerandaScreen extends StatefulWidget {
  const BerandaScreen({Key? key}) : super(key: key);

  @override
  State<BerandaScreen> createState() => _BerandaScreenState();
}

class _BerandaScreenState extends State<BerandaScreen> {
  late FetchCashSummaryCubit _fetchCashSummaryCubit;

  @override
  void initState() {
    _fetchCashSummaryCubit = FetchCashSummaryCubit()..load();
    super.initState();
  }

  @override
  void dispose() {
    _fetchCashSummaryCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _fetchCashSummaryCubit,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  width: double.infinity,
                  color: Colors.green,
                  child: BlocBuilder<FetchCashSummaryCubit, FetchCashSummaryState>(
                    builder: (context, state) {
                      return
                      state is FetchCashSummaryLoading ?
                      Center(child: CircularProgressIndicator(),) :
                      state is FetchCashSummaryFailure ?
                      Text(state.message) :
                      state is FetchCashSummarySuccess ?
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Rangkuman Bulan Ini",style: AppTypo.LatoBold,),
                            SizedBox(height: 10,),
                            Text("Pemasukan : ${state.myCash['pemasukan']}",style: AppTypo.body1Lato,),
                            SizedBox(height: 5,),
                            Text("Pengeluaran : ${state.myCash['pengeluaran']}",style: AppTypo.body1Lato,),
                          ],
                        ),
                      ): SizedBox();
                    },
                  ),
                ),
                Container(
                  // color: Colors.blue,
                  height: 200,
                  child: Image.asset('assets/images/chart.png',width: double.infinity,fit: BoxFit.cover,)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          InkWell(
                            onTap: ()async {
                              bool isRefresh = await AppExt.pushScreen(
                                  context,
                                  EntryScreen(
                                    isIncome: true,
                                  ));
                              if (isRefresh == true) {
                                _fetchCashSummaryCubit.load();
                              }
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1.5)),
                                child: Image.asset('assets/icons/income.png')),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text("Tambah Pemasukan",style: AppTypo.body1Lato,),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          InkWell(
                            onTap: ()async {
                            bool isRefresh = await  AppExt.pushScreen(
                                  context,
                                  EntryScreen(
                                    isIncome: false,
                                  ));
                            if (isRefresh == true) {
                              _fetchCashSummaryCubit.load();
                            }
                            },
                            child: Container(
                                child: Image.asset('assets/icons/poor.png'),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1.5))),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text("Tambah Pengeluaran",style: AppTypo.body1Lato,),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () async {
                              bool isRefresh = await AppExt.pushScreen(context, DetailCashFlow());
                              if (isRefresh == true) {
                              _fetchCashSummaryCubit.load();
                            }
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1.5)),
                                child: Image.asset('assets/icons/list.png')),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text("Detail Cash Flow",style: AppTypo.body1Lato,),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              AppExt.pushScreen(context, PengaturanScreen());
                            },
                            child: Container(
                                child: Image.asset('assets/icons/settings.png'),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1.5))),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text("Pengaturan",style: AppTypo.body1Lato,),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
