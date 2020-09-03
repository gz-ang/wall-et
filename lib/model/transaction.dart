class Transaction {
  final amount;
  final type;
  final date;
  final note;
  final category;

  Transaction({this.amount, this.type, this.date, this.note, this.category}):super();

  Transaction fromDatabase( data ) => new Transaction(
    amount: data["amount"],
    type: data["type"],
    date: data["date"],
    note: data["note"],
    category: data["category"]
  );
}