import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:kresas_app/router/router.dart';
import 'package:flutter/material.dart';

class Kresas extends StatelessWidget {
  Kresas({super.key});

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

class DailyReward extends StatelessWidget {
  final String amountx;

  DailyReward({required this.amountx});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(amountx)),
        ),
      ),
    );
  }
}
