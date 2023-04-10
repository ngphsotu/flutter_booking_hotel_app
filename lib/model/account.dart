class Account {
  final String uid;
  final String name;
  final String phone;
  final String email;
  final String avatar;
  final int isActive;
  final int createDay;
  final int permission;

  Account({
    required this.uid,
    required this.name,
    required this.phone,
    required this.email,
    required this.avatar,
    required this.isActive,
    required this.createDay,
    required this.permission,
  });

  factory Account.formJson(Map<String, dynamic> json, String uid) {
    return Account(
      uid: uid,
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      avatar: json['avatar'] ?? '',
      isActive: json['isActive'],
      createDay: json['create_day'] ?? DateTime.now().millisecondsSinceEpoch,
      permission: json['permission'],
    );
  }
}
