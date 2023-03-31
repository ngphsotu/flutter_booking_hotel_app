part of 'signup_bloc.dart';

class SignupState extends Equatable {
  final Name name;
  final Phone phone;
  final Username username;
  final Password password;
  final FormzStatus status;

  const SignupState({
    this.status = FormzStatus.pure,
    this.name = const Name.pure(),
    this.phone = const Phone.pure(),
    this.username = const Username.pure(),
    this.password = const Password.pure(),
  });

  SignupState copyWith({
    FormzStatus? status,
    Name? name,
    Phone? phone,
    Username? username,
    Password? password,
  }) {
    return SignupState(
      status: status ?? this.status,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [status, name, phone, username, password];
}
