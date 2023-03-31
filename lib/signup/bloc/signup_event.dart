part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class SignupNameChanged extends SignupEvent {
  const SignupNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class SignupPhoneChanged extends SignupEvent {
  const SignupPhoneChanged(this.phone);

  final String phone;

  @override
  List<Object> get props => [phone];
}

class SignupUsernameChanged extends SignupEvent {
  const SignupUsernameChanged(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

class SignupPasswordChanged extends SignupEvent {
  const SignupPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class SignupSubmitted extends SignupEvent {
  const SignupSubmitted();
}
