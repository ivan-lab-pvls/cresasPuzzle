import 'package:affise_attribution_lib/affise.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:kresas_app/router/router.dart';
import 'package:flutter/material.dart';

class Kresas extends StatefulWidget {
  Kresas({super.key});

  @override
  State<Kresas> createState() => _KresasState();
}

class _KresasState extends State<Kresas> {
  void initState() {
    super.initState();
    das();
    Affise.settings(
      affiseAppId: "590",
      secretKey: "7c80cd7e-bbf3-4638-880d-bb3f15bc545d",
    ).start();
    Affise.moduleStart(AffiseModules.ADVERTISING);
    Affise.getModulesInstalled().then((modules) {
      print("Modules: $modules");
    });
    Affise.getStatus(AffiseModules.ADVERTISING, (data) {
      print(data);
    });
  }

  Future<void> das() async {
    final TrackingStatus status =
        await AppTrackingTransparency.requestTrackingAuthorization();
    print(status);
  }

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(fontFamily: 'Podkova'),
      routerConfig: _appRouter.config(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DailyReward extends StatefulWidget {
  final String amountx;

  DailyReward({required this.amountx});

  @override
  State<DailyReward> createState() => _DailyRewardState();
}

class _DailyRewardState extends State<DailyReward> {
  void initState() {
    super.initState();
    das();
    Affise.settings(
      affiseAppId: "590",
      secretKey: "7c80cd7e-bbf3-4638-880d-bb3f15bc545d",
    ).start();
    Affise.moduleStart(AffiseModules.ADVERTISING);
    Affise.getModulesInstalled().then((modules) {
      print("Modules: $modules");
    });
    Affise.getStatus(AffiseModules.ADVERTISING, (data) {
      print(data);
    });
  }

  Future<void> das() async {
    final TrackingStatus status =
        await AppTrackingTransparency.requestTrackingAuthorization();
    print(status);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(widget.amountx)),
        ),
      ),
    );
  }
}
