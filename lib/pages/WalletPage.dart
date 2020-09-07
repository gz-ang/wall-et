import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wallet/function/functions.dart';
import 'package:wallet/model/database.dart';
import 'package:wallet/model/wallet.dart';

class WalletPage extends StatefulWidget {
  final wallet;
  final database;
  WalletPage({Key key, this.wallet, this.database}):super(key: key);
  @override
  WalletPageState createState() => WalletPageState();
}

class WalletPageState extends State<WalletPage> {

  @override
  Widget build(BuildContext context) {
    WalletRepo wBloc = widget.wallet;
    LocalDatabase dBloc = widget.database;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: _build(wBloc, dBloc)
        ),
      ),
    );
  }

  List<Widget> _build(WalletRepo wBloc, LocalDatabase dBloc) {
    return List.generate(wBloc.walletList.length, (index) {
      return ListTile(
        title: Text(wBloc.walletList[index].name),
        subtitle: Text("RM ${wBloc.walletList[index].balance.toStringAsFixed(2)}"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () { },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => deleteWallet(dBloc.database, wBloc.walletList[index].name),
            )
          ],
        ),
      );
    });
  }
}