import 'package:flutter/material.dart';

import '/ui/ui.dart';
import '/utils/utils.dart';
import '../../home/home.dart';
import '../bloc/signup_bloc.dart';
import '/components/components.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late final RegisterBloc registerBloc;
  late final TextEditingController controllerName;
  late final TextEditingController controllerPhone;
  late final TextEditingController controllerEmail;
  late final TextEditingController controllerPass;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    registerBloc = RegisterBloc();
    controllerPass = TextEditingController();
    controllerEmail = TextEditingController();
    controllerPhone = TextEditingController();
    controllerName = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    registerBloc.dispose();
  }

  @override
  void didChangeDependencies() {
    registerBloc.registerStream.listen((value) {
      if (value == UIState.SUCCESS) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) {
            return const HomePage();
          }),
        );
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.keyboard_backspace,
            color: AppColors.primaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        'Register Account',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 35,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Your Name',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ReuseduceTextFormField(
                      hintText: 'Enter your full name',
                      controller: controllerName,
                      funcValidation: ValidateData.validEmpty,
                      prefixIcon: const Icon(
                        Icons.person,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Your Email',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ReuseduceTextFormField(
                      controller: controllerEmail,
                      hintText: 'Enter your email (ex@gmail.com)',
                      keyboardType: TextInputType.emailAddress,
                      funcValidation: ValidateData.validEmail,
                      prefixIcon: const Icon(
                        Icons.mail,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Your Phone',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ReuseduceTextFormField(
                      controller: controllerPhone,
                      hintText: 'Enter your phone number',
                      funcValidation: ValidateData.validEmpty,
                      keyboardType: TextInputType.phone,
                      prefixIcon: const Icon(
                        Icons.phone,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Your Password',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ReuseduceTextFormField(
                      controller: controllerPass,
                      hintText: 'Enter your password',
                      funcValidation: ValidateData.validEmpty,
                      obscureText: true,
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 40),
                    ReuseduceButton(
                      title: 'Register',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          registerBloc.register(
                            email: controllerEmail.text,
                            pass: controllerPass.text,
                            name: controllerName.text,
                            phone: controllerPhone.text,
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
          StreamBuilder<UIState>(
            stream: registerBloc.registerStream,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data == UIState.LOADING) {
                return const LoadingBar();
              } else {
                return const Center();
              }
            },
          )
        ],
      ),
    );
  }
}
