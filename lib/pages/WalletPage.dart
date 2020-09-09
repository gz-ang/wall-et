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
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditWallet(wallet: wBloc.walletList[index],)));
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async{
                await showDialog(
                    context: context,
                  builder: (BuildContext context) {
                     var _tec = TextEditingController();
                      return AlertDialog(
                        title: Text("Are you sure you want to delete ${wBloc.walletList[index].name}"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Enter the name of the wallet to confirm"),
                            TextField(
                              controller: _tec,
                            )
                          ],
                        ),
                        actions: [
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              return showDialog(context: context,
                                // ignore: missing_return
                                builder: (BuildContext context) {
                                  if (_tec.text == wBloc.walletList[index].name) {
                                    deleteWallet(dBloc.database, wBloc.walletList[index].name).then((value) {
                                      if (value == 1) {
                                        return AlertDialog(
                                          title: Text("Delete Successful"),
                                          content: Text("Wallet ${wBloc.walletList[index].name} has been deleted"),
                                          actions: [
                                            FlatButton(
                                              onPressed: () => Navigator.of(context).pop(),
                                              child: Text("OK"),
                                            )
                                          ],
                                        );
                                      } else {
                                        return AlertDialog(
                                          title: Text("Delete Unsuccessful"),
                                          content: Text("Something went wrong, please try again"),
                                          actions: [
                                            FlatButton(
                                              onPressed: () => Navigator.of(context).pop(),
                                              child: Text("OK"),
                                            )
                                          ],
                                        );
                                      }
                                    });

                                  } else {
                                    return AlertDialog(
                                      title: Text("Wallet name not match"),
                                      content: Text("Please enter the correct wallet name to proceed"),
                                      actions: [
                                        FlatButton(
                                          onPressed: () => Navigator.of(context).pop(),
                                          child: Text("OK"),
                                        )
                                      ],
                                    );
                                  }
                                }
                              );

                            },
                            child: Text("Confirm"),
                          ),
                          FlatButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text("Back")
                          )
                        ],
                      );
                  }
                );

              },
            )
          ],
        ),
      );
    });
  }
}

class EditWallet extends StatelessWidget {
  final Wallet wallet;
  final LocalDatabase database;
  EditWallet({this.wallet, this.database});
  List<TextEditingController> _tec = [new TextEditingController(), new TextEditingController()];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            TextField(
              controller: _tec[0],
              decoration: InputDecoration(
                labelText: "Wallet Name",
                helperText: "current: ${wallet.name}"
              ),
            ),
            TextField(
              controller: _tec[1],
              decoration: InputDecoration(
                  labelText: "Wallet Balance",
                  helperText: "current: RM${wallet.balance.toStringAsFixed(2)}"
              ),
            ),
            RaisedButton(
              child: Text("OK"),
              onPressed: () {
                var name;
                var bal;
                if (_tec[0].text.isEmpty) {
                  name = wallet.name;
                } else {
                  name = _tec[0].text;
                }
                if (_tec[1].text.isEmpty) {
                  bal = wallet.balance;
                } else {
                  bal = _tec[1].text;
                }
                updateWallet(database.database, name, bal);
              },
            )
          ],
        ),
      ),
    );
  }
}