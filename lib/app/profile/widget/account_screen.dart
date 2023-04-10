import 'package:flutter/material.dart';

import '/ui/ui.dart';
import '../profile.dart';
import '/model/model.dart';
import '/utils/utils.dart';
import '/components/components.dart';

class AccountPage extends StatefulWidget {
  final Color color;
  final Account account;
  final ProfileBloc profileBloc;

  const AccountPage({
    super.key,
    required this.color,
    required this.account,
    required this.profileBloc,
  });

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController controllerName;
  late final TextEditingController controllerPhone;
  late final TextEditingController controllerEmail;
  late final TextEditingController controllerPass;

  @override
  void initState() {
    super.initState();
    controllerName = TextEditingController(text: widget.account.name);
    controllerPhone = TextEditingController(text: widget.account.phone);
    controllerEmail = TextEditingController(text: widget.account.email);
    controllerPass = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 550,
      width: MediaQuery.of(context).size.width * 0.95,
      decoration: BoxDecoration(
        color: widget.color,
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
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              height: 50,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Center(
                child: Text(
                  'Account'.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Your Email',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ReuseduceTextFormField(
                        enable: false,
                        controller: controllerEmail,
                        prefixIcon: const Icon(
                          Icons.email,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Your Name',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ReuseduceTextFormField(
                        controller: controllerName,
                        funcValidation: ValidateData.validEmpty,
                        prefixIcon: const Icon(
                          Icons.person,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Your Contact',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ReuseduceTextFormField(
                        funcValidation: ValidateData.validEmpty,
                        controller: controllerPhone,
                        prefixIcon: const Icon(
                          Icons.contact_phone,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Your Password',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ReuseduceTextFormField(
                        controller: controllerPass,
                        obscureText: true,
                        funcValidation: ValidateData.validPassword,
                        prefixIcon: const Icon(
                          Icons.vpn_key,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ReuseduceButton(
                        title: 'Save',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            widget.profileBloc.updateInfoAccount(
                              controllerName.text,
                              controllerPhone.text,
                              controllerPass.text,
                            );
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
