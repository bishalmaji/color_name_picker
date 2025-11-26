# Color Name Picker 🎨

[![pub package](https://img.shields.io/pub/v/color_name_picker.svg)](https://pub.dev/packages/color_name_picker)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?logo=Flutter&logoColor=white)](https://flutter.dev)

A comprehensive Flutter color picker library that returns color names with hex codes. Supports multiple picker types and provides human-readable color names.

## Features

- **Multi Picker Types** - Material Design picker and Adaptive picker with multiple tabs
- **Color Name Extraction** - Get human-readable color names using advanced detection
- **Hex Code & ARGB Values** - Extract technical color information
- **Easy to Use** - Simple API with flexible customization
- **Opacity Support** - Full transparency/opacity control
- **Dialog & Bottom Sheet** - Multiple display modes
- **Custom Colors** - Support for custom color swatches

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  color_name_picker: ^1.2.0
  ```

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

### Bottom Sheet Picker


<?code-excerpt "readme_excerpts.dart (Pick)"?>
```dart
final ColorResult? result = await ColorNamePicker.showColorPickerBottomSheet(
  context: context,
  initialColor: Colors.red,
  pickerType: PickerType.materialPicker,
  sheetTitle: 'Choose your color',
);
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
PickerType.materialPicker    // Simple Material Design color picker
PickerType.adaptivePicker    // Advanced picker with multiple tabs (primary, accent, custom, wheel)
```
### Advanced Usage 
<?code-excerpt "readme_excerpts.dart (Pick)"?>
```dart
final ColorResult? result = await ColorNamePicker.showColorPicker(
  context: context,
  initialColor: Colors.green,
  pickerType: PickerType.adaptivePicker,
  dialogTitle: 'Select Theme Color',
  enableOpacity: true,
  showColorCode: true,
  showColorName: true,
  showLabel: true,
  customColors: [
    Colors.red,
    Colors.green,
    Colors.blue,
    Color(0xFF123456),
  ],
  pickerAreaHeight: 200,
);
```

### Parameters

| Parameter          | Type           | Default         | Description                       |
|--------------------|----------------|-----------------|-----------------------------------|
| **context**        | BuildContext   | Required        | Build context for showing dialog  |
| **initialColor**   | Color          | Colors.blue     | Initial selected color            |
| **pickerType**     | PickerType     | adaptivePicker  | Type of color picker              |
| **dialogTitle**    | String         | 'Pick a color'  | Title for dialog                  |
| **sheetTitle**     | String         | 'Pick a color'  | Title for bottom sheet            |
| **enableOpacity**  | bool           | true            | Enable opacity/alpha channel      |
| **showColorCode**  | bool           | true            | Show hex color code               |
| **showColorName**  | bool           | true            | Show color name                   |
| **showLabel**      | bool           | true            | Show labels in picker             |
| **pickerAreaHeight** | double       | 165             | Height of picker area             |
| **customColors**   | List<Color>?   | null            | Custom color swatches             |


### About

**Bishal Maji**

- **GitHub:** @bishalmaji  
- **Pub.dev:** color_name_picker

### Support This Project ❤️

If you find this package helpful and want to support its development, consider buying me a coffee!

**☕ Support:**  
[Buy Me a Coffee](https://buymeacoffee.com/bishalmaji)

Your contribution helps me maintain the project, add new features, and keep it updated.  
Thank you for your support! 🙏




    

