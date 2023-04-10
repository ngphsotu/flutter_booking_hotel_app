// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:formz/formz.dart';

// import '../../signup/signup.dart';
// import '/auth/auth.dart';
// import '/components/components.dart';
// import '/login/login.dart';

// class HomeForm extends StatelessWidget {
//   const HomeForm({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<HomeBloc, HomeState>(
//       listener: (context, state) {
//         if (state.status.isSubmissionFailure) {
//           ScaffoldMessenger.of(context)
//             ..hideCurrentSnackBar()
//             ..showSnackBar(
//               const SnackBar(content: Text('Authentication Failure')),
//             );
//         }
//       },
//       child: Align(
//         alignment: const Alignment(0, -1 / 3),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _HomeNameInput(),
//             const SizedBox(height: 20),
//             _HomePhoneInput(),
//             const SizedBox(height: 20),
//             _SignupUsernameInput(),
//             const SizedBox(height: 20),
//             _SignupPasswordInput(),
//             const SizedBox(height: 30),
//             Center(child: _SignupButton()),
//             const SizedBox(height: 5),
//             Divider(thickness: 1, color: Colors.grey[500]),
//             TextAndButton(
//               onpressed: () {
//                 Navigator.of(context).push(_createRoute());
//               },
//               textbutton: 'Login',
//               textalready: 'Don\'t have any account ?',
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// Route _createRoute() {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) => const LoginPage(),
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       const begin = Offset(0.0, 1.0);
//       const end = Offset.zero;
//       const curve = Curves.ease;

//       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

//       return SlideTransition(
//         position: animation.drive(tween),
//         child: child,
//       );
//     },
//   );
// }

// class _SignupNameInput extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<SignupBloc, SignupState>(
//       buildWhen: (previous, current) => previous.name != current.name,
//       builder: (context, state) {
//         return ReuseduceTextFormField(
//           key: const Key('signupForm_nameInput_textFormField'),
//           hintText: 'Enter your name',
//           labelText: 'Name',
//           errorText: state.name.invalid ? 'invalid username' : null,
//           prefixIcon: const Icon(Icons.person),
//           // onChanged: (username) =>
//           //     context.read<LoginBloc>().add(LoginUsernameChanged(username)),
//         );
//       },
//     );
//   }
// }

// class _SignupPhoneInput extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<SignupBloc, SignupState>(
//       buildWhen: (previous, current) => previous.phone != current.phone,
//       builder: (context, state) {
//         return ReuseduceTextFormField(
//           key: const Key('signupForm_phoneInput_textFormField'),
//           hintText: 'Enter your phone',
//           labelText: 'Phone',
//           errorText: state.phone.invalid ? 'invalid username' : null,
//           // keyboardType: TextInputType.number,
//           prefixIcon: const Icon(Icons.phone),
//           // onChanged: (username) =>
//           //     context.read<LoginBloc>().add(LoginUsernameChanged(username)),
//         );
//       },
//     );
//     // inputFormatters: <TextInputFormatter>[
//     //   FilteringTextInputFormatter.digitsOnly,
//     // ],
//   }
// }

// class _SignupUsernameInput extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<SignupBloc, SignupState>(
//       buildWhen: (previous, current) => previous.username != current.username,
//       builder: (context, state) {
//         return ReuseduceTextFormField(
//           key: const Key('signupForm_usernameInput_textFormField'),
//           hintText: 'Enter your email',
//           labelText: 'Email',
//           errorText: state.username.invalid ? 'invalid username' : null,
//           prefixIcon: const Icon(Icons.mail),
//           onChanged: (username) =>
//               context.read<SignupBloc>().add(SignupUsernameChanged(username)),
//         );
//       },
//     );
//   }
// }

// class _SignupPasswordInput extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<SignupBloc, SignupState>(
//       buildWhen: (previous, current) => previous.password != current.password,
//       builder: (context, state) {
//         return ReuseduceTextFormField(
//           key: const Key('signupForm_passwordInput_textFormField'),
//           hintText: 'Enter your password',
//           labelText: 'Password',
//           errorText: state.password.invalid ? 'invalid password' : null,
//           prefixIcon: const Icon(Icons.security),
//           obscureText: true,
//           onChanged: (password) =>
//               context.read<SignupBloc>().add(SignupPasswordChanged(password)),
//         );
//       },
//     );
//   }
// }

// class _SignupButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<SignupBloc, SignupState>(
//       buildWhen: (previous, current) => previous.status != current.status,
//       builder: (context, state) {
//         return state.status.isSubmissionInProgress
//             ? const CircularProgressIndicator()
//             : ElevatedButton(
//                 key: const Key('loginForm_continue_raisedButton'),
//                 onPressed: state.status.isValidated
//                     ? () {
//                         context.read<LoginBloc>().add(const LoginSubmitted());
//                       }
//                     : null,
//                 child: const Text('Sign Up'),
//               );
//       },
//     );
//   }
// }
