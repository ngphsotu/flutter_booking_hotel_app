// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '/ui/ui.dart';
import '../profile.dart';
import '/model/model.dart';
import '../../admin/admin.dart';
import '/components/components.dart';
import '../../my_hotel/my_hotel.dart';
import '../../history_book/history_book.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isDark = false;
  late final Account account;
  late final ThemeData themeData;
  late final ProfileBloc profileBloc;

  @override
  void initState() {
    profileBloc = ProfileBloc()..init();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    profileBloc.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    themeData = Provider.of<ThemeChanger>(context).getTheme();
    if (themeData ==
        ThemeData.dark().copyWith(
          primaryColor: AppColors.primaryColor,
          scaffoldBackgroundColor: Colors.black,
          textSelectionTheme:
              const TextSelectionThemeData(selectionColor: Colors.white),
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: AppColors.primaryColor),
        )) {
      isDark = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
          ),
          Positioned(
            top: -MediaQuery.of(context).size.width * 1.3,
            left: -MediaQuery.of(context).size.width / 2,
            child: Container(
              width: MediaQuery.of(context).size.width * 2,
              height: MediaQuery.of(context).size.width * 2,
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Center(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Column(
                    children: [
                      const SizedBox(height: 100, width: double.infinity),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: themeData.scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                offset: const Offset(0, 3),
                                blurRadius: 7,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                const SizedBox(height: 90),
                                StreamBuilder<Account>(
                                  stream: profileBloc.accountStream,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      account = snapshot.data!;
                                      return Text(
                                        snapshot.data!.name.toUpperCase(),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w900,
                                          letterSpacing: 1.5,
                                        ),
                                      );
                                    } else {
                                      return Text(
                                        '...'.toUpperCase(),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w900,
                                          letterSpacing: 1.5,
                                        ),
                                      );
                                    }
                                  },
                                ),
                                const SizedBox(height: 10),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/svg/dark.svg',
                                                    width: 20,
                                                    color: themeData
                                                        .textSelectionTheme
                                                        .selectionColor,
                                                  ),
                                                  const SizedBox(width: 15),
                                                  const Text(
                                                    'Theme (Light / Dark)',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      letterSpacing: 1,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // Switch light theme, dark theme
                                            CupertinoSwitch(
                                              value: isDark,
                                              activeColor:
                                                  AppColors.primaryColor,
                                              onChanged: (e) {
                                                if (e) {
                                                  theme.setTheme(0);
                                                } else {
                                                  theme.setTheme(1);
                                                }
                                                setState(
                                                  () {
                                                    isDark = e;
                                                  },
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                        ItemFunction(
                                          color: themeData.textSelectionTheme
                                              .selectionColor,
                                          urlSVG: 'assets/svg/user.svg',
                                          title: 'Manage Account',
                                          onTap: () {
                                            showAccount();
                                          },
                                        ),
                                        ItemFunction(
                                          color: themeData.textSelectionTheme
                                              .selectionColor,
                                          title: 'Manage Home Stay',
                                          urlSVG: 'assets/svg/house.svg',
                                          onTap: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return const MyHotelPage();
                                            }));
                                          },
                                        ),
                                        ItemFunction(
                                          color: themeData.textSelectionTheme
                                              .selectionColor,
                                          title: 'Manage Transaction',
                                          urlSVG: 'assets/svg/history.svg',
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return const HistoryBookPage();
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                        StreamBuilder<Account>(
                                          stream: profileBloc.accountStream,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return snapshot
                                                          .data!.permission ==
                                                      1
                                                  ? ItemFunction(
                                                      color: themeData
                                                          .textSelectionTheme
                                                          .selectionColor,
                                                      title:
                                                          'Role Administrator',
                                                      urlSVG:
                                                          'assets/svg/admin.svg',
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) {
                                                              return const AdminPage();
                                                            },
                                                          ),
                                                        );
                                                      },
                                                    )
                                                  : const SizedBox();
                                            } else {
                                              return const SizedBox();
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                StreamBuilder<Account>(
                  stream: profileBloc.accountStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ItemAvatar(
                        themeData.scaffoldBackgroundColor,
                        snapshot.data!.avatar,
                        profileBloc,
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                Text(
                  'Profile'.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
          StreamBuilder<UIState>(
            stream: profileBloc.accountStateStream,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data == UIState.LOADING) {
                return const LoadingBar();
              } else {
                return const Center();
              }
            },
          ),
          Positioned(
            left: 5,
            bottom: MediaQuery.of(context).size.height - 100,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: themeData.scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.home,
                      size: 20,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Show account
  void showAccount() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.transparent,
      isScrollControlled: true,
      builder: (BuildContext _) {
        return Center(
          child: AccountPage(
            color: themeData.scaffoldBackgroundColor,
            account: account,
            profileBloc: profileBloc,
          ),
        );
      },
    );
  }
}
