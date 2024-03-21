
import 'package:auto_route/auto_route.dart';
import 'package:kresas_app/screens/collection/collection_screen.dart';
import 'package:kresas_app/screens/home/home_screen.dart';
import 'package:kresas_app/screens/onboarding/onboarding_screen.dart';
import 'package:kresas_app/screens/puzzle/puzzle_screen.dart';
import 'package:kresas_app/models/puzzle_model.dart';

import 'package:flutter/material.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: OnboardingRoute.page, initial: true),
    AutoRoute(page: HomeRoute.page),
    AutoRoute(page: CollectionRoute.page),
    AutoRoute(page: PuzzleRoute.page),
  ];
}