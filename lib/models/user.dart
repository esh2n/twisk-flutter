import 'package:twisk/apikey.dart';
import 'package:twisk/util/twitter_api.dart';

void getTwitterRequest(String screenName) async {
  final _twitterOauth = new twitterApi(
    consumerKey: consumerKey,
    consumerSecret: consumerSecret,
    token: token,
    tokenSecret: tokenSecret,
  );
  Future twitterRequest = _twitterOauth.getTwitterRequest(
    "GET",
    "users/lookup.json",
    options: {
      "screen_name": screenName,
    },
  );
  var res = await twitterRequest;
  print(res.body);
}

void postTwitterRequest(
    String oauthToken, String oauthTokenSecret, String sentence) async {
  final _twitterOauth = new twitterApi(
    consumerKey: consumerKey,
    consumerSecret: consumerSecret,
    token: oauthToken,
    tokenSecret: oauthTokenSecret,
  );
  Future twitterRequest = _twitterOauth.getTwitterRequest(
    "POST",
    "statuses/update.json",
    options: {
      "status": "New Task Posted! ✅${sentence}  #Twisk",
      // "status": "だ",
      "status": "New Task Posted!\n✅${sentence}\n\n#Twisk\n#今日の積み上げ",
    },
  );
  var res = await twitterRequest;
  print(res.body);
}

class User {
  int _id;
  String _displayName;
  String _screenName;
  String _photoURL;
  String _date;
  String _userId;
  String _oauthToken;
  String _oauthTokenSecret;

  User(this._displayName, this._screenName, this._photoURL, this._userId,
      this._date, this._oauthToken, this._oauthTokenSecret);
  User.withId(this._id, this._displayName, this._screenName, this._photoURL,
      this._userId, this._date, this._oauthToken, this._oauthTokenSecret);

  int get id => _id;
  String get displayName => _displayName;
  String get screenName => _screenName;
  String get photoURL => _photoURL;
  String get userId => _userId;
  String get date => _date;
  String get oauthToken => _oauthToken;
  String get oauthTokenSecret => _oauthTokenSecret;

  set displayName(String value) {
    this._displayName = value;
  }

  set screenName(String value) {
    this._screenName = value;
  }

  set photoURL(String value) {
    this._photoURL = value;
  }

  set userId(String value) {
    this._date = value;
  }

  set date(String value) {
    this._photoURL = value;
  }

  set oauthToken(String value) {
    this._oauthToken = value;
  }

  set oauthTokenSecret(String value) {
    this._oauthTokenSecret = value;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['display_name'] = _displayName;
    map['screen_name'] = _screenName;
    map['photo_url'] = _photoURL;
    map['user_id'] = _userId;
    map['date'] = _date;
    map['oauth_token'] = _oauthToken;
    map['oauth_token_secret'] = _oauthTokenSecret;

    return map;
  }

  User.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._displayName = map['display_name'];
    this._screenName = map['screen_name'];
    this._photoURL = map['photo_url'];
    this._userId = map['user_id'];
    this._date = map['date'];
    this._oauthToken = map['oauth_token'];
    this._oauthTokenSecret = map['oauth_token_secret'];
  }
}
