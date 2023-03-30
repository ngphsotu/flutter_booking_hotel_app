// ignore_for_file: prefer_const_constructors

import 'package:formz/formz.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_booking_hotel_app/login/login.dart';

void main() {
  const username = Username.dirty('username');
  const password = Password.dirty('password');
  group('LoginState', () {
    test('supports value comparisons', () {
      expect(LoginState(), LoginState());
    });

    test('returns same object when no properties are passed', () {
      expect(LoginState().copyWith(), LoginState());
    });

    test('returns object with updated status when status is passed', () {
      expect(
        LoginState().copyWith(status: FormzStatus.pure),
        LoginState(),
      );
    });

    test('returns object with updated username when username is passed', () {
      expect(
        LoginState().copyWith(username: username),
        LoginState(username: username),
      );
    });

    test('returns object with updated password when password is passed', () {
      expect(
        LoginState().copyWith(password: password),
        LoginState(password: password),
      );
    });
  });
}
