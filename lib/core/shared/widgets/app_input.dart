import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_2/core/shared/styles/colors.dart';

class AppInput extends StatefulWidget {
  final void Function(String?)? onSubmitted;
  final validate;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? bottom;
  final double? top;
  final double? height;
  final double? start;
  final double? end;
  final TextInputType? inputType;
  final String? label;
  final String? hint;
  final bool? secureText;
  final bool? isEnabled;
  final bool? autofocus;
  final Color? color;
  final Color? iconColor;
  final TextEditingController? controller;
  final Color? borderColor;
  final Widget? suffix;

  const AppInput(
      {Key? key,
      this.validate,
      this.prefixIcon,
      this.suffixIcon,
      this.inputType,
      this.label,
      this.hint,
      this.height,
      this.secureText,
      this.onSubmitted,
      this.isEnabled = true,
      this.controller,
      this.bottom,
      this.start,
      this.end,
      this.top,
      this.color,
      this.autofocus,
      this.iconColor,
      this.borderColor,
      this.suffix})
      : super(key: key);

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
          top: widget.top ?? 0,
          bottom: widget.bottom ?? 0,
          start: widget.start ?? 0,
          end: widget.end ?? 0),
      child: TextFormField(
        enabled: widget.isEnabled ?? true,
        autovalidateMode: AutovalidateMode.onUserInteraction
,
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: widget.controller,
        onFieldSubmitted: widget.onSubmitted,
        style: TextStyle(color: blackTextColor, fontSize: 12.sp),
        obscureText: widget.secureText ?? false,
        cursorColor: blackTextColor,
        keyboardType: widget.inputType ?? TextInputType.text,
        validator: widget.validate,
        autofocus: widget.autofocus ?? false,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.w),
            borderSide: const BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.w),
            borderSide: const BorderSide(color: primaryColor),
          ),
          // errorBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(10.w),
          //   borderSide: const BorderSide(color: Colors.red),
          // ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.w),
            borderSide: const BorderSide(color: Colors.red),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.w),
            borderSide: const BorderSide(color: Colors.white),
          ),
          // errorStyle: TextStyle(
          //   fontSize: 0.sp,
          //   height: 0.h,
          // ),
          contentPadding: EdgeInsets.only(
              right: 20.r, top: 20.0.r, bottom: 20.0.r, left: 20.r),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0.w),
            borderSide: const BorderSide(color: Colors.white),
          ),
          filled: true,
          fillColor:
              const Color(0xffEFEFEF) /*color ?? const Color(0xFFFFFFFF)*/,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
          suffix: widget.suffix,
          suffixIconConstraints:
              BoxConstraints(maxHeight: 35.h, maxWidth: 45.w),
          labelText: widget.label,
          labelStyle: TextStyle(
            fontSize: 15.sp,
            color: blackTextColor,
          ),
          hintStyle:
              TextStyle(fontSize: 12.sp, color: const Color(0xff404342D6)),
          hintText: widget.hint,
        ),
      ),
    );
  }
}
