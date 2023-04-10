import 'package:rxdart/rxdart.dart';

import '/model/model.dart';
import '/components/components.dart';
import '../../fire_auth/fire_auth.dart';

class AdminBloc extends BaseBloc {
  BehaviorSubject<List<Room>> listRoomStream = BehaviorSubject();
  BehaviorSubject<List<Account>> accountStream = BehaviorSubject();

  @override
  void init() {
    _getMyRoom();
    _getAllAccount();
  }

  @override
  void dispose() {
    accountStream.close();
    listRoomStream.close();
  }

  // Get My Room
  void _getMyRoom() async {
    try {
      FireAuth().getListRoomByStatus((val) {
        listRoomStream.add(val);
      });
    } catch (e) {
      FlutterToast().showToast(e.toString());
    }
  }

  // Get All Account
  void _getAllAccount() async {
    try {
      FireAuth().getListAccount((val) {
        accountStream.add(val);
      });
    } catch (e) {
      FlutterToast().showToast(e.toString());
    }
  }

  // Update Permission Account
  void updatePermission(String uid, int permission) {
    try {
      FireAuth().updatePermissionAccount(uid, permission);
      _getAllAccount();
    } catch (e) {
      FlutterToast().showToast(e.toString());
    }
  }

  // Update Status Room (approved or canceled)
  void updateStatusRoomById(String id, int status) async {
    try {
      FireAuth().updateStatusRoomById(status, id, () {
        _getMyRoom();
      });
    } catch (e) {
      FlutterToast().showToast(e.toString());
    }
  }
}
