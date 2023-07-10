import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

/// App UI Theme.
abstract class AppTheme {
  /// Light theme.
  static ThemeData get theme {
    return FlexThemeData.light(
      useMaterial3: true,
    );
  }

  /// Dark theme.
  static ThemeData get darkTheme {
    return FlexThemeData.dark(
      useMaterial3: true,
    );
  }
}
