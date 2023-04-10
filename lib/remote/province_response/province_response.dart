import 'dart:convert';

ProvinceResponse proviceResponseFromJson(String str) =>
    ProvinceResponse.fromJson(json.decode(str));

String proviceResponseToJson(ProvinceResponse data) =>
    json.encode(data.toJson());

class ProvinceResponse {
  String status;
  List<Province> provinces;

  ProvinceResponse({required this.status, required this.provinces});

  factory ProvinceResponse.fromJson(Map<String, dynamic> json) {
    return ProvinceResponse(
      status: json['status'],
      provinces: List<Province>.from(
        json['results'].map((x) => Province.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'results': List<dynamic>.from(provinces.map((x) => x.toJson())),
    };
  }
}

class Province {
  String code;
  String name;

  Province({required this.code, required this.name});

  factory Province.fromJson(Map<String, dynamic> json) {
    return Province(code: json['code'], name: json['name']);
  }

  Map<String, dynamic> toJson() => {'code': code, 'name': name};
}
