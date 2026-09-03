import 'package:flutter/material.dart';

extension DExColor on Color {
  /// 获取hex颜色
  String get dToHex {
    final rInt8 = (r * 255.0).round().clamp(0, 255);
    final gInt8 = (g * 255.0).round().clamp(0, 255);
    final bInt8 = (b * 255.0).round().clamp(0, 255);
    final rRadix = rInt8.toRadixString(16).padLeft(2, '0');
    final gRadix = gInt8.toRadixString(16).padLeft(2, '0');
    final bRadix = bInt8.toRadixString(16).padLeft(2, '0');
    return "#$rRadix$gRadix$bRadix";
  }
}
