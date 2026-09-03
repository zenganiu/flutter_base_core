import 'dart:convert' as convert;
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_base_core/extension/ex_date.dart';
import 'package:flutter_base_core/extension/ex_string.dart';
import 'package:intl/intl.dart';

mixin DMethod {
  /// 强制退出应用
  void forceExitApp() => exit(0);

  /// 转换成json字符串,失败将返回defValue
  String? jsonEncode(Object? value, {String? defValue}) {
    try {
      final res = convert.jsonEncode(value);
      return res;
    } catch (e) {
      return defValue;
    }
  }

  /// json解码,失败返回null
  dynamic jsonDecode(String value) {
    try {
      final res = convert.jsonDecode(value);
      return res;
    } catch (e) {
      return null;
    }
  }

  /// hex颜色
  Color fromHex(String hex, {Color defaultColor = Colors.black}) {
    return hex.dToColor(defaultColor: defaultColor);
  }

  /// 格式化金额
  String moneyFormat(double amount, {String format = "#,##0.00"}) {
    NumberFormat fm = NumberFormat(format);
    return fm.format(amount);
  }

  /// 格式化时间,不符合将返回原值
  String dateFormat(dynamic dateTime, {String pattern = 'yyyy-MM-dd HH:mm:ss'}) {
    var fm = dateTime.toString();
    if (dateTime is String) {
      final date = DateTime.tryParse(dateTime);
      if (date != null) {
        return date.dFormat(pattern: pattern);
      }
    } else if (dateTime is DateTime) {
      return dateTime.dFormat(pattern: pattern);
    } else if (dateTime is int) {
      final date = DateTime.fromMillisecondsSinceEpoch(dateTime);
      return date.dFormat(pattern: pattern);
    }
    return fm;
  }

  /// 指定范围的随机数
  static int randomInRange(int min, int max) {
    final random = Random();
    return min + random.nextInt(max - min + 1);
  }

  /// 指定范围的随机数字符串
  static String randomInRangeToStr(int min, int max) {
    return '${randomInRange(min, max)}';
  }

  /// 获取url中query参数,不存在返回空串
  static String getQueryValueByUrl({required String url, required String key}) {
    return url.dGetQueryValue(key: key);
  }
}
