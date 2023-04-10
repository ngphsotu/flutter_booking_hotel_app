class MyHotel {
  String name;
  String phone;
  List<int> listReviews;
  String createDay;
  int status;
  String urlImage;
  String accountNameBank;
  String bankNumber;
  String bankName;

  MyHotel({
    required this.name,
    required this.phone,
    required this.listReviews,
    required this.createDay,
    required this.status,
    required this.urlImage,
    required this.accountNameBank,
    required this.bankNumber,
    required this.bankName,
  });

  factory MyHotel.formJson(Map<String, dynamic> json) {
    return MyHotel(
      name: json['name'],
      phone: json['phone'],
      listReviews: json['list_review'].cast<int>() ?? [].cast<int>(),
      createDay: json['create_day'],
      status: json['status'] ?? 1,
      urlImage: json['url_image'],
      accountNameBank: json['bank']['account_name'],
      bankNumber: json['bank']['number'],
      bankName: json['bank']['name'],
    );
  }
}
