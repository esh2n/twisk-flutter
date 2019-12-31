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

// Print off the response
  print(res.statusCode);
  print(res.body);
}

String sample() {
  print("sasa");
  return 'sasa';
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

// // Print off the response
// print(res.statusCode);
// print(res.body);
// }
