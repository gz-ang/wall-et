import 'package:flutter/cupertino.dart';

class Wallet {
  final id;
  var name;
  var balance;

  Wallet({this.id, this.name, this.balance}):super();

  Wallet fromDatabase( data ) => new Wallet(
        id: data["id"],
        name: data["name"],
        balance: (data["balance"] is num)?data["balance"]:double.parse(data["balance"])
    );

}

class WalletRepo with ChangeNotifier {
  List<Wallet> walletList = new List<Wallet>();
  Wallet currentWallet = new Wallet();
  String defaultWallet = "";



  listFromDatabase( Iterable data ) {
    data.forEach((element) {
      walletList.add(Wallet().fromDatabase(element));
    });
  }

}