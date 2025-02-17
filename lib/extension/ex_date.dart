import 'package:intl/intl.dart';

extension DExDate on DateTime {
  /// 当前时间是否今天
  bool get dIsToday {
    final cur = DateTime.now();
    return (cur.year == year && cur.month == month && cur.day == day);
  }

  /// 格式化输出时间字符串
  ///
  /// [pattern] 模式，默认yyyy-MM-dd HH:mm:ss
  String dFormat({String pattern = 'yyyy-MM-dd HH:mm:ss'}) {
    final format = DateFormat(pattern);
    return format.format(this);
  }

  /// 时间是否是过去
  bool get dIsPast => isBefore(DateTime.now());

  /// yyyy-MM-dd样式日期
  String get dToDateStr => dFormat(pattern: 'yyyy-MM-dd');

  /// yyyy-MM-dd HH:mm:ss样式时间
  String get dToTimeStr => dFormat();
}
