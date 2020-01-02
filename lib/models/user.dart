import 'package:twitter_api/twitter_api.dart';
import 'package:twisk/apikey.dart';

// class User {
final _twitterOauth = new twitterApi(
  consumerKey: consumerKey,
  consumerSecret: consumerSecret,
  token: token,
  tokenSecret: tokenSecret,
);

// Make the request to twitter
void getTwitterRequest() async {
  Future twitterRequest = _twitterOauth.getTwitterRequest(
    // Http Method
    "GET",
    // Endpoint you are trying to reach
    // "statuses/user_timeline.json",
    "users/lookup.json",
    // The options for the request
    options: {
      // "user_id": "19025957",
      // "user_id": "RhSLkhfexlhlgUpDIttkdDM54V23",
      "screen_name": "luansan_1",
      // "count": "20",
      // "trim_user": "true",
      // "tweet_mode": "extended", // Used to prevent truncating tweets
    },
  );
// Wait for the future to finish
  var res = await twitterRequest;
}
// Future twitterRequest = _twitterOauth.getTwitterRequest(
//   // Http Method
//   "GET",
//   // Endpoint you are trying to reach
//   "statuses/user_timeline.json",
//   // The options for the request
//   options: {
//     "user_id": "19025957",
//     "screen_name": "TTCnotices",
//     "count": "20",
//     "trim_user": "true",
//     "tweet_mode": "extended", // Used to prevent truncating tweets
//   },
// );

// // Wait for the future to finish
// var res = await twitterRequest;
// }
class User {
  int _id;
  String _displayName;
  String _screenName;
  String _photoURL;
  String _date;
  String _userId;

  User(this._displayName, this._screenName, this._photoURL, this._userId,
      this._date);
  User.withId(this._id, this._displayName, this._screenName, this._photoURL,
      this._userId, this._date);

  int get id => _id;
  String get displayName => _displayName;
  String get screenName => _screenName;
  String get photoURL => _photoURL;
  String get userId => _userId;
  String get date => _date;

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

    return map;
  }

  User.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._displayName = map['display_name'];
    this._screenName = map['screen_name'];
    this._photoURL = map['photo_url'];
    this._userId = map['user_id'];
    this._date = map['date'];
  }
}
