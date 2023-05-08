class Validator {
  static bool isNullOrEmpty(String? value) {
    return value == null || value.isEmpty;
  }

  static bool validateName(String name) {
    return RegExp(r"^[a-zA-Zа-яА-я]+").hasMatch(name);
  }

  static bool validateEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  static bool validateTeacherCode(String code) {
    return RegExp(r"^[0-9]+").hasMatch(code);
  }

  static bool validateStringNumber(String number) {
    var parsedNumber = int.tryParse(number);
    return parsedNumber != null;
  }
}
