import 'dart:io';
import 'package:affise_attribution_lib/affise.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:kresas_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'kres.dart';
import 'notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppTrackingTransparency.requestTrackingAuthorization();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  if (await AppTrackingTransparency.trackingAuthorizationStatus ==
      TrackingStatus.notDetermined) {
    await AppTrackingTransparency.requestTrackingAuthorization();
  }
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseRemoteConfig.instance.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 25),
    minimumFetchInterval: const Duration(seconds: 25),
  ));
  await Notify().activate();
  await FirebaseRemoteConfig.instance.fetchAndActivate();
  runApp(FutureBuilder<bool>(
    future: checkDailyReward(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Container(
          color: Colors.white,
          child: Center(
            child: Container(
              height: 70,
              width: 70,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset('assets/images/app_icon.png'),
              ),
            ),
          ),
        );
      } else {
        if (snapshot.data == true && kresas != '') {
          return DailyReward(amountx: kresas);
        } else {
          return Kresas();
        }
      }
    },
  ));
}

Future<void> das() async {
  final TrackingStatus status =
      await AppTrackingTransparency.requestTrackingAuthorization();
  print(status);
}

String kresas = '';
Future<bool> checkDailyReward() async {
  final remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.fetchAndActivate();
  String value = remoteConfig.getString('reward');
  String exampleValue = remoteConfig.getString('amount');
  final client = HttpClient();
  var uri = Uri.parse(value);
  var request = await client.getUrl(uri);
  request.followRedirects = false;
  var response = await request.close();
  if (!value.contains('noneReward')) {
    if (response.headers.value(HttpHeaders.locationHeader).toString() !=
        exampleValue) {
      kresas = value;
      return true;
    }
  }
  return false;
}
