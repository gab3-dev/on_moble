import 'dart:core';

class Contact {
  Contact({
    var name,
    var urlImage,
    var email,
  }) {
    this._name = name;
    this._urlImage = urlImage;
    this._email = email;
  }

  var _email;
  var _name;
  var _urlImage;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "name": this.name,
      "urlImage": this.urlImage,
      "email": this.email,
    };
    return map;
  }

  String get name => _name;

  String get urlImage => _urlImage;

  String get email => _email;

  set name(String value) {
    _name = value;
  }

  set urlImage(String value) {
    _urlImage = value;
  }

  set email(String value) {
    _email = value;
  }
}
