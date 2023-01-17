import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../gen/fonts.gen.dart';
class AuthHeaders extends StatelessWidget {
  const AuthHeaders({Key? key,this.bottom,this.start,this.end,this.top,required this.title}) : super(key: key);
  final double? start;
  final double? end;
  final double? top;
  final double? bottom;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsetsDirectional.only(start: start??0,end:end??0 ,top:top??0 ,bottom:bottom??0 ,),child: Text(title,
      style:
      TextStyle(fontSize: 14.sp, fontFamily: FontFamily.demi),),);
  }
}
