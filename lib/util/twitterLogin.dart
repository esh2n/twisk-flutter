import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:twitter_oauth/twitter_oauth.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:twisk/screens/tasks_screen.dart';
import 'package:twisk/colors.dart';
import 'dart:async';
import 'package:twisk/parts/fab_bottom_app_bar.dart';

import 'package:twisk/apikey.dart';

class TwitterOauthPage extends StatefulWidget {
  const TwitterOauthPage({Key key}) : super(key: key);

  @override
  _TwitterOauthPageState createState() => _TwitterOauthPageState();
}

class _TwitterOauthPageState extends State<TwitterOauthPage> {
  TwitterOauth _twitterOauth;

  @override
  void initState() {
    super.initState();
    _twitterOauth = TwitterOauth(
      consumerKey,
      consumerSecret,
      callBackUrl,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getMainColor(),
      body: Center(
        child: RaisedButton(
          child: const Text('Sign In With Twitter.'),
          onPressed: () async {
            final String authorizeUri = await _twitterOauth.getAuthorizeUri();
            Navigator.of(context).pushReplacement<Widget, Widget>(
              MaterialPageRoute<Widget>(
                builder: (BuildContext context) {
                  return TwitterWebView(
                    uri: authorizeUri,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget getDeleteButton() {
    if (true) {
      return Expanded(
        child: FlatButton(
          child: Text(
            'Logout',
            style: TextStyle(
              color: getAddButtonTextColor(),
            ),
          ),
          color: Colors.redAccent,
          onPressed: () {
            // _delete();
          },
        ),
      );
    } else {
      return Container();
    }
  }

  void getUserProfile() {
    FirebaseUser user;
    print(user);
    // if (user) {}
  }

  Color getAddButtonTextColor() {
    var colorMode = MediaQuery.of(context).platformBrightness;
    if (colorMode == Brightness.dark) {
      return listBackGroundColor;
    } else {
      return Colors.white;
    }
  }

  Color getAddButtonColor() {
    var colorMode = MediaQuery.of(context).platformBrightness;
    if (colorMode == Brightness.dark) {
      return textColorDark;
    } else {
      return addButtonColor;
    }
  }

  Color getMainColor() {
    var colorMode = MediaQuery.of(context).platformBrightness;
    if (colorMode == Brightness.dark) {
      return mainColorDark;
    } else {
      return mainColor;
    }
  }

  Color getTextColor() {
    var colorMode = MediaQuery.of(context).platformBrightness;
    if (colorMode == Brightness.dark) {
      return textColorDark;
    } else {
      return textColor;
    }
  }

  Color getListBackGroundColor() {
    var colorMode = MediaQuery.of(context).platformBrightness;
    if (colorMode == Brightness.dark) {
      return listBackGroundColor;
    } else {
      return Colors.white;
    }
  }

  Color getFocusedBorderColor() {
    var colorMode = MediaQuery.of(context).platformBrightness;
    if (colorMode == Brightness.dark) {
      return Colors.white;
    } else {
      return mainColor;
    }
  }
}

class TwitterWebView extends StatefulWidget {
  const TwitterWebView({Key key, this.uri}) : super(key: key);
  final String uri;
  @override
  _TwitterWebViewState createState() => _TwitterWebViewState();
}

class _TwitterWebViewState extends State<TwitterWebView> {
  TwitterOauth _twitterOauth;

  @override
  void initState() {
    super.initState();
    _twitterOauth = TwitterOauth(
      consumerKey,
      consumerSecret,
      callBackUrl,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: widget.uri,
        javascriptMode: JavascriptMode.unrestricted,
        navigationDelegate: (NavigationRequest request) async {
          print("request.url:${request.url}");
          if (request.url.contains('handler')) {
            final String query = request.url.split('?').last;
            if (query.contains('denied') || query.contains('error')) {
              print("failed");
            } else {
              final Map<String, String> res = Uri.splitQueryString(query);
              twitterSignin(res).then((String uid) {
                Navigator.of(context).pushReplacement<Widget, Widget>(
                  MaterialPageRoute<Widget>(
                    builder: (BuildContext context) {
                      return (TasksScreen());
                    },
                  ),
                );
                // Navigator.pop(context);
              });
            }
          } else {
            print("failed but not denied");
          }
          return NavigationDecision.navigate;
        },
      ),
    );
  }

  Future<String> twitterSignin(Map<String, String> token) async {
    final Map<String, String> oauthToken =
        await _twitterOauth.getAccessToken(token);
    print(oauthToken);
    final AuthCredential credential = TwitterAuthProvider.getCredential(
      authToken: oauthToken['oauth_token'],
      authTokenSecret: oauthToken['oauth_token_secret'],
    );
    final FirebaseUser user =
        (await FirebaseAuth.instance.signInWithCredential(credential)).user;
    return user.uid;
  }
}
