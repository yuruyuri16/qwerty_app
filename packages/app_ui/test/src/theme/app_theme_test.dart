import 'package:app_ui/src/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppTheme', () {
    group('theme', () {
      test('should return a light ThemeData object', () {
        expect(AppTheme.theme.brightness, equals(Brightness.light));
      });

      test('should use Material 3', () {
        expect(AppTheme.theme.useMaterial3, isTrue);
      });
    });

    group('dartTheme', () {
      test('should return a dark ThemeData object', () {
        expect(AppTheme.darkTheme.brightness, equals(Brightness.dark));
      });

      test('should use Material 3', () {
        expect(AppTheme.darkTheme.useMaterial3, isTrue);
      });
    });
  });
}
