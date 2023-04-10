import 'package:flutter/material.dart';

import '/ui/ui.dart';
import '../login.dart';
import '/utils/utils.dart';
import '../../home/home.dart';
import '../../signup/signup.dart';
import '/components/components.dart';
import '../../forgot_pass/forgot_pass.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginPage());
  }

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final LoginBloc loginBloc;
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController controllerEmail;
  late final TextEditingController controllerPass;

  @override
  void initState() {
    super.initState();
    // loginBloc = LoginBloc()..init();
    loginBloc = LoginBloc();
    controllerPass = TextEditingController();
    controllerEmail = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loginBloc.loginStream.listen(
      (value) {
        if (value == UIState.SUCCESS) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const HomePage();
              },
            ),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    loginBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 35, 20, 10),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        "Booking Hotels",
                        style: TextStyle(
                          fontSize: 40,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 100),
                    const Text(
                      "Username",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ReuseduceTextFormField(
                      controller: controllerEmail,
                      hintText: "Enter your email (ex@gmail.com)",
                      keyboardType: TextInputType.emailAddress,
                      funcValidation: ValidateData.validEmail,
                      prefixIcon: const Icon(
                        Icons.person,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Password",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ReuseduceTextFormField(
                      hintText: "Enter your password",
                      controller: controllerPass,
                      obscureText: true,
                      funcValidation: ValidateData.validPassword,
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 25),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const ForgotPassPage();
                              },
                            ),
                          );
                        },
                        child: const Text(
                          "Forgot Password ?",
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    ReuseduceButton(
                      title: 'Login'.toUpperCase(),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          loginBloc.login(
                            email: controllerEmail.text,
                            pass: controllerPass.text,
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 15),
                    const Center(
                      child: Text(
                        " or ",
                        style: TextStyle(
                          color: AppColors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    ReuseduceButton(
                      title: 'Sign Up'.toUpperCase(),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const SignUpPage();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          StreamBuilder<UIState>(
            stream: loginBloc.loginStream,
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
