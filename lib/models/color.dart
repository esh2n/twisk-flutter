class ColorSetting {
  int _id;
  int _colorMode;
  String _date;

  ColorSetting(this._colorMode, this._date);
  ColorSetting.withId(this._id, this._colorMode, this._date);

  int get id => _id;
  int get colorMode => _colorMode;
  String get date => _date;

  set colorMode(int value) {
    this._colorMode = value;
  }

  set date(String value) {
    this._date = value;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['color'] = _colorMode;
    map['date'] = _date;

    return map;
  }

  ColorSetting.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._colorMode = map['color'];
    this._date = map['date'];
  }
}
