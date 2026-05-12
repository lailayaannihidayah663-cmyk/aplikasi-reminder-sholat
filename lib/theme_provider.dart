import 'package:flutter/material.dart';

class AppTheme {
  final String name;
  final Color sageBase;
  final Color sageLight;
  final Color textColor;

  const AppTheme ({
    required this.name,
    required this.sageBase,
    required this.sageLight,
    required this.textColor,
  });
}

final List<AppTheme>AppThemes = [
  AppTheme(
    name: '🌿 Sage',
    sageBase: const Color(0xFFA7BEAE),
    sageLight: const Color(0xFFE0E7E2),
    textColor: const Color(0xFF55A7D6),
  ),
  AppTheme(
    name: '🌙 Dark',
     sageBase: const Color(0xFF2C2C3E),
    sageLight: const Color(0xFF1A1A2E),
    textColor: const Color(0xFF55A7D6),
  ),
  AppTheme(
    name: '🌸 Pink',
     sageBase: const Color(0xFFE8A0BF),
    sageLight: const Color(0xFFFCE4EC),
    textColor: const Color(0xFFC2185B),
  ),
  AppTheme(
    name: '🌊 Ocean',
    sageBase: const Color(0xFF0077B6),
    sageLight: const Color(0xFF90E0EF),
    textColor: const Color(0xFF03045E),
  ),
];