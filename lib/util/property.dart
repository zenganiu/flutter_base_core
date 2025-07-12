import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';

mixin DProperty {
  /// 是否是性能模式
  bool get isProfile => kProfileMode;

  /// 是否是调试模式
  bool get isDebug => kDebugMode;

  /// 是否是调试模式
  bool get isRelease => kReleaseMode;

  /// 是否web
  bool get isWeb => kIsWeb;

  /// 是否iOS平台
  bool get isIOS => Platform.isIOS;

  /// 是否Android平台
  bool get isAndroid => Platform.isAndroid;

  /// 是否MacOS平台
  bool get isMacOS => Platform.isMacOS;

  /// 是否Windows平台
  bool get isWindows => Platform.isWindows;

  /// 是否移动端 iOS/Android
  bool get isMobile => isAndroid || isIOS;

  /// PlatformDispatcher
  PlatformDispatcher get dispatcher => PlatformDispatcher.instance;

  /// FlutterView,未来可能会支持多个窗口。但现在默认只有一个窗口
  ui.FlutterView get view => dispatcher.views.first;

  /// 像素密度
  double get pixelRatio => view.devicePixelRatio;

  /// 屏幕大小
  ui.Size get size => view.physicalSize / pixelRatio;

  /// 屏幕宽度
  double get width => size.width;

  /// 屏幕高度
  double get height => size.height;

  /// 顶部状态栏高度
  double get statusBarHeight => view.padding.top / pixelRatio;

  /// 底部安全区域高度
  double get bottomBarHeight => view.padding.bottom / pixelRatio;

  /// 是否暗黑模式
  bool get isPlatformDarkMode => (dispatcher.platformBrightness == ui.Brightness.dark);
}
