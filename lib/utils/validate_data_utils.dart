class ValidateData {
  static String? validEmail(String text) {
    final RegExp regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)| (\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

    if (text.isEmpty) {
      return 'Email field cannot be left blank';
    } else if (!regex.hasMatch(text)) {
      return 'Email invalidate (example: ex@gmail.com)';
    } else {
      return null;
    }
  }

  static String? validPassword(String text) {
    text.length < 8 && text.isNotEmpty
        ? 'Password must have length > 8 characters'
        : null;
    return null;
  }

  static String? validEmpty(String text) {
    text.isEmpty ? 'The field cannot be left blank' : null;
    return null;
  }
}
