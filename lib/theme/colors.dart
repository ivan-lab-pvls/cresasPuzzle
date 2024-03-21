import 'package:flutter/material.dart';

abstract class AppColors {
  static const black = Color(0xFF000000);
  static const white = Color(0xFFFFFFFF);

  static final white40 = Color(0x66FFFFFF);

  static const orange = Color(0xFFFA8C37);

  static final green = Color(0xFF13695C);
  static final blackGreen = Color(0xFF003B32);
  static final bgGreen = Color(0xFF001C18);

  static const gradientBackground = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF0C6658),
      Color(0xFF001C18),
    ],
  );
}