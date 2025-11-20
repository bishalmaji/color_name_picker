import 'package:flutter/material.dart';
import 'package:color_name_picker/color_name_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Color Name Picker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ColorResult? _selectedColor;
  Color _currentColor = Colors.blue;

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isLightColor = _currentColor.computeLuminance() > 0.5;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Color Name Picker',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: _currentColor,
        foregroundColor: isLightColor ? Colors.black87 : Colors.white,
        elevation: 2,
        shadowColor: _currentColor.withOpacity(0.3),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Header
              const Text(
                'Select a Color',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Choose from different color picker styles',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
          
              // Color Preview Card
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: _currentColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      // Color Preview Box
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: _currentColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isLightColor ? Colors.black26 : Colors.white30,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
          
                      // Color Information
                      if (_selectedColor != null) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: isLightColor
                                ? Colors.black.withOpacity(0.1)
                                : Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              // Color Name with Color Indicator
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 16,
                                    height: 16,
                                    decoration: BoxDecoration(
                                      color: _currentColor,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: isLightColor
                                            ? Colors.black26
                                            : Colors.white30,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    _selectedColor!.colorName,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: isLightColor
                                          ? Colors.black87
                                          : Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
          
                              // Hex Code
                              Text(
                                _selectedColor!.hexCode,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Monospace',
                                  color: isLightColor
                                      ? Colors.black87
                                      : Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 4),
          
                              // ARGB Value
                              Text(
                                'ARGB: ${_selectedColor!.argbValue.toRadixString(16).toUpperCase()}',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Monospace',
                                  color: isLightColor
                                      ? Colors.black54
                                      : Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ] else ...[
                        Text(
                          'No color selected',
                          style: TextStyle(
                            fontSize: 16,
                            color: isLightColor
                                ? Colors.black54
                                : Colors.white70,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
          
              // Picker Buttons Section
              const Text(
                'Color Pickers',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  _buildPickerButton(
                    'Material Picker',
                    PickerType.materialPicker,
                    Icons.color_lens_outlined,
                  ),
                  _buildPickerButton(
                    'Block Picker',
                    PickerType.blockPicker,
                    Icons.grid_view,
                  ),
                  _buildPickerButton(
                    'Slide Picker',
                    PickerType.slidePicker,
                    Icons.swap_vert,
                  ),
                  _buildPickerButton(
                    'Adaptive Picker',
                    PickerType.adaptivePicker,
                    Icons.adaptive.share_outlined,
                  ),
                ],
              ),
              const SizedBox(height: 20),
          
              // Additional Options
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  // Bottom Sheet Picker
                  FilledButton.tonal(
                    onPressed: _showBottomSheetPicker,
                    style: FilledButton.styleFrom(
                      backgroundColor: _currentColor.withOpacity(0.1),
                      foregroundColor: _currentColor,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.expand_less),
                        SizedBox(width: 8),
                        Text('Bottom Sheet Picker'),
                      ],
                    ),
                  ),
          
                  // Test Direct Conversion
                  OutlinedButton(
                    onPressed: _testDirectConversion,
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: _currentColor),
                      foregroundColor: _currentColor,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.build_outlined),
                        SizedBox(width: 8),
                        Text('Test Conversion'),
                      ],
                    ),
                  ),
                ],
              ),
          
              // Spacer to push content up
              const Spacer(),
          
              // Footer
              Text(
                'Color Name Picker Demo',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),

      ),
    );
  }

  Widget _buildPickerButton(String text, PickerType pickerType, IconData icon) {
    return FilledButton(
      onPressed: () => _showPicker(pickerType),
      style: FilledButton.styleFrom(
        backgroundColor: _currentColor,
        foregroundColor: _currentColor.computeLuminance() > 0.5
            ? Colors.black87
            : Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Future<void> _showPicker(PickerType pickerType) async {
    final result = await ColorNamePicker.showColorPicker(
      context: context,
      initialColor: _currentColor,
      pickerType: pickerType,
      dialogTitle: 'Select a Color',
      enableOpacity: true,
      showColorCode: true,
      showColorName: true,
      showLabel: true,
    );

    _updateColor(result);
  }

  Future<void> _showBottomSheetPicker() async {
    final result = await ColorNamePicker.showColorPickerBottomSheet(
      context: context,
      initialColor: _currentColor,
      pickerType: PickerType.adaptivePicker,
      sheetTitle: 'Choose Your Color',
      enableOpacity: true,
      showColorCode: true,
      showColorName: true,
    );

    _updateColor(result);
  }

  void _testDirectConversion() {
    // Test popular colors
    final testColors = [
      const Color(0xFF2196F3), // Blue
      const Color(0xFFF44336), // Red
      const Color(0xFF4CAF50), // Green
      const Color(0xFFFF9800), // Orange
      const Color(0xFF9C27B0), // Purple
    ];

    final testHex = ['#FF5722', '#607D8B', '#795548', '#E91E63'];

    String resultText = 'Direct Conversion Test:\n\n';

    for (final color in testColors) {
      final result = ColorNamePicker.colorToResult(color);
      resultText += '${result.colorName} - ${result.hexCode}\n';
    }

    resultText += '\nHex to Result:\n';
    for (final hex in testHex) {
      final result = ColorNamePicker.hexToResult(hex);
      resultText += '$hex → ${result.colorName}\n';
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Conversion Test'),
        content: SingleChildScrollView(
          child: Text(
            resultText,
            style: const TextStyle(fontFamily: 'Monospace', fontSize: 14),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _updateColor(ColorResult? result) {
    if (result != null) {
      setState(() {
        _selectedColor = result;
        _currentColor = Color(result.argbValue);
      });

      _showSnackBar(
        'Selected: ${result.colorName} (${result.hexCode})',
      );
    }
  }
}