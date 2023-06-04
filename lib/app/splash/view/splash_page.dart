import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/utils/utils.dart';
import '../../home/home.dart';
import '../../login/login.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    final navigatorloginpage = Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) {
        return const LoginPage();
      }),
    );
    final navigatorhomepage = Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) {
      return const HomePage();
    }));

    prefs = await SharedPreferences.getInstance();
    if (prefs.getString("uid") == null || prefs.getString("uid") == "") {
      navigatorloginpage;
    } else {
      navigatorhomepage;
      AccountUtils().setAccount(uid1: prefs.getString("uid").toString());
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: 200,
          height: 200,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fitWidth,
              image: AssetImage('assets/images/logo.png'),
            ),
          ),
        ),
      ),
    );
  }
}
