import 'package:rxdart/rxdart.dart';

import '../../fire_auth/fire_auth.dart';
import '../../../components/components.dart';

class LoginBloc extends BaseBloc {
  BehaviorSubject<UIState> loginStream = BehaviorSubject();

  @override
  void init() {}

  @override
  void dispose() {
    loginStream.close();
  }

  void login({required String email, required String pass}) {
    loginStream.add(UIState.LOADING);
    FireAuth().logIn(email, pass, () {
      loginStream.add(UIState.SUCCESS);
      FlutterToast().showToast("Login successful");
    }, (val) {
      loginStream.add(UIState.ERROR);
      FlutterToast().showToast(val);
    });
  }
}
