import 'package:flutter/material.dart';

extension DExColor on Color {
  /// 获取hex颜色
  String get dToHex {
    final sb = StringBuffer();
    sb.write('#');
    sb.write(red.toRadixString(16).padLeft(2, '0'));
    sb.write(green.toRadixString(16).padLeft(2, '0'));
    sb.write(blue.toRadixString(16).padLeft(2, '0'));
    return sb.toString();
  }
}
