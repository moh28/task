import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_2/core/shared/styles/colors.dart';
import 'package:task_2/gen/fonts.gen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? action;
  final Widget? leading;
  final String title;

  const CustomAppBar({Key? key,required this.title, this.leading, this.action})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 103.h,
      decoration: BoxDecoration(color: primaryColor,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30.w),
          bottomRight: Radius.circular(30.w),)
      ),
      child: Padding(
        padding:  EdgeInsetsDirectional.only(end: 13.r,top: 59.r,bottom: 23.r,start: 13.r),
        child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:  [
            leading??SizedBox(width: 24.w,height: 24.h,),
            Text(title,style: TextStyle(fontSize: 16.sp,fontFamily: FontFamily.medium,color: const Color(0xffFFFFFF)),),
            action??SizedBox(width: 24.w,height: 24.h,),

          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(103.0.h);
}
