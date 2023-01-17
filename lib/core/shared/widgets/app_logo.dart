import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class AppLogo extends StatelessWidget {
  const AppLogo({Key? key,this.bottom,this.start,this.end,this.top,}) : super(key: key);
  final double? start;
  final double? end;
  final double? top;
  final double? bottom;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsetsDirectional.only(start:start??0,end:end ??0,bottom: bottom??0,top: top??0 ),
      child: SizedBox(height: 47.h,width: 240.w,child: Image.asset('assets/images/logo.webp',fit: BoxFit.fill,),),
    );
  }
}
