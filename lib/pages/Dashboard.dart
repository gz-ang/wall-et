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
      appBar: AppBar(
        title: (wBloc.currentWallet.name.isEmpty)?
        Row(
          children: [
            Text("No wallet"),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                //TODO: add page/alert box to key in wallet details
              },
            )
          ],
        )
            :Column(
          children: [
            //TODO: edit wallet balance
          Text("${wBloc.currentWallet.name}"),
          Text("${wBloc.currentWallet.balance}")
        ],
        ),
      ),
      body: Container(
        child: Column(
          children: (tBloc.txnList.isEmpty)
              ?Text("No transaction history")
                :_build(tBloc),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          //TODO: add transaction
        },
      ),
    );
  }

  List<Widget> _build(TransactionRepo tBloc) {
    return List.generate(tBloc.txnList.length, (index) {
      //TODO: What to display
      return ListTile();
    });
  }
}