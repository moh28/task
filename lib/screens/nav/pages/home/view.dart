import 'package:card_swiper/card_swiper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_2/core/shared/styles/colors.dart';
import 'package:task_2/core/shared/widgets/app_bar.dart';

import '../../../../core/shared/widgets/home_item.dart';
import '../../../../generated/locale_keys.g.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomAppBar(
            title: LocaleKeys.home.tr(),
            action: Padding(
              padding: EdgeInsetsDirectional.only(end: 29.r),
              child: const Icon(
                Icons.notifications,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding:
                EdgeInsetsDirectional.only(start: 17.r, end: 17.r, top: 95.r),
            child: Column(
              children: [
                Container(
                  height: 136.h,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(9.w)),
                  child: Swiper(
                    itemBuilder: (context, index) => const Image(
                      image:
                          NetworkImage('sliderBloc.sliderModel![index].media'),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    autoplay: true,
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    curve: Curves.fastOutSlowIn,
                    pagination: SwiperPagination(
                      alignment: Alignment.bottomCenter,
                      builder: DotSwiperPaginationBuilder(
                          color: Colors.white30,
                          activeColor: primaryColor,
                          size: 10.sp,
                          activeSize: 10.sp),
                    ),
                  ),
                ),
                Container(
                  height: 200.h,
                  child: ListView.builder(
                      itemCount: 10,
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.only(right: 0.w, left: 0.w),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: HomeItem(),
                        );
                      }),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
