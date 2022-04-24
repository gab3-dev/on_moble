class User {
  String _name;
  String _email;
  String _password;
  String _phone;

  User(this._name, this._email, this._password, this._phone);

  set name(String value) {
    _name = value;
  }

  set email(String value) {
    _email = value;
  }

  set password(String value) {
    _password = value;
  }

  set phone(String value) {
    _phone = value;
  }
}
