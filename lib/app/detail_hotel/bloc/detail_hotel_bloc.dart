import 'package:rxdart/rxdart.dart';

import '/model/model.dart';
import '../../fire_auth/fire_auth.dart';
import '/components/components.dart';

class DetailBloc extends BaseBloc {
  BehaviorSubject<MyHotel> myHotelStream = BehaviorSubject();

  @override
  void init() {}

  @override
  void dispose() {
    myHotelStream.close();
  }

  void getMyHotel(String id) async {
    try {
      FireAuth().getHotelById((val) {
        myHotelStream.add(val);
      }, id);
    } catch (e) {
      FlutterToast().showToast(e.toString());
    }
  }
}
