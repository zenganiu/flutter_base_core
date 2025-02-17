import 'package:flutter_base_core/util/util.dart';

extension DExList<E> on List<E> {
  /// 安全的获取首个元素
  E? get dFirst {
    if (isEmpty) return null;
    return first;
  }

  /// 安全的获取最后一个元素
  E? get dSafeLast {
    if (isEmpty) return null;
    return last;
  }

  /// 安全的获取索引对应的元素
  E? dSafeIndex(int idx) {
    if (isEmpty) return null;
    if (length <= idx || idx < 0) {
      return null;
    }
    return this[idx];
  }

  /// 安全的获取符合条件的第一个元素
  E? dSafeFirstWhere(bool Function(E e) test) {
    final idx = indexWhere(test);
    return dSafeIndex(idx);
  }

  /// 转换为jsonString,失败为"[]"
  String get dToJsonStr => DUtils.jsonEncode(this, defValue: '[]') ?? '[]';
}
