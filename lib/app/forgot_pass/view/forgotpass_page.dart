import 'package:flutter/material.dart';

import '../../fire_auth/fire_auth.dart';
import '/ui/ui.dart';
import '/utils/utils.dart';
import '/components/components.dart';

class ForgotPassPage extends StatefulWidget {
  const ForgotPassPage({super.key});

  @override
  State<ForgotPassPage> createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController controllerEmail;

  @override
  void initState() {
    super.initState();
    controllerEmail = TextEditingController();
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 35, 20, 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Forgot Password',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 35,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(height: 100),
              const Text(
                'Your Email',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 10),
              Form(
                key: _formKey,
                child: ReuseduceTextFormField(
                  hintText: 'Enter your email (ex@gmail.com)',
                  controller: controllerEmail,
                  keyboardType: TextInputType.emailAddress,
                  funcValidation: ValidateData.validEmail,
                  prefixIcon: const Icon(
                    Icons.mail,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 60),
              ReuseduceButton(
                  title: 'Send',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      FireAuth().forgotPassWordByEmail(
                          controllerEmail.text, () {}, (val) {});
                    }
                  }),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
