import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

import '/ui/ui.dart';
import '/model/model.dart';
import '/remote/remote.dart';
import '../../fire_auth/fire_auth.dart';
import '../../login/login.dart';
import '/components/components.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends BaseBloc {
  // Declare stream to listen to the results returned
  BehaviorSubject<Account> accountStream = BehaviorSubject();
  BehaviorSubject<List<Room>> listRoomStream = BehaviorSubject();
  BehaviorSubject<UIState> searchStateStream = BehaviorSubject();
  BehaviorSubject<List<Province>> listProvinceStream = BehaviorSubject();

  @override
  void init() {
    getAccount();
    _getProvince();
  }

  @override
  void dispose() {
    accountStream.close();
    listRoomStream.close();
    searchStateStream.close();
    listProvinceStream.close();
  }

  void _getProvince() async {
    try {
      listProvinceStream.add([]);
      var tmp = await ManageRemote.provinceService.getAllProvince();
      listProvinceStream.add(tmp);
    } catch (e) {
      FlutterToast().showToast(e.toString());
    }
  }

  void searchRoom({
    required int numberRoom,
    required int startDay,
    required int endDay,
    required String city,
    double moneyStart = 0,
    double moneyEnd = 10000000,
    required int adults,
    required int child,
  }) {
    try {
      listRoomStream.add([]);
      searchStateStream.add(UIState.LOADING);
      FireAuth().searchRoom(numberRoom, startDay as String, endDay as String,
          city, moneyStart, moneyEnd, adults, child, (val) {
        searchStateStream.add(UIState.SUCCESS);
        listRoomStream.add(val);
      });
    } catch (e) {
      searchStateStream.add(UIState.ERROR);
      FlutterToast().showToast(e.toString());
    }
  }

  void check(BuildContext context, int active) {
    if (active == 0) {
      showDialog(
        context: context,
        builder: (_) => Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              height: 150,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Logout",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1,
                      ),
                    ),
                    const Text("Do you want to log out?"),
                    Row(
                      children: [
                        Expanded(
                          child: ReuseduceButton(
                            title: 'Cancel',
                            color: AppColors.grey,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ReuseduceButton(
                            title: 'Ok'.toUpperCase(),
                            onPressed: () {
                              FireAuth().logOut();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const LoginPage();
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }

  // Get account from firebase
  void getAccount() async {
    try {
      FireAuth().getUserByUID(
        (Account val) {
          accountStream.add(val);
        },
      );
    } catch (e) {
      FlutterToast().showToast(e.toString());
    }
  }
}
