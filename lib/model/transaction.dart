import 'package:flutter/cupertino.dart';

class Transaction {
  final id;
  var amount;
  var type;
  var date;
  var note;
  var category;
  var wid;

  Transaction({this.id, this.amount, this.type, this.date, this.note, this.category, this.wid}):super();

  Transaction fromDatabase( data ) => new Transaction(
    id: data["id"],
    amount: data["amount"],
    type: data["type"],
    date: data["date"],
    note: data["note"],
    category: data["category"],
    wid: data["walletid"]
  );
}

class TransactionRepo with ChangeNotifier {
  List<Transaction> txnList = new List<Transaction>();

  fromDatabase( Iterable data ) {
    data.forEach((element) {
      txnList.add(Transaction().fromDatabase(element));
    });
  }

}