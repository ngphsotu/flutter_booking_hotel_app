import 'dart:convert' as convert;
import 'package:http/http.dart';
import 'province_response.dart';

///ProvinceService (clone API)
class ProvinceService {
  Future<List<Province>> getAllProvince() async {
    try {
      var response = await get(
        Uri.parse('https://api.mysupership.vn/v1/partner/areas/province'),
      );

      var jsonResponse = convert.jsonDecode(response.body);

      if (jsonResponse['status'] == 'Success') {
        return ProvinceResponse.fromJson(jsonResponse).provinces;
      }

      throw Exception('');
    } catch (e) {
      throw Exception('');
    }
  }
}
