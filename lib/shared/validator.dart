class Validator {
  static empty(String value) {
    if (value.isEmpty) return '必須項目です';

    return null;
  }

  static email(String value) {
    if (value.isEmpty) return '必須項目です';

    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);

    if (emailValid) return null;

    return '不正な値です';
  }
}
