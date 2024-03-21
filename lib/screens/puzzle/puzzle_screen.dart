import 'package:auto_route/auto_route.dart';
import 'package:kresas_app/models/puzzle_model.dart';
import 'package:kresas_app/models/puzzle_pieces_model.dart';
import 'package:kresas_app/repository/puzzle_repository.dart';
import 'package:kresas_app/router/router.dart';
import 'package:kresas_app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class PuzzleScreen extends StatefulWidget {
  final PuzzleModel puzzle;

  const PuzzleScreen({super.key, required this.puzzle});

  @override
  State<PuzzleScreen> createState() => _PuzzleScreenState();
}

class _PuzzleScreenState extends State<PuzzleScreen> {
  List<PuzzlePieceModel> pieces = [];
  List<PuzzlePieceModel?> grid = List.filled(9, null);
  List<PuzzlePieceModel> savedPuzzlePieces = [];

  @override
  void initState() {
    getPieces();
    super.initState();
  }

  void getPieces() {
    pieces = widget.puzzle.puzzlePieces;
    pieces.shuffle();
  }

  bool isPuzzleComplete() {
    for (int i = 0; i < grid.length; i++) {
      if (grid[i] == null || grid[i]!.index != i) {
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgGreen,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            context.router.push(HomeRoute());
                          },
                          child: Icon(Icons.arrow_back_ios_new,
                              color: AppColors.white)),
                      Text(
                        'Picture №${widget.puzzle.id + 1}',
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
            GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              shrinkWrap: true,
              itemCount: 9,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (context, index) {
                return DragTarget<PuzzlePieceModel>(
                  builder: (context, candidateData, rejectedData) {
                    return GestureDetector(
                      onTap: () {
                        if (grid[index] != null) {
                          setState(() {
                            pieces.add(grid[index]!);
                            grid[index] = null;
                          });
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.blackGreen,
                            border:
                                Border.all(color: AppColors.green, width: 1)),
                        child: grid[index] != null
                            ? Image.asset(
                                grid[index]!.pieces,
                                fit: BoxFit.contain,
                              )
                            : null,
                      ),
                    );
                  },
                  onWillAccept: (data) => true,
                  onAccept: (data) {
                    setState(() {
                      if (grid[index] != null) {
                        pieces.add(grid[index]!);
                      }
                      pieces.remove(data);
                      savedPuzzlePieces.add(data);
                      grid[index] = data;
                      if (isPuzzleComplete()) {
                        _showVictoryDialog();
                      }
                    });
                  },
                );
              },
            ),
            SizedBox(height: 20),
            Container(
              color: AppColors.blackGreen,
              height: 150,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: pieces.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(width: 15),
                itemBuilder: (context, index) {
                  return Draggable<PuzzlePieceModel>(
                    data: pieces[index],
                    child: Container(
                      child: Center(
                        child: Image.asset(
                          pieces[index].pieces,
                        ),
                      ),
                    ),
                    feedback: Container(
                      child: Center(
                        child: Image.asset(
                          pieces[index].pieces,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }

  void _showVictoryDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0)),
            child: Container(
              width: 350,
              height: 425,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset('assets/images/victory/bg-deck.svg'),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'VICTORY',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 44,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Container(
                        width: 155,
                        height: 155,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SvgPicture.asset(
                                'assets/images/victory/ellipse.svg'),
                            Image.asset(widget.puzzle.statueImage),
                          ],
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            widget.puzzle.isCollect = true;

                            widget.puzzle.puzzlePieces =
                                savedPuzzlePieces.toSet().toList();
                            context.router.push(HomeRoute());
                          },
                          child: SvgPicture.asset(
                              'assets/images/victory/menu-button.svg')),
                      GestureDetector(
                          onTap: () {
                            widget.puzzle.isCollect = true;
                            widget.puzzle.puzzlePieces =
                                savedPuzzlePieces.toSet().toList();
                            if (widget.puzzle.id != 19) {
                              context.router.push(PuzzleRoute(
                                  puzzle:
                                      puzzleRepository[widget.puzzle.id + 1]));
                            } else {
                              context.router.push(
                                  PuzzleRoute(puzzle: puzzleRepository[0]));
                            }
                          },
                          child: SvgPicture.asset(
                              'assets/images/victory/next-button.svg')),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
