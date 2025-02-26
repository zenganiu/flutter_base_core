import 'dart:async';

typedef DOnTimerCountdownCallback = void Function(int millisUntilFinished);

/// 倒计时
class DTimerCountdown {
  /// 定时器
  Timer? _mTimer;

  /// Timer是否启动.
  bool _isActive = false;

  /// Timer间隔 单位毫秒，默认1000毫秒(1秒).
  int _interval;

  /// 倒计时总时间,单位毫秒
  int _totalTime;

  /// 定时器回调
  DOnTimerCountdownCallback? _onTimerCountdownCallback;

  /// 初始化
  DTimerCountdown({
    int interval = Duration.millisecondsPerSecond,
    int totalTime = 0,
  })  : _interval = interval,
        _totalTime = totalTime;

  /// 设置Timer间隔
  ///
  /// [interval] 间隔,单位毫秒,小于0将默认1秒
  void setDuration(int interval) {
    assert(interval > 0, '间隔应该大于0');
    if (interval <= 0) interval = Duration.millisecondsPerSecond;
    _interval = interval;
  }

  /// 设置Timer间隔
  ///
  /// [interval] 间隔,单位秒,小于0将默认1秒
  void setDurationFromSecond(int interval) {
    setDuration(interval * 1000);
  }

  /// 设置倒计时
  ///
  /// [totalTime] 总时间,单位毫秒,
  void setTotalTime(int totalTime) {
    assert(totalTime > 0, '总时间应该大于0');
    if (totalTime <= 0) return;
    _totalTime = totalTime;
  }

  /// 设置倒计时
  ///
  /// [totalTime] 总时间,单位秒,
  void setTotalTimeWithSecond(int totalTime) {
    setTotalTime(totalTime * 1000);
  }

  void stop() {
    if (_isActive) {
      _mTimer?.cancel();
    }
  }

  /// 启动倒计时Timer.
  void startCountDown() {
    if (_isActive || _interval <= 0 || _totalTime <= 0) return;
    _isActive = true;
    Duration duration = Duration(milliseconds: _interval);
    _doCallback(_totalTime);
    _mTimer = Timer.periodic(duration, (Timer timer) {
      int time = _totalTime - _interval;
      _totalTime = time;
      if (time >= _interval) {
        _doCallback(time);
      } else if (time == 0) {
        _doCallback(time);
        cancel();
      } else {
        timer.cancel();
        Future.delayed(Duration(milliseconds: time), () {
          _totalTime = 0;
          _doCallback(0);
          cancel();
        });
      }
    });
  }

  void setOnTimerCountdownCallback(void Function(int) callback) {
    _onTimerCountdownCallback = callback;
  }

  void _doCallback(int time) {
    if (_onTimerCountdownCallback != null) {
      _onTimerCountdownCallback!(time);
    }
  }

  /// Timer是否启动.
  bool get isActive => _isActive;

  /// 取消计时器.
  void cancel() {
    _mTimer?.cancel();
    _mTimer = null;
    _isActive = false;
  }
}
