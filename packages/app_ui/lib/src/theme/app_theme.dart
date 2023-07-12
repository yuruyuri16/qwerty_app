import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

/// App UI Theme.
abstract class AppTheme {
  /// Light theme.
  static ThemeData get theme {
    return FlexThemeData.light(
      useMaterial3: true,
      scheme: FlexScheme.shark,
      subThemesData: const FlexSubThemesData(
        inputDecoratorRadius: 8,
        elevatedButtonRadius: 8,
      ),
    ).copyWith();
  }

  /// Dark theme.
  static ThemeData get darkTheme {
    return FlexThemeData.dark(
      useMaterial3: true,
      subThemesData: const FlexSubThemesData(
        inputDecoratorRadius: 8,
      ),
    );
  }
}
