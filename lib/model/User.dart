class User {
  String _name;
  String _email;
  String _password;
  String _phone;

  User(this._name, this._email, this._password, this._phone);
  
  String get name => _name;
  set name(String value) {
    _name = value;
  }

  String get email => _email;
  set email(String value) {
    _email = value;
  }

  String get password => _password;
  set password(String value) {
    _password = value;
  }

  String get phone => _phone;
  set phone(String value) {
    _phone = value;
  }
}
