import '../model/model.dart';

class AccountUtils {
  late String uid;
  late Account account;

  static final AccountUtils _singleton = AccountUtils._internal();

  AccountUtils._internal();

  factory AccountUtils() {
    return _singleton;
  }

  void setAccount({required String uid1, Account? account1}) {
    uid = uid1;
    account = account1!;
  }
}
