library color_name_picker;

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart' hide ColorPicker;
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:colornames/colornames.dart';

import 'models/color_result.dart';
import 'enums/picker_type.dart';

/// A comprehensive color picker package with color name detection
/// Version: 1.2.0
class ColorNamePicker {
  /// Shows a color picker dialog and returns ColorResult with name and hex code
  ///
  /// [context] - BuildContext required for showing dialog
  /// [initialColor] - The initial color to display (default: Colors.blue)
  /// [pickerType] - Type of picker to use (materialPicker or adaptivePicker)
  /// [dialogTitle] - Title of the dialog (default: 'Pick a color')
  /// [enableOpacity] - Whether to enable opacity/alpha channel (default: true)
  /// [showColorCode] - Whether to show hex color code (default: true)
  /// [showColorName] - Whether to show color name (default: true)
  /// [showLabel] - Whether to show labels in the picker (default: true)
  /// [pickerAreaBorderRadius] - Border radius for picker area (default: true)
  /// [pickerAreaHeight] - Height of the picker area (default: 165)
  /// [customColors] - Custom color swatches to display
  /// [showRecentColors] - Whether to show recent colors (adaptive picker only)
  /// [pickerSize] - Custom size for the picker
  /// [pickerPadding] - Padding around the picker
  static Future<ColorResult?> showColorPicker({
    required BuildContext context,
    Color initialColor = Colors.blue,
    PickerType pickerType = PickerType.adaptivePicker,
    String dialogTitle = 'Pick a color',
    bool enableOpacity = true,
    bool showColorCode = true,
    bool showColorName = true,
    bool showLabel = true,
    bool pickerAreaBorderRadius = true,
    double pickerAreaHeight = 165,
    List<Color>? customColors,
    bool showRecentColors = true,
    Size? pickerSize,
    EdgeInsets? pickerPadding,
  }) async {
    Color selectedColor = initialColor;

    final ColorResult? result = await showDialog<ColorResult>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text(dialogTitle),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildColorPicker(
                      pickerType: pickerType,
                      initialColor: initialColor,
                      onColorChanged: (Color color) {
                        setState(() {
                          selectedColor = color;
                        });
                      },
                      enableOpacity: enableOpacity,
                      showLabel: showLabel,
                      pickerAreaBorderRadius: pickerAreaBorderRadius,
                      pickerAreaHeight: pickerAreaHeight,
                      customColors: customColors,
                      showRecentColors: showRecentColors,
                      pickerSize: pickerSize,
                      pickerPadding: pickerPadding,
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    final ColorResult colorResult = _getColorResult(selectedColor);
                    Navigator.of(context).pop(colorResult);
                  },
                ),
              ],
            );
          },
        );
      },
    );

    return result;
  }

  /// Builds the appropriate color picker based on the picker type
  static Widget _buildColorPicker({
    required PickerType pickerType,
    required Color initialColor,
    required ValueChanged<Color> onColorChanged,
    bool enableOpacity = true,
    bool showLabel = true,
    bool pickerAreaBorderRadius = true,
    double pickerAreaHeight = 165,
    List<Color>? customColors,
    bool showRecentColors = true,
    Size? pickerSize,
    EdgeInsets? pickerPadding,
  }) {
    switch (pickerType) {
      case PickerType.materialPicker:
        return MaterialPicker(
          pickerColor: initialColor,
          onColorChanged: onColorChanged,
          enableLabel: showLabel,
          portraitOnly: false,
        );
      case PickerType.adaptivePicker:
      default:
        return _buildAdaptivePicker(
          initialColor: initialColor,
          onColorChanged: onColorChanged,
          enableOpacity: enableOpacity,
          showLabel: showLabel,
          pickerAreaBorderRadius: pickerAreaBorderRadius,
          pickerAreaHeight: pickerAreaHeight,
          customColors: customColors,
          showRecentColors: showRecentColors,
          pickerSize: pickerSize,
          pickerPadding: pickerPadding,
        );
    }
  }

  /// Build Adaptive Picker using flex_color_picker
  static Widget _buildAdaptivePicker({
    required Color initialColor,
    required ValueChanged<Color> onColorChanged,
    bool enableOpacity = true,
    bool showLabel = true,
    bool pickerAreaBorderRadius = true,
    double pickerAreaHeight = 165,
    List<Color>? customColors,
    bool showRecentColors = true,
    Size? pickerSize,
    EdgeInsets? pickerPadding,
  }) {
    return ColorPicker(
      color: initialColor,
      onColorChanged: onColorChanged,
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.primary: true,
        ColorPickerType.accent: true,
        ColorPickerType.bw: false,
        ColorPickerType.custom: true,
        ColorPickerType.wheel: true,
      },
      enableOpacity: enableOpacity,
      showColorCode: false,
      showColorName: false,
      elevation: 0,
      padding: pickerPadding ?? EdgeInsets.zero,
      actionButtons: const ColorPickerActionButtons(
        okButton: true,
        closeButton: true,
        dialogActionButtons: false,
      ),

    );
  }


  /// Converts a Color to ColorResult with name and hex code
  static ColorResult _getColorResult(Color color) {
    final String hexCode = _colorToHex(color);
    final String colorName = _getColorName(color);

    return ColorResult(
      hexCode: hexCode,
      colorName: colorName,
      argbValue: color.toARGB32(),
    );
  }

  static String _colorToHex(Color color) {
    return '#${color.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}';
  }

  /// Gets color name from color using colornames package
  static String _getColorName(Color color) {
    try {
      final String colorName = ColorNames.guess(color);
      return colorName.isNotEmpty ? colorName : 'Unknown Color';
    } catch (e) {
      return 'Unknown Color';
    }
  }
  /// Direct conversion from Color to ColorResult
  static ColorResult colorToResult(Color color) {
    return _getColorResult(color);
  }

  /// Direct conversion from hex string to ColorResult
  static ColorResult hexToResult(String hexCode) {
    try {
      if (!_isValidHex(hexCode)) {
        return const ColorResult(
          hexCode: '#FF000000',
          colorName: 'Invalid Color',
          argbValue: 0xFF000000,
        );
      }

      final Color color = _hexToColor(hexCode);
      return _getColorResult(color);
    } catch (e) {
      return const ColorResult(
        hexCode: '#FF000000',
        colorName: 'Invalid Color',
        argbValue: 0xFF000000,
      );
    }
  }

  /// Check if hex string is valid
  static bool _isValidHex(String hexCode) {
    final RegExp hexRegex =
    RegExp(r'^#?([0-9A-Fa-f]{3}|[0-9A-Fa-f]{6}|[0-9A-Fa-f]{8})$');
    return hexRegex.hasMatch(hexCode);
  }

  /// Convert hex string to Color
  static Color _hexToColor(String hexCode) {
    try {
      String hex = hexCode.replaceFirst('#', '');

      if (hex.length == 3) {
        hex = 'FF${hex[0]}${hex[0]}${hex[1]}${hex[1]}${hex[2]}${hex[2]}';
      } else if (hex.length == 6) {
        hex = 'FF$hex';
      } else if (hex.length == 8) {
        // Already has alpha
      } else {
        throw FormatException('Invalid hex length');
      }

      final int value = int.parse(hex, radix: 16);
      return Color(value);
    } catch (e) {
      throw FormatException('Invalid hex color: $hexCode');
    }
  }

  /// Show color picker in a bottom sheet
  static Future<ColorResult?> showColorPickerBottomSheet({
    required BuildContext context,
    Color initialColor = Colors.blue,
    PickerType pickerType = PickerType.adaptivePicker,
    String sheetTitle = 'Pick a color',
    bool enableOpacity = true,
    bool showColorCode = true,
    bool showColorName = true,
    bool showLabel = true,
    bool pickerAreaBorderRadius = true,
    double pickerAreaHeight = 165,
    List<Color>? customColors,
    bool showRecentColors = true,
    Size? pickerSize,
    EdgeInsets? pickerPadding,
  }) async {
    Color selectedColor = initialColor;

    final ColorResult? result = await showModalBottomSheet<ColorResult>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          sheetTitle,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            _buildColorPicker(
                              pickerType: pickerType,
                              initialColor: initialColor,
                              onColorChanged: (Color color) {
                                setState(() {
                                  selectedColor = color;
                                });
                              },
                              enableOpacity: enableOpacity,
                              showLabel: showLabel,
                              pickerAreaBorderRadius: pickerAreaBorderRadius,
                              pickerAreaHeight: pickerAreaHeight,
                              customColors: customColors,
                              showRecentColors: showRecentColors,
                              pickerSize: pickerSize,
                              pickerPadding: pickerPadding,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Cancel'),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              final ColorResult colorResult =
                              _getColorResult(selectedColor);
                              Navigator.of(context).pop(colorResult);
                            },
                            child: const Text('Select'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );

    return result;
  }

  /// Get default colors for material picker
  static List<Color> getDefaultColors() {
    return [
      Colors.red,
      Colors.pink,
      Colors.purple,
      Colors.deepPurple,
      Colors.indigo,
      Colors.blue,
      Colors.lightBlue,
      Colors.cyan,
      Colors.teal,
      Colors.green,
      Colors.lightGreen,
      Colors.lime,
      Colors.yellow,
      Colors.amber,
      Colors.orange,
      Colors.deepOrange,
      Colors.brown,
      Colors.grey,
      Colors.blueGrey,
      Colors.black,
      Colors.white,
    ];
  }
}