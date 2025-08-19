class Info {
  final int id;
  final String userName;
  final int account;
  final int balance;

  Info({required this.id, required this.userName, required this.account, required this.balance});

  factory Info.fromJson(Map<dynamic, dynamic> json) {
    return Info(
      id: json["id"],
      userName: json["userName"],
      account: json["account"],
      balance: json["balance"]
    );
  }
}