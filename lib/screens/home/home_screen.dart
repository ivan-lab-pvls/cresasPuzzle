import 'package:auto_route/auto_route.dart';
import 'package:kresas_app/models/puzzle_model.dart';
import 'package:kresas_app/repository/puzzle_repository.dart';
import 'package:kresas_app/router/router.dart';
import 'package:kresas_app/theme/colors.dart';
import 'package:kresas_app/widgets/action_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bgGreen,
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 260,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Cresus art',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 48,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            'Adventure is waiting for your collections',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 20),
                          ActionButtonWidget(
                              text: 'My Collection',
                              width: 250,
                              onTap: () {
                                context.router.push(CollectionRoute());
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 450,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Image.asset('assets/images/home/card.png'),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 50),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Collect victories',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 48,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Container(
                                width: 300,
                                child: Text(
                                  'Find all Trophies to help cress recreate his favorite museum',
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              ActionButtonWidget(
                                  text: puzzleRepository[0].isCollect
                                      ? 'Continue'
                                      : 'Start 1st',
                                  width: 200,
                                  onTap: () {
                                    if (puzzleRepository.every((element) => element.isCollect)) {
                                      context.router.push(PuzzleRoute(puzzle: puzzleRepository[0]));
                                    } else {
                                      final PuzzleModel puzzle =
                                      puzzleRepository.firstWhere((element) =>
                                      element.isCollect == false);
                                      context.router.push(PuzzleRoute(puzzle: puzzle));
                                    }
                                  }),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Transform.flip(
                            flipX: true,
                            child: Image.asset(
                              'assets/images/elements/cresus.png',
                              width: 250,
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
