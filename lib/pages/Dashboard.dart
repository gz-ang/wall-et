import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/function/functions.dart';
import 'package:wallet/model/database.dart';
import 'package:wallet/model/transaction.dart';
import 'package:wallet/model/wallet.dart';
import 'package:wallet/pages/WalletPage.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key, this.wallet, this.transaction, this.database}):super(key: key);
  final wallet;
  final transaction;
  final database;
  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {

  int count = 0;

  @override
  Widget build(BuildContext context) {
//    WalletRepo wBloc = Provider.of<WalletRepo>(context);
//    TransactionRepo tBloc = Provider.of<TransactionRepo>(context);
  WalletRepo wBloc = widget.wallet;
  TransactionRepo tBloc = widget.transaction;
  LocalDatabase dBloc = widget.database;
    return Scaffold(
      appBar: AppBar(
        title: (wBloc.currentWallet.name == null)?
        Row(
          children: [
            Text("No wallet"),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () async{
                //TODO: add page/alert box to key in wallet details
                return showDialog(
                    context: context,
                  builder: (BuildContext context) {
                      final _tec1 = TextEditingController();
                      final _tec2 = TextEditingController();
                      return AlertDialog(
                        title: Text("New Wallet"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: _tec1,
                              decoration: InputDecoration(
                                hintText: "Example: Cash",
                                labelText: "Name",
                              ),
                            ),
                            TextField(
                              controller: _tec2,
                              decoration: InputDecoration(
                                  hintText: "Example: 100.00",
                                  labelText: "Balance",
                              ),
                            )
                          ],
                        ),
                        actions: [
                          FlatButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text("BACK"),
                          ),
                          FlatButton(
                            onPressed: () async{
                              if (_tec2.text == null) {
                                _tec2.text = "0.00";
                                print(_tec2.text);
                              }

                              if (_tec1.text != null && _tec2.text != null && double.tryParse(_tec2.text) is num) {
                                Navigator.of(context).pop();
                                return showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      createWallet(dBloc.database, _tec1.text, double.parse(_tec2.text)).then((response) {
                                        print(response);
                                        Navigator.pop(context);
                                        if (response == null) {
                                          print("existed");
                                          return showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text("Wallet already exist"),
                                                content: Text("Please use another name"),
                                                actions: [
                                                  FlatButton(
                                                    child: Text("OK"),
                                                    onPressed: () => Navigator.pop(context),
                                                  )
                                                ],
                                              );
                                            }
                                          );

                                        } else if (response is num) {
                                          wBloc.listFromDatabase([{"name": _tec1.text, "balance": double.parse(_tec2.text)}]);
                                          wBloc.currentWallet.name = _tec1.text;
                                          wBloc.currentWallet.balance = double.parse(_tec2.text);
                                          return showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text("Wallet created"),
                                                content: Text("Your wallet ${_tec1.text} is ready to use"),
                                                actions: [
                                                  FlatButton(
                                                    child: Text("OK"),
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                      setState(() {

                                                      });
                                                    },
                                                  )
                                                ],
                                              );
                                            }
                                          );

                                        } else {
                                          return showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text("Uh-oh"),
                                                content: Text("It appears something went wrong, please try again"),
                                                actions: [
                                                  FlatButton(
                                                    child: Text("OK"),
                                                    onPressed: () => Navigator.of(context).pop(),
                                                  )
                                                ],
                                              );
                                            }
                                          );

                                        }
                                      });

                                      return AlertDialog(
                                        content: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                            CircularProgressIndicator(),
                                        ],
                                      ),
                                      );
                                    }
                                );

                              } else {
                                print("err");
                              }
                            },
                            child: Text("OK")
                          )
                        ],
                      );
                  }
                );
              },
            )
          ],
        )
            :GestureDetector(
          child: Column(
            children: [
              //TODO: edit wallet balance
              Container(
                width: MediaQuery.of(context).size.width,
                child: Text("${wBloc.currentWallet.name}"),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Text("RM${wBloc.currentWallet.balance.toStringAsFixed(2)}"),
              )

            ],
          ),
          onTap: () {
            //TODO: show wallet page, to edit and delete
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => WalletPage(wallet: wBloc, database: dBloc,)));
          },
        )
      ),
      body: Container(
        child: Column(
          children: (tBloc.txnList.isEmpty)
              ?[Text("No transaction history")]
                :_build(tBloc),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async{
          //TODO: add transaction
          print(wBloc.currentWallet.name);
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