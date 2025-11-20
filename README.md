# Color Name Picker 🎨

[![pub package](https://img.shields.io/pub/v/color_name_picker.svg)](https://pub.dev/packages/color_name_picker)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?logo=Flutter&logoColor=white)](https://flutter.dev)

A comprehensive Flutter color picker library that returns color names with hex codes. Supports multiple picker types and provides human-readable color names.

## Features 

- **Multiple Picker Types** - Material, Block, Slide, and Adaptive pickers
- **Color Name Extraction** - Get human-readable color names
- **Hex Code & ARGB Values** - Extract technical color information
- **Easy to Use** - Simple API with flexible customization
- **Opacity Support** - Full transparency/opacity control


## How to Use

### Basic Usage
<?code-excerpt "readme_excerpts.dart (Pick)"?>
```dart
import 'package:color_name_picker/color_name_picker.dart';

final ColorResult? result = await ColorNamePicker.showColorPicker(
  context: context,
  initialColor: Colors.blue,
  pickerType: PickerType.adaptivePicker,
);

if (result != null) {
  print('Hex: ${result.hexCode}');
  print('Name: ${result.colorName}');
  print('ARGB: ${result.argbValue}');
}
```

### Direct Conversion


<?code-excerpt "readme_excerpts.dart (Pick)"?>
```dart
// Convert Color to ColorResult
ColorResult result = ColorNamePicker.colorToResult(Colors.blue);

// Convert hex string to ColorResult
ColorResult result = ColorNamePicker.hexToResult('#FF0000');
```
### Picker Types

<?code-excerpt "readme_excerpts.dart (Pick)"?>
```dart
    PickerType.materialPicker - Material Design color picker

    PickerType.blockPicker - Block style color picker

    PickerType.wheelPicker - Color wheel picker

    PickerType.adaptivePicker - Adaptive picker with multiple options
```
### Advanced Usage 
<?code-excerpt "readme_excerpts.dart (Pick)"?>
```dart
final ColorResult? result = await ColorNamePicker.showColorPicker(
  context: context,
  initialColor: Colors.green,
  pickerType: PickerType.blockPicker,
  dialogTitle: 'Select Theme Color',
  enableOpacity: true,
  showColorCode: true,
  showColorName: true,
  showLabel: true,
);
```

## About

 **Bishal Maji** 

 - **GitHub: @bishalmaji**
  - **Pub.dev: color_name_picker**


    

