import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.w),
                    topLeft: Radius.circular(20.w)),
                child: Image(
                    height: 60,
                    fit:BoxFit.fill ,
                    width: 100,
                    image: const AssetImage("assets/images/Home.png")),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 130.w,
              child: Text(
                "asdllasdlsaldlalsdllsadlalsdllaldllasldlaasdllasdlsaldlalsdllsadlalsdllaldllasldlaasdllasdlsaldlalsdllsadlalsdllaldllasldlaasdllasdlsaldlalsdllsadlalsdllaldllasldla",
                maxLines: 2,
                style: TextStyle(),
              ),
            ),
          ),
          SizedBox(
            width: 130.w,
            child: Divider(
              thickness: 1,
              color: Colors.blue,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 130.w,
              child: Text(
                "asdllasdlsaldlalsdllsadlalsdllaldllasldlaasdllasdlsaldlalsdllsadlalsdllaldllasldlaasdllasdlsaldlalsdllsadlalsdllaldllasldlaasdllasdlsaldlalsdllsadlalsdllaldllasldla",
                maxLines: 2,
                style: TextStyle(),
              ),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(.2),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10.w), topLeft: Radius.circular(10.w))),
    );
  }
}
