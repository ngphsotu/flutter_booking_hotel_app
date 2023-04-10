// ignore_for_file: import_of_legacy_library_into_null_safe, library_prefixes

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

import '/ui/ui.dart';
import '../home.dart';
import '/model/model.dart';
import '/utils/utils.dart';
import '/remote/remote.dart';
import '../../login/login.dart';
import '../../search/search.dart';
import '../../profile/profile.dart';
import '/components/components.dart';
import '../../fire_auth/fire_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int child = 0;
  int adults = 0;
  int numberRoom = 0;
  final _formKey = GlobalKey<FormState>();
  late final int endDay;
  late final int startDay;
  late final HomeBloc homeBloc;
  late final ThemeData themeData;
  late final TextEditingController controllerCity;
  late final TextEditingController controllerTime;
  late final TextEditingController controllerSearch;

  @override
  void initState() {
    super.initState();
    controllerCity = TextEditingController();
    controllerSearch = TextEditingController();
    controllerTime = TextEditingController();
    homeBloc = HomeBloc()..init();
    homeBloc.searchStateStream.listen((value) {
      if (value == UIState.SUCCESS) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return OutputSearchPage(homeBloc: homeBloc);
        }));
        homeBloc.searchStateStream.add(UIState.NONE);
      }
    });
  }

  @override
  void dispose() {
    homeBloc.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    themeData = Provider.of<ThemeChanger>(context).getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightgrey,
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 50, 10, 10),
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const ProfilePage();
                                },
                              ),
                            );
                            homeBloc.getAccount();
                          },
                          child: StreamBuilder<Account>(
                            stream: homeBloc.accountStream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Container(
                                  width: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image:
                                          NetworkImage(snapshot.data!.avatar),
                                    ),
                                  ),
                                );
                              } else {
                                return const Center();
                              }
                            },
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.logout,
                            color: AppColors.primaryColor,
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => Scaffold(
                                backgroundColor: Colors.transparent,
                                body: Center(
                                  child: Container(
                                    width: 200,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      color: themeData.scaffoldBackgroundColor,
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 20, 10, 15),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Logout'.toUpperCase(),
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w900,
                                              letterSpacing: 1,
                                            ),
                                          ),
                                          const Text('Do you want to log out?'),
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
                                                  color: AppColors.grey,
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
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: AssetImage('assets/images/home.png'),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 2.5, 0, 0),
                            child: TextFormField(
                              controller: controllerSearch,
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Search',
                                hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                ),
                                suffixIcon: IconButton(
                                  icon: const Icon(
                                    Icons.search,
                                    color: AppColors.primaryColor,
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      OrderUtils().setOrder(
                                          startDay, endDay, numberRoom);
                                      homeBloc.searchRoom(
                                        numberRoom: numberRoom,
                                        startDay: startDay,
                                        endDay: endDay,
                                        city: controllerCity.text,
                                        child: child,
                                        adults: adults,
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: themeData.scaffoldBackgroundColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            StreamBuilder<List<Province>>(
                              stream: homeBloc.listProvinceStream,
                              builder: (context, snapshot1) {
                                if (snapshot1.hasData) {
                                  List<ItemModel> items = [];
                                  for (var element in snapshot1.data!) {
                                    items.add(
                                      ItemModel(
                                        id: element.code,
                                        name: element.name,
                                      ),
                                    );
                                  }
                                  return ReuseduceTextFieldChoose(
                                    items: items,
                                    iconData: Icons.location_pin,
                                    hintText: 'Where is Your Location ?',
                                    callBack: (val) {
                                      controllerCity.text = val;
                                    },
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              },
                            ),
                            const SizedBox(height: 15),
                            ReuseduceTextFieldChoose(
                              iconData: Icons.room_preferences,
                              hintText: 'How Many Rooms ?',
                              callBack: (val) {
                                numberRoom = int.parse(val);
                              },
                              items: [
                                ItemModel(id: '01', name: '01'),
                                ItemModel(id: '02', name: '02'),
                                ItemModel(id: '03', name: '03'),
                                ItemModel(id: '04', name: '04'),
                                ItemModel(id: '05', name: '05'),
                                ItemModel(id: '06', name: '06'),
                                ItemModel(id: '07', name: '07'),
                                ItemModel(id: '08', name: '08'),
                                ItemModel(id: '09', name: '09'),
                                ItemModel(id: '10', name: '10'),
                              ],
                            ),
                            const SizedBox(height: 15),
                            ReuseduceTextFieldChoose(
                              iconData: Icons.people,
                              hintText: 'How Many Adults ?',
                              callBack: (val) {
                                adults = int.parse(val);
                              },
                              items: [
                                ItemModel(id: '01', name: '01'),
                                ItemModel(id: '02', name: '02'),
                                ItemModel(id: '03', name: '03'),
                                ItemModel(id: '04', name: '04'),
                                ItemModel(id: '05', name: '05'),
                                ItemModel(id: '06', name: '06'),
                                ItemModel(id: '07', name: '07'),
                                ItemModel(id: '08', name: '08'),
                                ItemModel(id: '09', name: '09'),
                                ItemModel(id: '10', name: '10'),
                                ItemModel(id: '11', name: '11'),
                                ItemModel(id: '12', name: '12'),
                                ItemModel(id: '13', name: '13'),
                                ItemModel(id: '14', name: '14'),
                                ItemModel(id: '15', name: '15'),
                                ItemModel(id: '16', name: '16'),
                                ItemModel(id: '17', name: '17'),
                                ItemModel(id: '18', name: '18'),
                                ItemModel(id: '19', name: '19'),
                                ItemModel(id: '20', name: '20'),
                              ],
                            ),
                            const SizedBox(height: 15),
                            ReuseduceTextFieldChoose(
                              iconData: Icons.emoji_people,
                              hintText: 'How Many Children ?',
                              callBack: (val) {
                                child = int.parse(val);
                              },
                              items: [
                                ItemModel(id: '00', name: '00'),
                                ItemModel(id: '01', name: '01'),
                                ItemModel(id: '02', name: '02'),
                                ItemModel(id: '03', name: '03'),
                                ItemModel(id: '04', name: '04'),
                                ItemModel(id: '05', name: '05'),
                                ItemModel(id: '06', name: '06'),
                                ItemModel(id: '07', name: '07'),
                                ItemModel(id: '08', name: '08'),
                                ItemModel(id: '09', name: '09'),
                                ItemModel(id: '10', name: '10'),
                                ItemModel(id: '11', name: '11'),
                                ItemModel(id: '12', name: '12'),
                                ItemModel(id: '13', name: '13'),
                                ItemModel(id: '14', name: '14'),
                                ItemModel(id: '15', name: '15'),
                                ItemModel(id: '16', name: '16'),
                                ItemModel(id: '17', name: '17'),
                                ItemModel(id: '18', name: '18'),
                                ItemModel(id: '19', name: '19'),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Stack(
                              children: [
                                ReuseduceTextFormField(
                                  controller: controllerTime,
                                  hintText: 'Check In - Check Out',
                                  funcValidation: ValidateData.validEmpty,
                                  prefixIcon: const Icon(
                                    Icons.calendar_today,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    final List<DateTime> picked =
                                        await DateRagePicker.showDatePicker(
                                      context: context,
                                      initialFirstDate: DateTime.now(),
                                      initialLastDate: (DateTime.now()).add(
                                        const Duration(days: 7),
                                      ),
                                      firstDate: DateTime(2015),
                                      lastDate: DateTime(2025),
                                    );
                                    if (picked.length == 2) {
                                      startDay =
                                          picked[0].toIso8601String() as int;
                                      endDay =
                                          picked[1].toIso8601String() as int;
                                      controllerTime.text =
                                          '${picked[0].day}/${picked[0].month}-${picked[1].day}/${picked[1].month}/${picked[0].year}';
                                    }
                                  },
                                  child: Container(
                                    color: Colors.transparent,
                                    width: double.infinity,
                                    height: 55,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 15),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: ReuseduceButton(
                                title: 'Search Home Stay',
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    OrderUtils()
                                        .setOrder(startDay, endDay, numberRoom);
                                    homeBloc.searchRoom(
                                      numberRoom: numberRoom,
                                      startDay: startDay,
                                      endDay: endDay,
                                      city: controllerCity.text,
                                      child: child,
                                      adults: adults,
                                    );
                                  }
                                },
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          StreamBuilder<UIState>(
            stream: homeBloc.searchStateStream,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data == UIState.LOADING) {
                return const LoadingBar();
              } else {
                return const Center();
              }
            },
          ),
        ],
      ),
    );
  }
}
