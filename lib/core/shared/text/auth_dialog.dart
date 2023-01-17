import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_2/gen/fonts.gen.dart';

class AuthDialog extends StatelessWidget {
  final double? top;
  final double? bottom;
  final double? start;
  final double? end;
  final String title;

  const AuthDialog(
      {Key? key,
      this.bottom,
      this.end,
      this.start,
      this.top,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
          top: top ?? 0,
          end: end ?? 0,
          start: start ?? 0,
          bottom: bottom ?? 0),
      child: SizedBox(
        height: 46.h,

          child: Text(
            title,
            style: TextStyle(
              fontSize: 13.sp,
              fontFamily: FontFamily.arabic,
              color: const Color(0xff505050),
            ),
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ),

    );
  }
}
