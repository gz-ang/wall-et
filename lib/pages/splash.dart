import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wallet/function/functions.dart';
import 'package:wallet/model/database.dart';
import 'package:wallet/model/transaction.dart';
import 'package:wallet/model/wallet.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget {
  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash> {

  @override
  Widget build(BuildContext context) {
    WalletRepo wBloc = Provider.of<WalletRepo>(context);
    TransactionRepo tBloc = Provider.of<TransactionRepo>(context);
    LocalDatabase dBloc = Provider.of<LocalDatabase>(context);
    return Container(
      child: FutureBuilder(
        future: initializeDatabase(),
        builder: (_, s) {
          if (s.hasData) {
            if (s.data is Database) {
              final database = s.data;
              dBloc.setDatabase(s.data);
              return FutureBuilder(
                future: initCheckTable(database),
                builder: (_, r) {
                  if (s.connectionState == ConnectionState.done) {
                    return FutureBuilder(
                      future: getData(database),
                      builder: (_, q) {
                        if (q.hasData) {
                          final wltData = q.data[0];
                          final txnData = q.data[1];
                          wBloc.fromDatabase(wltData);
                          tBloc.fromDatabase(txnData);
                          print("database: ${dBloc.database}");
                          print("wallet: ${wBloc.walletList}");
                          print("transaction: ${tBloc.txnList}");

                        } else {
                          print("no data inserted yet");
                        }
                        return Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
                    );
                  }
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              );
            } else {
              throw ("Database not initiated");
            }

          }
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}