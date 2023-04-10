import 'package:rxdart/rxdart.dart';

import '/model/model.dart';
import '../../fire_auth/fire_auth.dart';
import '/components/components.dart';

class HotelBloc extends BaseBloc {
  BehaviorSubject<MyHotel> myHotelStream = BehaviorSubject();
  BehaviorSubject<UIState> myHotelStateStream = BehaviorSubject();
  BehaviorSubject<List<Room>> listRoomStream = BehaviorSubject();

  @override
  void init() {
    getMyHotel();
    getMyRoom();
  }

  @override
  void dispose() {
    myHotelStream.close();
    myHotelStateStream.close();
    listRoomStream.close();
  }

  // Get My Hotel
  void getMyHotel() async {
    try {
      myHotelStateStream.add(UIState.LOADING);
      FireAuth().getHotel((val) {
        myHotelStream.add(val);
      });
      myHotelStateStream.add(UIState.SUCCESS);
    } catch (e) {
      myHotelStateStream.add(UIState.ERROR);
      FlutterToast().showToast(e.toString());
    }
  }

  // Get My Room
  void getMyRoom() async {
    try {
      listRoomStream.add([]);
      FireAuth().getListRoomByID((val) {
        listRoomStream.add(val);
      });
    } catch (e) {
      FlutterToast().showToast(e.toString());
    }
  }
}
