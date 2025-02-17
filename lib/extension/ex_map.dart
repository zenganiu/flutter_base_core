import 'package:flutter_base_core/util/util.dart';

/// 对map的扩展
extension DExMap<K, V> on Map<K, V> {
  /// 转json字符串,失败将返回{}
  String get dToJsonStr => DUtils.jsonEncode(this, defValue: '{}') ?? '{}';
}
