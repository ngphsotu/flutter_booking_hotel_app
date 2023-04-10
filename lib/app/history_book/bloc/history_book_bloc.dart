import 'package:rxdart/rxdart.dart';

import '/model/model.dart';
import '../../fire_auth/fire_auth.dart';
import '/components/components.dart';

class HistoryBookingBloc extends BaseBloc {
  BehaviorSubject<Room> myRoomStream = BehaviorSubject();
  BehaviorSubject<UIState> historyBookingStateStream = BehaviorSubject();
  BehaviorSubject<List<Transactions>> historyBookingStream1 = BehaviorSubject();
  BehaviorSubject<List<Transactions>> historyBookingStream2 = BehaviorSubject();
  BehaviorSubject<List<Transactions>> historyBookingStream3 = BehaviorSubject();
  BehaviorSubject<List<Transactions>> historyBookingStream4 = BehaviorSubject();

  @override
  void init() {
    getHistoryBooking();
  }

  @override
  void dispose() {
    historyBookingStateStream.close();
    historyBookingStream1.close();
    historyBookingStream2.close();
    historyBookingStream3.close();
    historyBookingStream4.close();
    myRoomStream.close();
  }

  // Get Room
  void getRoom(String id) async {
    try {
      FireAuth().getRoomById((val) {
        myRoomStream.add(val);
      }, id);
    } catch (e) {
      FlutterToast().showToast(e.toString());
    }
  }

  // Get Book History
  void getHistoryBooking() async {
    List<Transactions> history1 = [];
    List<Transactions> history2 = [];
    List<Transactions> history3 = [];
    List<Transactions> history4 = [];
    historyBookingStateStream.add(UIState.LOADING);
    try {
      historyBookingStream1.add(history1);
      historyBookingStream2.add(history2);
      historyBookingStream3.add(history3);
      historyBookingStream4.add(history4);
      historyBookingStateStream.add(UIState.SUCCESS);
      FireAuth().getListTransaction((val) {
        val.forEach((element) {
          switch (element.status) {
            case 0:
              history1.add(element);
              break;
            case 1:
              history2.add(element);
              break;
            case 2:
              history3.add(element);
              break;
            case 3:
              history4.add(element);
              break;
          }
        });
      });
    } catch (e) {
      historyBookingStateStream.add(UIState.ERROR);
      FlutterToast().showToast(e.toString());
    }
  }
}
