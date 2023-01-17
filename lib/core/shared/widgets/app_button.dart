import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_2/core/shared/styles/colors.dart';
import 'package:task_2/gen/fonts.gen.dart';

class AppButton extends StatelessWidget {
  final void Function() onTap;
  final String title;
  final Color? color;
  final Color? textColor;
  final double? height;
  final double? borderRadius;
  final double? width;
  final double? start;
  final double? end;
  final double? top;
  final double? bottom;

  const AppButton(
      {Key? key,
      required this.title,
      this.end,
      this.start,
      this.bottom,
      this.width,
      required this.onTap,
      this.height,
      this.top,
      this.borderRadius,
      this.textColor,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
          start: start ?? 0,
          end: end ?? 0,
          bottom: bottom ?? 0,
          top: top ?? 0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: height ?? 56.h,
          width: width ?? double.infinity,
          decoration: BoxDecoration(
            color: color ?? primaryColor,
            borderRadius: BorderRadius.circular(borderRadius ?? 10.w),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontFamily: FontFamily.medium,
                height: 2,
                fontSize: 18.sp,
                color: whiteTextColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
