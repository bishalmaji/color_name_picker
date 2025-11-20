// import 'package:flutter/material.dart';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart' hide ColorPicker;
// import 'package:flex_color_picker/flex_color_picker.dart';
// import 'package:colornames/colornames.dart';
//
// import 'models/color_result.dart';
// import 'enums/picker_type.dart';
//
// class ColorNamePicker {
//   /// Shows a color picker dialog and returns ColorResult with name and hex code
//   static Future<ColorResult?> showColorPicker({
//     required BuildContext context,
//     Color initialColor = Colors.blue,
//     PickerType pickerType = PickerType.adaptivePicker,
//     String dialogTitle = 'Pick a color',
//     bool enableOpacity = true,
//     bool showColorCode = true,
//     bool showColorName = true,
//     bool showLabel = true,
//     bool pickerAreaBorderRadius = true,
//     double pickerAreaHeight = 165,
//   }) async {
//     Color selectedColor = initialColor;
//
//     final ColorResult? result = await showDialog<ColorResult>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(dialogTitle),
//           content: SingleChildScrollView(
//             child: _buildColorPicker(
//               context: context,
//               pickerType: pickerType,
//               initialColor: initialColor,
//               onColorChanged: (Color color) {
//                 selectedColor = color;
//               },
//               enableOpacity: enableOpacity,
//               showColorCode: showColorCode,
//               showColorName: showColorName,
//               showLabel: showLabel,
//               pickerAreaBorderRadius: pickerAreaBorderRadius,
//               pickerAreaHeight: pickerAreaHeight,
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Cancel'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: const Text('OK'),
//               onPressed: () {
//                 final ColorResult colorResult = _getColorResult(selectedColor);
//                 Navigator.of(context).pop(colorResult);
//               },
//             ),
//           ],
//         );
//       },
//     );
//
//     return result;
//   }
//
//   /// Builds the appropriate color picker based on the picker type
//   static Widget _buildColorPicker({
//     required BuildContext context,
//     required PickerType pickerType,
//     required Color initialColor,
//     required ValueChanged<Color> onColorChanged,
//     bool enableOpacity = true,
//     bool showColorCode = true,
//     bool showColorName = true,
//     bool showLabel = true,
//     bool pickerAreaBorderRadius = true,
//     double pickerAreaHeight = 165,
//   }) {
//     switch (pickerType) {
//       case PickerType.materialPicker:
//         return MaterialPicker(
//           pickerColor: initialColor,
//           onColorChanged: onColorChanged,
//           enableLabel: showLabel,
//           portraitOnly: false,
//         );
//       case PickerType.blockPicker:
//         return BlockPicker(
//           pickerColor: initialColor,
//           onColorChanged: onColorChanged,
//           availableColors: _getDefaultColors(),
//         );
//       case PickerType.slidePicker:
//         return SlidePicker(
//           pickerColor: initialColor,
//           onColorChanged: onColorChanged,
//           showLabel: showLabel,
//         );
//
//       case PickerType.adaptivePicker:
//       default:
//         return _buildAdaptivePicker(
//           context: context,
//           initialColor: initialColor,
//           onColorChanged: onColorChanged,
//           enableOpacity: enableOpacity,
//           showColorCode: showColorCode,
//           showColorName: showColorName,
//           pickerAreaBorderRadius: pickerAreaBorderRadius,
//           pickerAreaHeight: pickerAreaHeight,
//         );
//     }
//   }
//
//
//
//   /// Build Adaptive Picker using flex_color_picker
//   static Widget _buildAdaptivePicker({
//     required BuildContext context,
//     required Color initialColor,
//     required ValueChanged<Color> onColorChanged,
//     bool enableOpacity = true,
//     bool showColorCode = true,
//     bool showColorName = true,
//     bool pickerAreaBorderRadius = true,
//     double pickerAreaHeight = 165,
//   }) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         ColorPicker(
//           color: initialColor,
//           onColorChanged: onColorChanged,
//           pickersEnabled: const <ColorPickerType, bool>{
//             ColorPickerType.primary: true,
//             ColorPickerType.accent: true,
//             ColorPickerType.bw: false,
//             ColorPickerType.custom: true,
//             ColorPickerType.wheel: true,
//           },
//           enableOpacity: enableOpacity,
//           showColorCode: showColorCode,
//           actionButtons: const ColorPickerActionButtons(
//             okButton: true,
//             closeButton: true,
//             dialogActionButtons: false,
//           ),
//         ),
//         if (showColorName || showColorCode) ...[
//           const SizedBox(height: 16),
//           _buildColorInfo(
//             initialColor,
//             showColorCode: showColorCode,
//             showColorName: showColorName,
//           ),
//         ],
//       ],
//     );
//   }
//
//   /// Builds color information widget
//   static Widget _buildColorInfo(
//       Color color, {
//         required bool showColorCode,
//         required bool showColorName,
//       }) {
//     final ColorResult colorResult = _getColorResult(color);
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (showColorCode)
//           Text(
//             'Hex: ${colorResult.hexCode}',
//             style: const TextStyle(fontWeight: FontWeight.bold),
//           ),
//         if (showColorName && showColorCode) const SizedBox(height: 4),
//         if (showColorName)
//           Text(
//             'Name: ${colorResult.colorName}',
//             style: const TextStyle(fontStyle: FontStyle.italic),
//           ),
//       ],
//     );
//   }
//
//   /// Converts a Color to ColorResult with name and hex code
//   static ColorResult _getColorResult(Color color) {
//     final String hexCode = _colorToHex(color);
//     final String colorName = _getColorName(color);
//
//     return ColorResult(
//       hexCode: hexCode,
//       colorName: colorName,
//       argbValue: color.value,
//     );
//   }
//
//   /// Converts Color to hex string
//   static String _colorToHex(Color color) {
//     return '#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
//   }
//
//   /// Gets color name from color using colornames package
//   static String _getColorName(Color color) {
//     try {
//       // Use the extension method from colornames package
//       final String colorName = ColorNames.guess(color);
//       return colorName.isNotEmpty ? colorName : 'Unknown Color';
//     } catch (e) {
//       return 'Unknown Color';
//     }
//   }
//
//   /// Get default colors for block picker
//   static List<Color> _getDefaultColors() {
//     return [
//       Colors.red,
//       Colors.pink,
//       Colors.purple,
//       Colors.deepPurple,
//       Colors.indigo,
//       Colors.blue,
//       Colors.lightBlue,
//       Colors.cyan,
//       Colors.teal,
//       Colors.green,
//       Colors.lightGreen,
//       Colors.lime,
//       Colors.yellow,
//       Colors.amber,
//       Colors.orange,
//       Colors.deepOrange,
//       Colors.brown,
//       Colors.grey,
//       Colors.blueGrey,
//       Colors.black,
//       Colors.white,
//     ];
//   }
//
//   /// Direct conversion from Color to ColorResult
//   static ColorResult colorToResult(Color color) {
//     return _getColorResult(color);
//   }
//
//   /// Direct conversion from hex string to ColorResult
//   static ColorResult hexToResult(String hexCode) {
//     try {
//       final Color color = _hexToColor(hexCode);
//       return _getColorResult(color);
//     } catch (e) {
//       return const ColorResult(
//         hexCode: '#FF000000',
//         colorName: 'Invalid Color',
//         argbValue: 0xFF000000,
//       );
//     }
//   }
//
//   /// Convert hex string to Color
//   static Color _hexToColor(String hexCode) {
//     try {
//       String hex = hexCode.replaceFirst('#', '');
//       if (hex.length == 6) {
//         hex = 'FF$hex';
//       }
//       final int value = int.parse(hex, radix: 16);
//       return Color(value);
//     } catch (e) {
//       return Colors.black;
//     }
//   }
//
//   /// Show color picker in a bottom sheet
//   static Future<ColorResult?> showColorPickerBottomSheet({
//     required BuildContext context,
//     Color initialColor = Colors.blue,
//     PickerType pickerType = PickerType.adaptivePicker,
//     String sheetTitle = 'Pick a color',
//     bool enableOpacity = true,
//     bool showColorCode = true,
//     bool showColorName = true,
//   }) async {
//     Color selectedColor = initialColor;
//
//     final ColorResult? result = await showModalBottomSheet<ColorResult>(
//       context: context,
//       isScrollControlled: true,
//       builder: (BuildContext context) {
//         return SizedBox(
//           height: MediaQuery.of(context).size.height * 0.8,
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       sheetTitle,
//                       style: Theme.of(context).textTheme.headlineSmall,
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.close),
//                       onPressed: () => Navigator.of(context).pop(),
//                     ),
//                   ],
//                 ),
//               ),
//               const Divider(),
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: _buildColorPicker(
//                       context: context,
//                       pickerType: pickerType,
//                       initialColor: initialColor,
//                       onColorChanged: (Color color) {
//                         selectedColor = color;
//                       },
//                       enableOpacity: enableOpacity,
//                       showColorCode: showColorCode,
//                       showColorName: showColorName,
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: OutlinedButton(
//                         onPressed: () => Navigator.of(context).pop(),
//                         child: const Text('Cancel'),
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: ElevatedButton(
//                         onPressed: () {
//                           final ColorResult colorResult =
//                           _getColorResult(selectedColor);
//                           Navigator.of(context).pop(colorResult);
//                         },
//                         child: const Text('Select'),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//
//     return result;
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart' hide ColorPicker;
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:colornames/colornames.dart';

import 'models/color_result.dart';
import 'enums/picker_type.dart';

class ColorNamePicker {
  /// Shows a color picker dialog and returns ColorResult with name and hex code
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
  }) async {
    Color selectedColor = initialColor;

    final ColorResult? result = await showDialog<ColorResult>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(dialogTitle),
          content: SingleChildScrollView(
            child: _buildColorPicker(
              context: context,
              pickerType: pickerType,
              initialColor: initialColor,
              onColorChanged: (Color color) {
                selectedColor = color;
              },
              enableOpacity: enableOpacity,
              showColorCode: showColorCode,
              showColorName: showColorName,
              showLabel: showLabel,
              pickerAreaBorderRadius: pickerAreaBorderRadius,
              pickerAreaHeight: pickerAreaHeight,
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

    return result;
  }

  /// Builds the appropriate color picker based on the picker type
  static Widget _buildColorPicker({
    required BuildContext context,
    required PickerType pickerType,
    required Color initialColor,
    required ValueChanged<Color> onColorChanged,
    bool enableOpacity = true,
    bool showColorCode = true,
    bool showColorName = true,
    bool showLabel = true,
    bool pickerAreaBorderRadius = true,
    double pickerAreaHeight = 165,
  }) {
    switch (pickerType) {
      case PickerType.materialPicker:
        return MaterialPicker(
          pickerColor: initialColor,
          onColorChanged: onColorChanged,
          enableLabel: showLabel,
          portraitOnly: false,
        );
      case PickerType.blockPicker:
        return BlockPicker(
          pickerColor: initialColor,
          onColorChanged: onColorChanged,
          availableColors: _getDefaultColors(),
        );
      case PickerType.slidePicker:
        return SlidePicker(
          pickerColor: initialColor,
          onColorChanged: onColorChanged,
          showLabel: showLabel,
        );

      case PickerType.adaptivePicker:
      default:
        return _buildAdaptivePicker(
          context: context,
          initialColor: initialColor,
          onColorChanged: onColorChanged,
          enableOpacity: enableOpacity,
          showColorCode: showColorCode,
          showColorName: showColorName,
          pickerAreaBorderRadius: pickerAreaBorderRadius,
          pickerAreaHeight: pickerAreaHeight,
        );
    }
  }

  /// Build Adaptive Picker using flex_color_picker
  static Widget _buildAdaptivePicker({
    required BuildContext context,
    required Color initialColor,
    required ValueChanged<Color> onColorChanged,
    bool enableOpacity = true,
    bool showColorCode = true,
    bool showColorName = true,
    bool pickerAreaBorderRadius = true,
    double pickerAreaHeight = 165,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ColorPicker(
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
          showColorCode: showColorCode,
          actionButtons: const ColorPickerActionButtons(
            okButton: true,
            closeButton: true,
            dialogActionButtons: false,
          ),
        ),
        if (showColorName || showColorCode) ...[
          const SizedBox(height: 16),
          _buildColorInfo(
            initialColor,
            showColorCode: showColorCode,
            showColorName: showColorName,
          ),
        ],
      ],
    );
  }

  /// Builds color information widget
  static Widget _buildColorInfo(
      Color color, {
        required bool showColorCode,
        required bool showColorName,
      }) {
    final ColorResult colorResult = _getColorResult(color);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showColorCode)
          Text(
            'Hex: ${colorResult.hexCode}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        if (showColorName && showColorCode) const SizedBox(height: 4),
        if (showColorName)
          Text(
            'Name: ${colorResult.colorName}',
            style: const TextStyle(fontStyle: FontStyle.italic),
          ),
      ],
    );
  }

  /// Converts a Color to ColorResult with name and hex code
  static ColorResult _getColorResult(Color color) {
    final String hexCode = _colorToHex(color);
    final String colorName = _getColorName(color);

    return ColorResult(
      hexCode: hexCode,
      colorName: colorName,
      argbValue: color.value,
    );
  }

  /// Converts Color to hex string
  static String _colorToHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
  }

  /// Gets color name from color using colornames package
  static String _getColorName(Color color) {
    try {
      // Use the extension method from colornames package
      final String colorName = ColorNames.guess(color);
      return colorName.isNotEmpty ? colorName : 'Unknown Color';
    } catch (e) {
      return 'Unknown Color';
    }
  }

  /// Get default colors for block picker
  static List<Color> _getDefaultColors() {
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

  /// Direct conversion from Color to ColorResult
  static ColorResult colorToResult(Color color) {
    return _getColorResult(color);
  }

  /// Direct conversion from hex string to ColorResult
  static ColorResult hexToResult(String hexCode) {
    try {
      // Validate hex format first
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
    final RegExp hexRegex = RegExp(r'^#?([0-9A-Fa-f]{3}|[0-9A-Fa-f]{6}|[0-9A-Fa-f]{8})$');
    return hexRegex.hasMatch(hexCode);
  }

  /// Convert hex string to Color
  static Color _hexToColor(String hexCode) {
    try {
      String hex = hexCode.replaceFirst('#', '');

      // Handle different hex formats
      if (hex.length == 3) {
        // Expand shorthand #RGB to #RRGGBB
        hex = 'FF${hex[0]}${hex[0]}${hex[1]}${hex[1]}${hex[2]}${hex[2]}';
      } else if (hex.length == 6) {
        hex = 'FF$hex';
      } else if (hex.length == 8) {
        // Already has alpha, use as is
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
  }) async {
    Color selectedColor = initialColor;

    final ColorResult? result = await showModalBottomSheet<ColorResult>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
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
                    child: _buildColorPicker(
                      context: context,
                      pickerType: pickerType,
                      initialColor: initialColor,
                      onColorChanged: (Color color) {
                        selectedColor = color;
                      },
                      enableOpacity: enableOpacity,
                      showColorCode: showColorCode,
                      showColorName: showColorName,
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

    return result;
  }
}