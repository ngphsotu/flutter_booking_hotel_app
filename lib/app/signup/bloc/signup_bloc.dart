import 'package:rxdart/rxdart.dart';

import '/components/components.dart';
import '../../fire_auth/fire_auth.dart';

class RegisterBloc extends BaseBloc {
  BehaviorSubject<UIState> registerStream = BehaviorSubject();

  @override
  void init() {}

  @override
  void dispose() {
    registerStream.close();
  }

  void register({
    required String email,
    required String pass,
    required String name,
    required String phone,
  }) {
    registerStream.add(UIState.LOADING);
    FireAuth().signUp(email, pass, name, phone, () {
      registerStream.add(UIState.SUCCESS);
      FlutterToast().showToast('Register successfully');
    }, (val) {
      registerStream.add(UIState.ERROR);
      FlutterToast().showToast(val);
    });
  }
}
