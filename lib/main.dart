import 'dart:async';
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
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseRemoteConfig.instance.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 25),
    minimumFetchInterval: const Duration(seconds: 25),
  ));
  await das();
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
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: DailyReward(amountx: kresas));
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
String uuid = '';
String campaign = '';
void checkData(List<AffiseKeyValue> data) {
  for (AffiseKeyValue keyValue in data) {
    if (keyValue.key == 'campaign_id' || keyValue.key == 'campaign') {
      campaign = keyValue.value;
    }
  }
}

Future<bool> checkDailyReward() async {
  final remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.fetchAndActivate();
  Affise.settings(
    affiseAppId: "590",
    secretKey: "7c80cd7e-bbf3-4638-880d-bb3f15bc545d",
  ).start();
  Affise.moduleStart(AffiseModules.ADVERTISING);

  Affise.getModulesInstalled().then((modules) {
    print("Modules: $modules");
  });
  uuid = await Affise.getRandomDeviceId();
  Affise.getStatus(AffiseModules.ADVERTISING, (data) {
    checkData(data);
  });

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
      kresas = '$value&affise_device_id$uuid&campaignid=$campaign';
      return true;
    }
  }
  return false;
}

void datx() {
  Affise.getStatus(AffiseModules.ADVERTISING, (data) {
    checkData(data);
  });

  Affise.getStatus(AffiseModules.NETWORK, (data) {
    checkData(data);
  });

  Affise.getStatus(AffiseModules.STATUS, (data) {
    checkData(data);
  });
}
