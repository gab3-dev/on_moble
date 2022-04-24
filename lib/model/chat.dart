class Chat {
  String _name;
  String _message;
  String _photo;

  Chat(this._name, this._message, this._photo);

  String get name => _name;
  String get message => _message;
  String get urlphoto => _photo;

  set name(String value) {
    _name = value;
  }

  set message(String value) {
    _message = value;
  }

  set urlphoto(String value) {
    _photo = value;
  }
}
