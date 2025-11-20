import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:color_name_picker/color_name_picker.dart';

void main() {
  group('ColorNamePicker', () {
    test('colorToResult converts Color to ColorResult', () {
      final result = ColorNamePicker.colorToResult(const Color(0xFFFF0000));

      expect(result.hexCode, '#FFFF0000'); // Updated expectation
      expect(result.colorName, isNotEmpty);
      expect(result.argbValue, 0xFFFF0000);
    });

    test('hexToResult converts hex string to ColorResult', () {
      final result = ColorNamePicker.hexToResult('#FF0000');

      expect(result.hexCode, '#FFFF0000'); // Updated expectation
      expect(result.colorName, isNotEmpty);
      expect(result.argbValue, 0xFFFF0000);
    });

    test('hexToResult handles invalid hex', () {
      final result = ColorNamePicker.hexToResult('invalid');

      expect(result.hexCode, '#FF000000'); // Updated expectation
      expect(result.colorName, 'Invalid Color');
    });

    test('ColorResult equality', () {
      final result1 = ColorResult(
        hexCode: '#FFFF0000',
        colorName: 'Red',
        argbValue: 0xFFFF0000,
      );

      final result2 = ColorResult(
        hexCode: '#FFFF0000',
        colorName: 'Red',
        argbValue: 0xFFFF0000,
      );

      expect(result1, result2);
      expect(result1.hashCode, result2.hashCode);
    });

    test('ColorResult toJson', () {
      final result = ColorResult(
        hexCode: '#FFFF0000',
        colorName: 'Red',
        argbValue: 0xFFFF0000,
      );

      final json = result.toJson();

      expect(json['hexCode'], '#FFFF0000');
      expect(json['colorName'], 'Red');
      expect(json['argbValue'], 0xFFFF0000);
    });
  });
}