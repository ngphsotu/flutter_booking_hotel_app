// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/model/model.dart';
import '/components/components.dart';

class FireAuth {
  final _fireBaseAuth = FirebaseAuth.instance;
  final _fireStoreInstance = FirebaseFirestore.instance;

  // Method Login
  void logIn(String email, String pass, Function onSuccess,
      Function(String) onSignInError) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _fireBaseAuth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((user) {
      prefs.setString('uid', user.user!.uid);
      onSuccess();
    }).catchError((err) {
      print('Error: $err');
      onSignInError('Login Fail, Please Try Again!');
    });
  }

  // Method Logout
  Future<void> logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('Logout');
    prefs.setString('uid', '');
    return _fireBaseAuth.signOut();
  }

  // Method Forgot Password
  void forgotPassWordByEmail(
      String email, Function onSuccess, Function(String) onSignInError) {
    _fireBaseAuth.sendPasswordResetEmail(email: email).then((doc) {
      onSuccess();
    }).catchError((err) {
      print('Error: $err');
      _onResetPass(err.code, (val) {
        print(val);
      });
    });
  }

  // Method Reset Pass
  void _onResetPass(String code, Function(String) onRegisterError) {
    print(code);
    switch (code) {
      case 'invalid-email':
        onRegisterError('Invalid Email, Please Try Again!');
        break;
      case 'user-not-found':
        onRegisterError('Email Doesn\'t Exist, Please Try Again!');
        break;
      default:
        onRegisterError('Reset Password Fail, Please Try Again!');
        break;
    }
  }

  // Method Sign Up
  void signUp(String email, String pass, String name, String phone,
      Function onSuccess, Function(String) onRegisterError) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _fireBaseAuth
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((user) {
      prefs.setString('uid', user.user!.uid);
      _createUser(user.user!.uid, user.user!.email.toString(), name, phone,
          onSuccess, onRegisterError);
    }).catchError((err) {
      _onSignUpErr(err.code, onRegisterError);
      print('Error: $err');
    });
  }

  // Method Create User
  void _createUser(String userId, String name, String phone, String email,
      Function onSuccess, Function(String) onRegisterError) {
    _fireStoreInstance.collection('users').doc(userId).set({
      'name': name,
      'phone': phone,
      'email': email,
      'isActive': 1,
      'permission': 0,
      'avatar': 'https',
      'create_day': DateTime.now().millisecondsSinceEpoch
    }).then((_) {
      print('Success!');
      onSuccess();
    });
    _fireStoreInstance
        .collection('transaction_history')
        .doc(userId)
        .collection('transaction')
        .add({}).then((_) {
      print('Success!');
    });
  }

  // Method Signup Error
  void _onSignUpErr(String code, Function(String) onRegisterError) {
    print(code);
    switch (code) {
      case 'invalid-email':
        onRegisterError('Invalid Email, Please Try Again!');
        break;
      case 'user-not-found':
        onRegisterError('Email Doesn\'t Exist, Please Try Again!');
        break;
      default:
        onRegisterError('Reset Password Fail, Please Try Again!');
        break;
    }
  }

  // Method Get User By UID
  void getUserByUID(Function callBack) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await _fireStoreInstance.collection('users').get().then((querySnapshot) {
      for (var element in querySnapshot.docs) {
        if (prefs.getString('uid') == element.id) {
          Account account = Account.formJson(element.data(), element.id);
          callBack(account);
        }
      }
    });
  }

  // Method Get List Account
  void getListAccount(Function callBack) async {
    List<Account> listAccount = [];
    await _fireStoreInstance.collection('users').get().then((querySnapshot) {
      for (var element in querySnapshot.docs) {
        listAccount.add(Account.formJson(element.data(), element.id));
      }
    });
    callBack(listAccount);
  }

  // Method Update Avatar
  void updateAvatar(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _fireStoreInstance
        .collection('users')
        .doc(prefs.getString('uid'))
        .update({'avatar': url}).then((_) {
      FlutterToast().showToast('Success!');
    });
  }

  // Method Update Password
  void updatePassword(String pass) {
    var user = FirebaseAuth.instance.currentUser;
    user!
        .updatePassword(pass)
        .then((value) =>
            FlutterToast().showToast('Change Password Successfully!'))
        .catchError((e) {
      FlutterToast().showToast(e.code);
    });
  }

  // Method Update Info Account
  void updateInfoAccount(String name, String phone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _fireStoreInstance
        .collection('users')
        .doc(prefs.getString('uid'))
        .update({'name': name, 'phone': phone}).then((_) {
      FlutterToast().showToast('Success!');
    });
  }

  // Method Update Permission Account (User Admin - Normal User)
  void updatePermissionAccount(String uid, int permission) {
    _fireStoreInstance
        .collection('users')
        .doc(uid)
        .update({'permission': permission}).then((_) {
      FlutterToast().showToast('Success!');
    });
  }

  // Method Get Hotel By ID
  void getHotelById(Function callBack, String id) async {
    await _fireStoreInstance
        .collection('home_stay')
        .get()
        .then((querySnapshot) {
      for (var element in querySnapshot.docs) {
        if (id == element.id) {
          MyHotel myHotel = MyHotel.formJson(element.data());
          callBack(myHotel);
        }
      }
    });
  }

  // Method Get Room By ID
  void getRoomById(Function callBack, String id) async {
    await _fireStoreInstance.collection('room').get().then((querySnapshot) {
      for (var element in querySnapshot.docs) {
        if (id == element.id) {
          Room room = Room.formJson(element.data(), element.id);
          callBack(room);
        }
      }
    });
  }

  // Method Get List Room By ID
  void getListRoomByID(Function callBack, String id) async {
    try {
      List<Room> listRooms = [];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await _fireStoreInstance.collection('room').get().then((querySnapshot) {
        for (var element in querySnapshot.docs) {
          if (element.data()['id_hotel'] == (id == prefs.getString('uid'))) {
            listRooms.add(Room.formJson(element.data(), element.id));
          }
        }
      });
      callBack(listRooms);
    } catch (e) {
      print(e);
    }
  }

  // Method Get List Transaction
  void getListTransaction(Function callBack) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Transactions> listTransaction = [];
    await _fireStoreInstance.collection('order').get().then((querySnapshot) {
      for (var element in querySnapshot.docs) {
        if (element.data()['id_user'] == prefs.getString('uid')) {
          try {
            listTransaction
                .add(Transactions.formJson(element.data(), element.id));
          } catch (e) {
            print(e);
          }
        }
      }
    });
    callBack(listTransaction);
  }

  // Method Get Hotel
  void getHotel(Function callBack) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await _fireStoreInstance
        .collection('home_stay')
        .get()
        .then((querySnapshot) {
      for (var element in querySnapshot.docs) {
        if (prefs.getString('uid') == element.id) {
          MyHotel myHotel = MyHotel.formJson(element.data());
          callBack(myHotel);
        }
      }
    });
  }

  // Method Create My Hotel
  void createMyHotel(
      String urlImage,
      String name,
      String phone,
      String bankName,
      String bankNumber,
      String accountName,
      Function onSuccess,
      Function(String) onRegisterError) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _fireStoreInstance.collection('home_stay').doc(prefs.getString('uid')).set({
      'name': name.toLowerCase(),
      'url_image': urlImage,
      'phone': phone,
      'status': 1,
      'list_review': [],
      'bank': {
        'name': bankName,
        'number': bankNumber,
        'account_name': accountName,
      },
      'create_day': DateTime.now().toIso8601String()
    }).then((e) {
      FlutterToast().showToast('Success!');
      onSuccess();
    });
  }

  // Method Update My Hotel
  void updateMyHotel(
      String urlImage,
      String name,
      String phone,
      String bankName,
      String bankNumber,
      String accountName,
      Function onSuccess,
      Function(String) onRegisterError) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _fireStoreInstance
        .collection('home_stay')
        .doc(prefs.getString('uid'))
        .update({
      'name': name.toLowerCase(),
      'url_image': urlImage,
      'phone': phone,
      'bank': {
        'name': bankName,
        'number': bankNumber,
        'account_name': accountName
      },
    }).then((e) {
      FlutterToast().showToast('Success!');
      onSuccess();
    });
  }

  // Method Delete My Hotel
  void deleteMyHotel(Function onSuccess, Function onRegisterError) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _fireStoreInstance.collection('room').get().then((querySnapshot) {
      for (var element in querySnapshot.docs) {
        if (element.data()['id_hotel'] == prefs.getString('uid')) {
          _fireStoreInstance
              .collection('room')
              .doc(element.id)
              .delete()
              .then((_) {
            FlutterToast().showToast('Success!');
          }).catchError((e) {
            onRegisterError();
            FlutterToast().showToast(e.message);
          });
        }
      }
      _fireStoreInstance
          .collection('home_stay')
          .doc(prefs.getString('uid'))
          .delete()
          .then((e) {
        FlutterToast().showToast('Success!');
        onSuccess();
      }).catchError((e) {
        onRegisterError();
        FlutterToast().showToast(e.message);
      });
    });
  }

// Method Get List Room By Status
  void getListRoomByStatus(Function callBack, {int status = 1}) async {
    try {
      List<Room> listRooms = [];
      await _fireStoreInstance.collection('room').get().then((querySnapshot) {
        for (var element in querySnapshot.docs) {
          if (element.data()['status'] == status) {
            listRooms.add(Room.formJson(element.data(), element.id));
          }
        }
      });
      callBack(listRooms);
    } catch (e) {
      print(e);
    }
  }

  // Method Update Room Status By ID
  void updateStatusRoomById(int status, String id, Function success) {
    _fireStoreInstance
        .collection('room')
        .doc(id)
        .update({'status': status}).then((_) {
      success();
      FlutterToast().showToast('Success!');
    });
  }

  // Method Create Order
  void createOrder(
      String idRoom,
      String checkIn,
      String checkOut,
      int night,
      int numberRoom,
      double totalPrice,
      Function onSuccess,
      Function(String) onRegisterError) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _fireStoreInstance.collection('order').add({
      'id_user': prefs.getString('uid'),
      'id_room': idRoom,
      'check_in': checkIn,
      'check_out': checkOut,
      'night': night,
      'status': 0,
      'number_room': numberRoom,
      'total_price': totalPrice,
      'create_day': DateTime.now().toIso8601String()
    }).then((e) {
      onSuccess();
      FlutterToast().showToast('Success!');
    });
  }

  // Method Update Status Order
  void updateOrderStatus(int status, String id, Function success) {
    _fireStoreInstance
        .collection('order')
        .doc(id)
        .update({'status': status}).then((_) {
      success();
      FlutterToast().showToast('Success!');
    });
  }

  // Method Create New Room
  void createNewRoom(
      String urlImage,
      String name,
      String startDay,
      String endDay,
      int adults,
      int child,
      String address,
      String city,
      String desc,
      double price,
      double discount,
      int numberRoom,
      Function onSuccess,
      Function(String) onRegisterError) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _fireStoreInstance.collection('room').add({
      'name_room': name.toLowerCase(),
      'start_day': startDay,
      'end_day': endDay,
      'status': 1,
      'number_room': numberRoom,
      'number_adults': adults,
      'number_child': child,
      'address': address,
      'city': city.toLowerCase(),
      'desc': desc,
      'create_day': DateTime.now().toIso8601String(),
      'money': price,
      'id_hotel': prefs.getString('uid'),
      'url_image': urlImage,
      'service': [1, 2, 3, 4],
      'discount': discount,
    }).then((e) {
      onSuccess();
      FlutterToast().showToast('Success!');
    });
  }

  // Method Update Room
  void updateRoom(
      String urlImage,
      int numberRoom,
      String name,
      String id,
      String startDay,
      String endDay,
      int adults,
      int child,
      String address,
      String city,
      String desc,
      double price,
      double discount,
      Function onSuccess,
      Function(String) onRegisterError) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _fireStoreInstance.collection('room').doc(id).update({
      'name_room': name.toLowerCase(),
      'start_day': startDay,
      'end_day': endDay,
      'status': 1,
      'number_room': numberRoom,
      'number_adults': adults,
      'number_child': child,
      'address': address,
      'city': city.toLowerCase(),
      'desc': desc,
      'create_day': DateTime.now().toIso8601String(),
      'money': price,
      'id_hotel': prefs.getString('uid'),
      'url_image': urlImage,
      'service': [1, 2, 3, 4],
      'discount': discount,
    }).then((e) {
      onSuccess();
      FlutterToast().showToast('Success!');
    });
  }

// Method Search Room
  void searchRoom(
      int numberRoom,
      String startDay,
      String endDay,
      String city,
      double moneyStart,
      double moneyEnd,
      int adults,
      int child,
      Function(List<Room>) callBack) async {
    try {
      List<Room> listRooms = [];
      var result = await _fireStoreInstance
          .collection('room')
          .where('status', isEqualTo: 2)
          .where('city', isEqualTo: city.toLowerCase())
          .where('number_adults', isEqualTo: adults)
          .where('number_child', isEqualTo: child)
          .get();
      for (var element in result.docs) {
        if (element.data()['money'] >= moneyStart &&
            element.data()['money'] <= moneyEnd &&
            element.data()['number_room'] >= numberRoom) {
          listRooms.add(Room.formJson(element.data(), element.id));
        }
      }
      callBack(listRooms);
    } catch (e) {
      print(e);
    }
  }

  // Method Delete Room
  void deleteRoomById(String id, Function success, Function error) {
    _fireStoreInstance.collection('room').doc(id).delete().then((_) {
      success();
      FlutterToast().showToast('Success!');
    }).catchError((e) {
      error();
      FlutterToast().showToast(e.message);
    });
  }
}
