import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parkingapp/utils/appColor.dart';
import 'package:parkingapp/utils/appStyle.dart';
import 'package:parkingapp/utils/dynamic_size.dart';

class CountDownTimer extends StatefulWidget {
  String? startTime;
  String? endTime;

  CountDownTimer({required this.startTime, required this.endTime});
  @override
  _CountDownTimerState createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer>
    with TickerProviderStateMixin {
  late AnimationController controller;

  String get timerString {
    Duration duration = controller.duration! * controller.value;
    return '${duration.inHours}:${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    getTimeFromDate();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 20, minutes: 0, hours: 0),
    );

    controller.reverse(from: controller.value == 0.0 ? 1.0 : controller.value);
  }

  var startHour;
  var startMinute;
  var startSec;
  getTimeFromDate() {
    DateTime sdate = DateTime.parse(widget.startTime.toString());
    startHour = sdate.hour;
    startMinute = sdate.minute;
    startSec = sdate.second;

    debugPrint('startHour: $startHour');
    debugPrint('startMinute: $startMinute');

    debugPrint('startSec: $startSec');
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Container(
            height: dynamicHeight(context, 0.35),
            // color: Colors.amber,
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Align(
                          alignment: FractionalOffset.center,
                          child: AspectRatio(
                            aspectRatio: 1.0,
                            child: Stack(
                              children: <Widget>[
                                Positioned.fill(
                                  child: CustomPaint(
                                      painter: CustomTimerPainter(
                                    animation: controller,
                                    backgroundColor:
                                        AppColor.primaryColor.withOpacity(0.1),
                                    color: AppColor.primaryColor,
                                  )),
                                ),
                                Align(
                                  alignment: FractionalOffset.center,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "Count Down Timer",
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        timerString,
                                        style: AppStyle.subHeading
                                            .copyWith(fontSize: 60.sp),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // AnimatedBuilder(
                      //     animation: controller,
                      //     builder: (context, child) {
                      //       return FloatingActionButton.extended(
                      //           onPressed: () {
                      //             if (controller.isAnimating)
                      //               controller.stop();
                      //             else {
                      //               controller.reverse(
                      //                   from: controller.value == 0.0
                      //                       ? 1.0
                      //                       : controller.value);
                      //             }
                      //           },
                      //           icon: Icon(controller.isAnimating
                      //               ? Icons.pause
                      //               : Icons.play_arrow),
                      //           label: Text(controller.isAnimating
                      //               ? "Pause"
                      //               : "Play"));
                      //     }),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class CustomTimerPainter extends CustomPainter {
  CustomTimerPainter({
    this.animation,
    this.backgroundColor,
    this.color,
  }) : super(repaint: animation);

  final Animation<double>? animation;
  final Color? backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor!
      ..strokeWidth = 15.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color!;
    double progress = (1.0 - animation!.value) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(CustomTimerPainter old) {
    return animation!.value != old.animation!.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}
