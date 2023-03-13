import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Constants/Custom_widget/textwidget.dart';
import '../../Constants/constant.dart';

class PositionSeekWidget extends StatefulWidget {
  Duration? currentPosition;
  Duration? duration;
  Function(Duration)? seekTo;

  PositionSeekWidget({Key? key, this.currentPosition, this.duration, this.seekTo}) : super(key: key);

  @override
  _PositionSeekWidgetState createState() => _PositionSeekWidgetState();
}

class _PositionSeekWidgetState extends State<PositionSeekWidget> {
  Duration? _visibleValue;
  bool? listenOnlyUserInterraction = false;

  double get percent => widget.duration!.inMilliseconds == 0 ? 0 : _visibleValue!.inMilliseconds / widget.duration!.inMilliseconds;

  @override
  void initState() {
    super.initState();
    _visibleValue = widget.currentPosition;
  }

  @override
  void didUpdateWidget(PositionSeekWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listenOnlyUserInterraction!) {
      _visibleValue = widget.currentPosition;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 45.w,
            child: TextWidget.regular(durationToString(widget.currentPosition!),
                fontFamily: "Poppins-Regular", fontSize: 15.sp, textAlign: TextAlign.left),
          ),
          Expanded(
            child: Slider(
              min: 0,
              max: widget.duration!.inMilliseconds.toDouble(),
              value: percent * widget.duration!.inMilliseconds.toDouble(),

              onChangeEnd: (newValue) {
                setState(() {
                  listenOnlyUserInterraction = false;
                  widget.seekTo!(_visibleValue!);
                });
              },
              onChangeStart: (_) {
                setState(() {
                  listenOnlyUserInterraction = true;
                });
              },
              onChanged: (newValue) {
                setState(() {
                  final to = Duration(milliseconds: newValue.floor());
                  _visibleValue = to;
                });
              },
            ),
          ),
          SizedBox(
            width: 45.w,
            child: TextWidget.regular(durationToString(widget.duration!),
                fontFamily: "Poppins-Regular", fontSize: 15.sp, textAlign: TextAlign.right),
          ),
        ],
      ),
    );
  }
}

String durationToString(Duration duration) {
  String twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }

  final twoDigitHours = twoDigits(duration.inHours.remainder(Duration.hoursPerDay));
  final twoDigitMinutes = twoDigits(duration.inMinutes.remainder(Duration.minutesPerHour));
  final twoDigitSeconds = twoDigits(duration.inSeconds.remainder(Duration.secondsPerMinute));
  return twoDigitHours == "00" ? '$twoDigitMinutes:$twoDigitSeconds' : '$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds';
}

