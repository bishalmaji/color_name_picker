class ColorResult {
  final String hexCode;
  final String colorName;
  final int argbValue;

  const ColorResult({
    required this.hexCode,
    required this.colorName,
    required this.argbValue,
  });

  @override
  String toString() {
    return 'ColorResult(hexCode: $hexCode, colorName: $colorName, argbValue: $argbValue)';
  }

  Map<String, dynamic> toJson() {
    return {
      'hexCode': hexCode,
      'colorName': colorName,
      'argbValue': argbValue,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ColorResult &&
          runtimeType == other.runtimeType &&
          hexCode == other.hexCode &&
          colorName == other.colorName &&
          argbValue == other.argbValue;

  @override
  int get hashCode =>
      hexCode.hashCode ^ colorName.hashCode ^ argbValue.hashCode;
}
