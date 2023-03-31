import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../signup.dart';
import '/ui/color.dart';
import '/auth/repository/authentication.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const SignupPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Center(
                child: Text(
                  'Booking Hotels',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                  ),
                ),
              ),
              const SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: BlocProvider(
                  create: (context) {
                    return SignupBloc(
                      authenticationRepository:
                          RepositoryProvider.of<AuthenticationRepository>(
                              context),
                    );
                  },
                  child: const SignupForm(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
