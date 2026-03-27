import 'dart:convert' as convert;

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_core/util/util.dart';

extension DExString on String {
  /// 是否是空
  bool get dIsBlank => trim().isEmpty;

  /// hex转换成Color对象
  ///
  /// [defaultColor] 默认颜色，默认为黑色
  Color dToColor({Color defaultColor = Colors.black}) {
    final sb = StringBuffer();
    if (length == 6 || length == 7) sb.write('ff');
    sb.write(replaceAll('#', ''));
    final hex = int.tryParse(sb.toString(), radix: 16);
    if (hex != null) {
      return Color(hex);
    } else {
      return defaultColor;
    }
  }

  /// md5加密
  String get dToMD5 {
    var content = const convert.Utf8Encoder().convert(this);
    var digest = md5.convert(content);
    return digest.toString();
  }

  /// 转为int
  int? get dToInt {
    try {
      return int.tryParse(this);
    } catch (e) {
      return null;
    }
  }

  /// 转为int, 失败给默认值, 默认为0
  int dToIntOrDefValue({int defValue = 0}) {
    return dToInt ?? defValue;
  }

  /// 转为double
  double? get dToDouble {
    try {
      return double.tryParse(this);
    } catch (e) {
      return null;
    }
  }

  /// 转为double, 失败给默认值, 默认为0
  double dToDoubleOrDefValue({double defValue = 0.0}) {
    return dToDouble ?? defValue;
  }

  /// 字符串替换,范围错误返回原值
  ///
  /// [start] 起始位置
  /// [end] 结束位置
  /// [replacement] 替换内容
  String dReplaceString({int start = 3, int end = 7, String replacement = '****'}) {
    if (start < 0 || length < end || start > end) return this;
    return replaceRange(start, end, replacement);
  }

  /// 反转字符串
  String get dReverse {
    if (isEmpty) return '';
    StringBuffer sb = StringBuffer();
    for (int i = length - 1; i >= 0; i--) {
      sb.writeCharCode(codeUnitAt(i));
    }
    return sb.toString();
  }

  /// 移除所有空格
  String get dTrimAll {
    return replaceAll(RegExp(r"\s+\b|\b\s"), "");
  }

  /// 正则判断
  bool dRegExpMatch(String expStr) {
    RegExp exp = RegExp(expStr);
    return exp.hasMatch(this);
  }

  /// 是否是手机号码
  bool get dIsPhone {
    return dRegExpMatch(r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
  }

  /// 是否是正确的url
  bool get dIsUrl {
    if (dIsBlank) {
      return false;
    }
    final regex = RegExp(
      r'^(https?:\/\/)' // http or https
      r'((([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,})|' // domain
      r'localhost|' // localhost
      r'(\d{1,3}(\.\d{1,3}){3}))' // ip
      r'(:\d+)?' // port
      r'(\/[^\s]*)?$',
    );
    return regex.hasMatch(this);
  }

  /// 是否是身份证号码
  bool get dIsIDNumber {
    if (dIsBlank) {
      return false;
    }
    final res = dRegExpMatch(
      r'^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$|^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X|x)$',
    );
    return res;
  }

  /// jsonString转换为对象
  dynamic get dToJson => DUtils.jsonDecode(this);

  /// 转化成DateTime
  DateTime? get dToDateTime => DateTime.tryParse(this);
}
