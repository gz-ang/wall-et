import 'package:flutter/cupertino.dart';

class Wallet {
  final name;
  var balance;

  Wallet({this.name, this.balance}):super();

  Wallet fromDatabase( data ) => new Wallet(
    name: data["name"],
    balance: data["balance"]
  );
}

class WalletRepo with ChangeNotifier {
  List<Wallet> walletList = new List<Wallet>();
  Wallet currentWallet = new Wallet();

  fromDatabase( Iterable data ) {
    data.forEach((element) {
      walletList.add(Wallet().fromDatabase(element));
    });
  }

}