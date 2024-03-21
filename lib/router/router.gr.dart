// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    CollectionRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CollectionScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeScreen(),
      );
    },
    OnboardingRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const OnboardingScreen(),
      );
    },
    PuzzleRoute.name: (routeData) {
      final args = routeData.argsAs<PuzzleRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: PuzzleScreen(
          key: args.key,
          puzzle: args.puzzle,
        ),
      );
    },
  };
}

/// generated route for
/// [CollectionScreen]
class CollectionRoute extends PageRouteInfo<void> {
  const CollectionRoute({List<PageRouteInfo>? children})
      : super(
          CollectionRoute.name,
          initialChildren: children,
        );

  static const String name = 'CollectionRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [OnboardingScreen]
class OnboardingRoute extends PageRouteInfo<void> {
  const OnboardingRoute({List<PageRouteInfo>? children})
      : super(
          OnboardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PuzzleScreen]
class PuzzleRoute extends PageRouteInfo<PuzzleRouteArgs> {
  PuzzleRoute({
    Key? key,
    required PuzzleModel puzzle,
    List<PageRouteInfo>? children,
  }) : super(
          PuzzleRoute.name,
          args: PuzzleRouteArgs(
            key: key,
            puzzle: puzzle,
          ),
          initialChildren: children,
        );

  static const String name = 'PuzzleRoute';

  static const PageInfo<PuzzleRouteArgs> page = PageInfo<PuzzleRouteArgs>(name);
}

class PuzzleRouteArgs {
  const PuzzleRouteArgs({
    this.key,
    required this.puzzle,
  });

  final Key? key;

  final PuzzleModel puzzle;

  @override
  String toString() {
    return 'PuzzleRouteArgs{key: $key, puzzle: $puzzle}';
  }
}
