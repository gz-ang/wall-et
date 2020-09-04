import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/model/database.dart';
import 'package:wallet/model/transaction.dart';
import 'package:wallet/model/wallet.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key, this.wallet, this.transaction, this.database}):super(key: key);
  final wallet;
  final transaction;
  final database;
  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {

  @override
  Widget build(BuildContext context) {
//    WalletRepo wBloc = Provider.of<WalletRepo>(context);
//    TransactionRepo tBloc = Provider.of<TransactionRepo>(context);
  WalletRepo wBloc = widget.wallet;
  TransactionRepo tBloc = widget.transaction;
  LocalDatabase dBloc = widget.database;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}