// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_booking_hotel_app/login/login.dart';

void main() {
  const username = 'mock-username';
  const password = 'mock-password';
  group('LoginEvent', () {
    group('LoginUsernameChanged', () {
      test('supports value comparisons', () {
        expect(LoginUsernameChanged(username), LoginUsernameChanged(username));
      });
    });

    group('LoginPasswordChanged', () {
      test('supports value comparisons', () {
        expect(LoginPasswordChanged(password), LoginPasswordChanged(password));
      });
    });

    group('LoginSubmitted', () {
      test('supports value comparisons', () {
        expect(LoginSubmitted(), LoginSubmitted());
      });
    });
  });
}