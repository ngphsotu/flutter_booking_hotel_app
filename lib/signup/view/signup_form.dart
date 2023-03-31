import 'package:formz/formz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../signup.dart';
import '/login/login.dart';
import '/components/components.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SignupNameInput(),
            const SizedBox(height: 20),
            _SignupPhoneInput(),
            const SizedBox(height: 20),
            _SignupUsernameInput(),
            const SizedBox(height: 20),
            _SignupPasswordInput(),
            const SizedBox(height: 30),
            Center(child: _SignupButton()),
            const SizedBox(height: 5),
            const Divider(),
            TextAndButton(
              // onpressed: () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => const LoginPage()),
              //   );
              // },
              onpressed: () {
                Navigator.of(context).push(_createRoute());
              },
              textbutton: 'Sign up',
              textalready: 'Don\'t have any account ?',
            ),
          ],
        ),
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const LoginPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

class _SignupNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: const Key('signupForm_nameInput_textField'),
      decoration: InputDecoration(
        labelText: 'Name',
        prefixIcon: const Icon(Icons.person),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}

class _SignupPhoneInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: const Key('signupForm_phoneInput_textField'),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: InputDecoration(
        labelText: 'Phone',
        prefixIcon: const Icon(Icons.phone),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.deepOrange),
        ),
      ),
    );
  }
}

class _SignupUsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextFormField(
          key: const Key('signupForm_usernameInput_textField'),
          onChanged: (username) =>
              context.read<SignupBloc>().add(SignupUsernameChanged(username)),
          decoration: InputDecoration(
            labelText: 'Email',
            errorText: state.username.invalid ? 'invalid username' : null,
            prefixIcon: const Icon(Icons.mail),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.grey),
            ),
          ),
        );
      },
    );
  }
}

class _SignupPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextFormField(
          key: const Key('signupForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<SignupBloc>().add(SignupPasswordChanged(password)),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            errorText: state.password.invalid ? 'invalid password' : null,
            prefixIcon: const Icon(Icons.security),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.grey),
            ),
          ),
        );
      },
    );
  }
}

class _SignupButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('loginForm_continue_raisedButton'),
                onPressed: state.status.isValidated
                    ? () {
                        context.read<LoginBloc>().add(const LoginSubmitted());
                      }
                    : null,
                child: const Text('Sign Up'),
              );
      },
    );
  }
}
