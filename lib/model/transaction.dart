class Transactions {
  String idRoom;
  String id;
  String checkIn;
  String idUser;
  String checkOut;
  String createDay;
  int night;
  int status;
  int numberRoom;
  double totalMoney;

  Transactions({
    required this.idRoom,
    required this.id,
    required this.checkIn,
    required this.idUser,
    required this.checkOut,
    required this.createDay,
    required this.night,
    required this.status,
    required this.numberRoom,
    required this.totalMoney,
  });

  factory Transactions.formJson(Map<String, dynamic> json, String id) {
    return Transactions(
      idRoom: json['id_room'],
      id: id,
      checkIn: json['check_in'],
      idUser: json['id_user'],
      checkOut: json['check_out'],
      createDay: json['create_day'],
      night: json['night'],
      status: json['status'] ?? 0,
      numberRoom: json['number_room'],
      totalMoney: json['total_price'],
    );
  }
}
