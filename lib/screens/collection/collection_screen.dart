import 'package:auto_route/auto_route.dart';
import 'package:kresas_app/models/puzzle_model.dart';
import 'package:kresas_app/repository/puzzle_repository.dart';
import 'package:kresas_app/theme/colors.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CollectionScreen extends StatefulWidget {
  const CollectionScreen({super.key});

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgGreen,
      body: Container(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.blackGreen,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20.0),
                    bottomLeft: Radius.circular(20.0)),
              ),
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                            context.router.pop();
                          },
                          child: Icon(Icons.arrow_back_ios_new,
                              color: AppColors.white)),
                      Text(
                        'My Collection',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(width: 15),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                itemCount: puzzleRepository.length,
                padding: EdgeInsets.all(16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemBuilder: (BuildContext context, int index) {
                  final PuzzleModel _puzzle = puzzleRepository[index];
                  return Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: AppColors.blackGreen,
                        borderRadius: BorderRadius.all(Radius.circular(16.0))),
                    child: _puzzle.isCollect
                        ? Image.asset(
                            _puzzle.statueImage,
                            width: 70,
                          )
                        : Center(
                          child: Text(
                              'Lost statue',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.white40,
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                        ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
