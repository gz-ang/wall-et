class Wallet {
  final name;
  var balance;

  Wallet({this.name, this.balance}):super();

  Wallet fromDatabase( data ) => new Wallet(
    name: data["name"],
    balance: data["balance"]
  );
}