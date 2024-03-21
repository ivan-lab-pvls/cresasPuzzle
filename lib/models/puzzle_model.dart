
import 'package:kresas_app/models/puzzle_pieces_model.dart';

class PuzzleModel {
  final String statueImage;
  final int id;
  List<PuzzlePieceModel> puzzlePieces;
  bool isCollect;

  PuzzleModel({
    required this.statueImage,
    required this.isCollect,
    required this.id,
    required this.puzzlePieces,
  });
}
