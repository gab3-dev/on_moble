class contact {
  String _name;
  String _email;
  String _phone;

  contact(this._name, this._email, this._phone);

  String get name => _name;
  String get email => _email;
  String get phone => _phone;

  set name(String value) {
    _name = value;
  }

  set email(String value) {
    _email = value;
  }

  set phone(String value) {
    _phone = value;
  }
}
