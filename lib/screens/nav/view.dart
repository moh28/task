import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_2/core/shared/styles/colors.dart';
import 'package:task_2/gen/fonts.gen.dart';
import 'package:task_2/screens/nav/pages/cart/view.dart';
import 'package:task_2/screens/nav/pages/home/view.dart';
import 'package:task_2/screens/nav/pages/more/view.dart';
import 'package:task_2/screens/nav/pages/orders/view.dart';
import '../../gen/assets.gen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> bottomScreens = [
    const HomePage(),
    const CartPage(),
    const OrderPage(),
    const MorePage()
  ];

  void changeBottomNavBar(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  List<String> titles = ['الرئيسية', 'السلة', 'مشترياتى', 'المزيد'];
  List<String> icons = [
    Assets.images.home.path,
    Assets.images.note.path,
    Assets.images.user.path,
    Assets.images.notification.path
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bottomScreens[currentIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: Container(
          height: 72.h,
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: const BoxDecoration(color: primaryColor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(4, (index) => buildItem(index)),
            )),
      ),
    );
  }

  Widget buildItem(int index) {
    return InkWell(
      onTap: () {
        changeBottomNavBar(index);
      },
      child: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
             SizedBox(height: 8.h),
            ImageIcon(
              AssetImage(
                icons[index],
              ),
              color: Colors.white,
              size: 24.h,
            ),
             SizedBox(height: 3.h),
            Text(
              titles[index],
              style:  TextStyle(color: Colors.white, fontSize: 10.sp,fontFamily: FontFamily.medium),
            ),
             SizedBox(height: 3.h),
            AnimatedOpacity(
              opacity: index == currentIndex ? 1 : 0,
              duration: const Duration(milliseconds: 300),
              child:  Icon(
                Icons.circle,
                size: 8.h,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
