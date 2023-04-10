class Room {
  String nameRoom;
  String idRoom;
  String startDay;
  String endDay;
  int numberRoom;
  int numberAdults;
  int numberChild;
  String address;
  String city;
  double discount;
  String desc;
  int status;
  String createDay;
  double money;
  String idHotel;
  String urlImage;
  List<int> service;

  Room({
    required this.nameRoom,
    required this.idRoom,
    required this.startDay,
    required this.endDay,
    required this.numberRoom,
    required this.numberAdults,
    required this.numberChild,
    required this.address,
    required this.city,
    required this.discount,
    required this.desc,
    required this.status,
    required this.createDay,
    required this.money,
    required this.idHotel,
    required this.urlImage,
    required this.service,
  });

  factory Room.formJson(Map<String, dynamic> json, String id) {
    return Room(
      nameRoom: json['name_room'],
      idRoom: id,
      startDay: json['start_day'] ?? DateTime.now().millisecondsSinceEpoch,
      endDay: json['end_day'] ?? DateTime.now().millisecondsSinceEpoch,
      numberRoom: json['number_room'] ?? 0,
      numberAdults: json['number_adults'],
      numberChild: json['number_child'],
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      discount: json['discount'],
      desc: json['desc'],
      status: json['status'],
      createDay: json['create_day'] ?? DateTime.now().toIso8601String(),
      money: json['money'],
      idHotel: json['id_hotel'],
      urlImage: json['url_image'],
      service: json['service'].cast<int>(),
    );
  }
}
