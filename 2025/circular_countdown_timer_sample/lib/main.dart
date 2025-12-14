import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '리딩 챌린지',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF1A1A1E),
        primaryColor: const Color(0xFF7E5FF0),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final CustomCountDownController _controller = CustomCountDownController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // 앱이 백그라운드에서 포그라운드로 돌아올 때 UI 갱신
    if (state == AppLifecycleState.resumed) {
      if (_controller.isStarted.value && !_controller.isPaused.value) {
        // 타이머가 실행 중이었다면 UI 업데이트 트리거
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenHeight < 700;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '리딩 챌린지',
          style: TextStyle(
            fontSize: isSmallScreen ? 16 : 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF1A1A1E),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight:
                  screenHeight -
                  MediaQuery.of(context).padding.top -
                  kToolbarHeight,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: isSmallScreen ? 10 : 20),
                // 타이머
                SizedBox(
                  height: screenHeight * (isSmallScreen ? 0.35 : 0.4),
                  child: CustomCountDownTimer(
                    controller: _controller,
                    autoStart: false,
                    onStart: () {
                      debugPrint('Countdown Started');
                      setState(() {});
                    },
                    onChange: (String timeStamp) {
                      debugPrint('Countdown Changed $timeStamp');
                    },
                  ),
                ),
                SizedBox(height: isSmallScreen ? 10 : 20),
                // 인용구
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                  child: Column(
                    children: [
                      Text(
                        '달허있기만 한 책은 블록일 뿐이다.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: isSmallScreen ? 14 : 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: isSmallScreen ? 4 : 8),
                      Text(
                        '토마스 풀러',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white38,
                          fontSize: isSmallScreen ? 12 : 14,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: isSmallScreen ? 20 : 30),
                // 컨트롤 섹션
                ValueListenableBuilder<bool>(
                  valueListenable: _controller.isStarted,
                  builder: (context, isStarted, child) {
                    return ValueListenableBuilder<bool>(
                      valueListenable: _controller.isPaused,
                      builder: (context, isPaused, child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // 최초 또는 일시정지 상태: Start 버튼
                            if (!isStarted || isPaused)
                              _controlButton(
                                label: 'Start',
                                icon: Icons.play_arrow,
                                color: const Color(0xFF7E5FF0),
                                onPressed: () {
                                  if (isPaused) {
                                    _controller.resume();
                                  } else {
                                    _controller.start();
                                  }
                                  setState(() {});
                                },
                                size: isSmallScreen ? 60 : 70,
                              ),

                            // 일시정지 상태: Start와 정지 사이 간격
                            if (isPaused && isStarted)
                              SizedBox(width: isSmallScreen ? 15 : 20),

                            // 실행 중: 일시정지 버튼
                            if (isStarted && !isPaused)
                              _controlButton(
                                label: '일시정지',
                                icon: Icons.pause,
                                color: const Color(0xFF5E4FD0),
                                onPressed: () {
                                  _controller.pause();
                                  setState(() {});
                                },
                                size: isSmallScreen ? 60 : 70,
                              ),

                            // 일시정지 상태: 정지 버튼
                            if (isPaused && isStarted)
                              _controlButton(
                                label: '정지',
                                icon: Icons.stop,
                                color: const Color(0xFF4E3FB0),
                                onPressed: () {
                                  _showStopDialog(context);
                                },
                                size: isSmallScreen ? 60 : 70,
                              ),
                          ],
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: isSmallScreen ? 15 : 20),
                // 시간 표시
                ValueListenableBuilder<String>(
                  valueListenable: _controller.currentTime,
                  builder: (context, timeString, child) {
                    final parts = timeString.split(':');
                    final displayTime = '${parts[1]}:${parts[2]}'; // MM:SS 형식
                    return Text(
                      displayTime,
                      style: TextStyle(
                        color: const Color(0xFF7E5FF0),
                        fontSize: isSmallScreen
                            ? 56
                            : screenWidth > 400
                            ? 72
                            : 60,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -2,
                      ),
                    );
                  },
                ),
                SizedBox(height: isSmallScreen ? 20 : 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _controlButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
    double size = 70,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: IconButton(
        icon: Icon(icon, size: size * 0.4),
        color: Colors.white,
        onPressed: onPressed,
        padding: EdgeInsets.zero,
      ),
    );
  }

  void _showStopDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2D2D33),
          title: const Text('타이머 정지', style: TextStyle(color: Colors.white)),
          content: const Text(
            '타이머를 정지하시겠습니까?\n경과 시간이 초기화됩니다.',
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('취소', style: TextStyle(color: Colors.white70)),
            ),
            TextButton(
              onPressed: () {
                _controller.reset();
                setState(() {});
                Navigator.of(context).pop();
              },
              child: const Text(
                '정지',
                style: TextStyle(color: Color(0xFF7E5FF0)),
              ),
            ),
          ],
        );
      },
    );
  }
}

// ============================================================================
// CustomCountDownTimer
// ============================================================================

class CustomCountDownTimer extends StatefulWidget {
  final VoidCallback? onComplete;
  final VoidCallback? onStart;
  final ValueChanged<String>? onChange;
  final CustomCountDownController? controller;
  final bool autoStart;

  const CustomCountDownTimer({
    this.onComplete,
    this.onStart,
    this.onChange,
    super.key,
    this.autoStart = true,
    this.controller,
  });

  @override
  CustomCountDownTimerState createState() => CustomCountDownTimerState();
}

class CustomCountDownTimerState extends State<CustomCountDownTimer>
    with TickerProviderStateMixin {
  AnimationController? _controller;
  CustomCountDownController? countDownController;
  Timer? _backgroundTimer;
  final duration = 60;
  final ringColor = Color.fromRGBO(45, 45, 51, 1);
  final fillGradient = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [Color.fromRGBO(175, 159, 255, 1), Color.fromRGBO(80, 63, 171, 1)],
  );
  final backgroundColor = Colors.transparent;
  final strokeWidth = 10.0;
  final strokeCap = StrokeCap.round;

  DateTime? _startTime;
  int _totalElapsedSeconds = 0;

  void _setAnimation() {
    if (widget.autoStart) {
      _startTime = DateTime.now();
      _controller!.repeat();
      _startBackgroundTimer();
    }
  }

  void _setController() {
    countDownController?._state = this;
    countDownController?.isStarted.value = widget.autoStart;
  }

  void _startBackgroundTimer() {
    _backgroundTimer?.cancel();
    _backgroundTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_startTime != null) {
        final elapsed = DateTime.now().difference(_startTime!);
        _totalElapsedSeconds = elapsed.inSeconds;
        final timeString = _getTime(Duration(seconds: _totalElapsedSeconds));
        countDownController?.currentTime.value = timeString;
        if (widget.onChange != null) widget.onChange!(timeString);
      }
    });
  }

  void _stopBackgroundTimer() {
    _backgroundTimer?.cancel();
    _backgroundTimer = null;
  }

  String _getTime(Duration duration) {
    return '${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  void _onStart() {
    if (widget.onStart != null) widget.onStart!();
  }

  @override
  void initState() {
    countDownController = widget.controller ?? CustomCountDownController();
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: duration),
    );

    bool hasStarted = false;
    _controller!.addStatusListener((status) {
      switch (status) {
        case AnimationStatus.forward:
          if (!hasStarted) {
            _onStart();
            hasStarted = true;
          }
          break;
        case AnimationStatus.reverse:
        case AnimationStatus.dismissed:
        case AnimationStatus.completed:
          break;
      }
    });

    _setAnimation();
    _setController();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.maxHeight < constraints.maxWidth
            ? constraints.maxHeight
            : constraints.maxWidth;

        return Center(
          child: SizedBox(width: size, height: size, child: _buildTimer(size)),
        );
      },
    );
  }

  Widget _buildTimer(double size) {
    return AnimatedBuilder(
      animation: _controller!,
      builder: (context, child) {
        int currentElapsedSeconds = _totalElapsedSeconds;
        if (_startTime != null && _controller!.isAnimating) {
          final elapsed = DateTime.now().difference(_startTime!);
          currentElapsedSeconds = elapsed.inSeconds;
        }

        return Align(
          child: AspectRatio(
            aspectRatio: 1.0,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: CustomPaint(
                    painter: CustomTimerPainter(
                      animation: _controller,
                      fillGradient: fillGradient,
                      ringColor: ringColor,
                      strokeWidth: strokeWidth,
                      strokeCap: strokeCap,
                      backgroundColor: backgroundColor,
                    ),
                  ),
                ),
                Align(
                  alignment: FractionalOffset.center,
                  child: CharacterWidget(
                    isRunning: _controller?.isAnimating ?? false,
                    size: size,
                  ),
                ),
                if (_controller!.isAnimating)
                  Positioned(
                    right: size * 0.05,
                    top: size * 0.25,
                    child: ProgressMessage(
                      elapsedMinutes: currentElapsedSeconds ~/ 60,
                      fontSize: size * 0.04,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _stopBackgroundTimer();
    _controller!.stop();
    _controller!.dispose();
    super.dispose();
  }
}

// ============================================================================
// CustomCountDownController
// ============================================================================

class CustomCountDownController {
  CustomCountDownTimerState? _state;
  ValueNotifier<bool> isStarted = ValueNotifier<bool>(false);
  ValueNotifier<bool> isPaused = ValueNotifier<bool>(false);
  ValueNotifier<String> currentTime = ValueNotifier<String>("00:00:00");

  void start() {
    if (_state != null && _state?._controller != null) {
      _state?._startTime = DateTime.now();
      _state?._totalElapsedSeconds = 0;
      _state?._controller?.repeat();
      _state?._startBackgroundTimer();
      isStarted.value = true;
      isPaused.value = false;
    }
  }

  void pause() {
    if (_state != null && _state?._controller != null) {
      if (_state!._startTime != null) {
        final elapsed = DateTime.now().difference(_state!._startTime!);
        _state!._totalElapsedSeconds = elapsed.inSeconds;
        currentTime.value = _state!._getTime(
          Duration(seconds: _state!._totalElapsedSeconds),
        );
      }
      _state?._controller?.stop(canceled: false);
      _state?._stopBackgroundTimer();
      isPaused.value = true;
    }
  }

  void resume() {
    if (_state != null && _state?._controller != null) {
      _state?._startTime = DateTime.now().subtract(
        Duration(seconds: _state!._totalElapsedSeconds),
      );
      _state?._controller?.repeat(min: _state!._controller!.value);
      _state?._startBackgroundTimer();
      isPaused.value = false;
    }
  }

  void restart({int? duration}) {
    if (_state != null && _state?._controller != null) {
      _state?._controller!.duration = Duration(
        seconds: duration ?? _state!._controller!.duration!.inSeconds,
      );
      _state?._startTime = DateTime.now();
      _state?._totalElapsedSeconds = 0;
      _state?._controller?.repeat();
      _state?._startBackgroundTimer();
      isStarted.value = true;
      isPaused.value = false;
      currentTime.value = "00:00:00";
    }
  }

  void reset() {
    if (_state != null && _state?._controller != null) {
      _state?._controller?.reset();
      _state?._stopBackgroundTimer();
      _state?._startTime = null;
      _state?._totalElapsedSeconds = 0;
      isStarted.value = _state?.widget.autoStart ?? false;
      isPaused.value = false;
      currentTime.value = "00:00:00";
    }
  }

  String? getTime() {
    if (_state != null) {
      int totalSeconds = _state!._totalElapsedSeconds;
      if (_state!._startTime != null && _state!._controller!.isAnimating) {
        final elapsed = DateTime.now().difference(_state!._startTime!);
        totalSeconds = elapsed.inSeconds;
      }
      return _state?._getTime(Duration(seconds: totalSeconds));
    }
    return "00:00:00";
  }
}

// ============================================================================
// CustomTimerPainter
// ============================================================================

class CustomTimerPainter extends CustomPainter {
  CustomTimerPainter({
    this.animation,
    this.fillGradient,
    this.ringColor,
    this.strokeWidth,
    this.strokeCap,
    this.backgroundColor,
  }) : super(repaint: animation);

  final Animation<double>? animation;
  final Color? ringColor, backgroundColor;
  final double? strokeWidth;
  final StrokeCap? strokeCap;
  final Gradient? fillGradient;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = ringColor!
      ..strokeWidth = strokeWidth!
      ..strokeCap = strokeCap!
      ..style = PaintingStyle.stroke;

    paint.shader = null;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2, paint);
    double progress = (animation!.value) * 2 * math.pi;
    double startAngle = math.pi * 1.5;

    if (fillGradient != null) {
      final rect = Rect.fromCircle(
        center: size.center(Offset.zero),
        radius: size.width / 2,
      );
      paint.shader = fillGradient!.createShader(rect);
    }

    canvas.drawArc(Offset.zero & size, startAngle, progress, false, paint);

    if (backgroundColor != null) {
      final backgroundPaint = Paint();
      backgroundPaint.color = backgroundColor!;
      canvas.drawCircle(
        size.center(Offset.zero),
        size.width / 2.2,
        backgroundPaint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomTimerPainter oldDelegate) {
    return animation!.value != oldDelegate.animation!.value ||
        ringColor != oldDelegate.ringColor;
  }
}

// ============================================================================
// CharacterWidget
// ============================================================================

class CharacterWidget extends StatefulWidget {
  final bool isRunning;
  final double? size;

  const CharacterWidget({super.key, this.isRunning = false, this.size});

  @override
  State<CharacterWidget> createState() => _CharacterWidgetState();
}

class _CharacterWidgetState extends State<CharacterWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _bounceAnimation = Tween<double>(begin: -5, end: 5).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scale = widget.size != null ? widget.size! / 300 : 1.0;

    return AnimatedBuilder(
      animation: _bounceAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, widget.isRunning ? _bounceAnimation.value : 0),
          child: child,
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Container(
          //   padding: EdgeInsets.all(4 * scale),
          //   decoration: BoxDecoration(
          //     color: Colors.orange.withValues(alpha: 0.2),
          //     shape: BoxShape.circle,
          //   ),
          //   child: Icon(
          //     Icons.local_fire_department,
          //     color: Colors.orange,
          //     size: 20 * scale,
          //   ),
          // ),
          // SizedBox(height: 8 * scale),
          // Container(
          //   width: 120 * scale,
          //   height: 100 * scale,
          //   decoration: BoxDecoration(
          //     color: const Color(0xFF7E5FF0),
          //     borderRadius: BorderRadius.circular(60 * scale),
          //   ),
          //   child: Stack(
          //     alignment: Alignment.center,
          //     children: [
          //       Positioned(
          //         top: 20 * scale,
          //         child: Row(
          //           mainAxisSize: MainAxisSize.min,
          //           children: [
          //             _buildEye(scale),
          //             SizedBox(width: 20 * scale),
          //             _buildEye(scale),
          //           ],
          //         ),
          //       ),
          //       Positioned(
          //         bottom: 20 * scale,
          //         child: Container(
          //           width: 50 * scale,
          //           height: 5 * scale,
          //           decoration: BoxDecoration(
          //             color: Colors.white,
          //             borderRadius: BorderRadius.circular(10 * scale),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // Container(
          //   margin: EdgeInsets.only(top: 10 * scale),
          //   width: 80 * scale,
          //   height: 8 * scale,
          //   decoration: BoxDecoration(
          //     color: Colors.black.withValues(alpha: 0.3),
          //     borderRadius: BorderRadius.circular(20 * scale),
          //   ),
          // ),
        ],
      ),
    );
  }
}

// ============================================================================
// ProgressMessage
// ============================================================================

class ProgressMessage extends StatefulWidget {
  final int elapsedMinutes;
  final double? fontSize;

  const ProgressMessage({
    super.key,
    required this.elapsedMinutes,
    this.fontSize,
  });

  @override
  State<ProgressMessage> createState() => _ProgressMessageState();
}

class _ProgressMessageState extends State<ProgressMessage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.forward();
  }

  @override
  void didUpdateWidget(ProgressMessage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.elapsedMinutes != widget.elapsedMinutes) {
      _animationController.reset();
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String _getMessage() {
    final minutes = widget.elapsedMinutes;
    if (minutes == 0) {
      return '시작!';
    } else {
      return '$minutes분째 독서 중!';
    }
  }

  @override
  Widget build(BuildContext context) {
    final textSize = widget.fontSize ?? 14;
    final paddingScale = textSize / 14;
    final radius = 20 * paddingScale;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12 * paddingScale,
          vertical: 6 * paddingScale,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF2D2D33),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radius),
            topRight: Radius.circular(radius),
            bottomRight: Radius.circular(radius),
            bottomLeft: Radius.circular(2 * paddingScale),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 4 * paddingScale,
              offset: Offset(0, 2 * paddingScale),
            ),
          ],
        ),
        child: Text(
          _getMessage(),
          style: TextStyle(
            color: Colors.white,
            fontSize: textSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
