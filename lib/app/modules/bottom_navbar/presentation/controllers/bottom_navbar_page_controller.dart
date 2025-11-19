import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_security_workforce/app/core/constants/app_assets.dart';
import 'package:flutter_security_workforce/app/modules/contact_page/presentation/views/contact_page.dart';
import 'package:flutter_security_workforce/app/modules/home_page/presentation/views/home_page.dart';
import 'package:flutter_security_workforce/app/modules/message_page/presentation/views/message_page.dart';
import 'package:flutter_security_workforce/app/modules/my_jobs_page/presentation/views/my_jobs_page.dart';
import 'package:flutter_security_workforce/app/modules/profile_page/views/profile_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class BottomNavbarPageController extends GetxController {
  int index = 0;

  List<BottomNavigationBarItem> get bottomNavbarItems => [
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        width: 70.w,
        height: 70.h,
        (index == 0)
            ? AppAssets.homeSelectedIcon
            : AppAssets.homeUnSelectedIcon,
      ),
      label: "",
    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        width: 70.w,
        height: 70.h,
        (index == 1)
            ? AppAssets.myJobsSelectedIcon
            : AppAssets.myJobsUnSelectedIcon,
      ),
      label: "",
    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        width: 70.w,
        height: 70.h,
        (index == 2)
            ? AppAssets.contactSelectedIcon
            : AppAssets.contactUnSelectedIcon,
      ),
      label: "",
    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        width: 70.w,
        height: 70.h,
        (index == 3)
            ? AppAssets.messageSelectedIcon
            : AppAssets.messageUnSelectedIcon,
      ),
      label: "",
    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        width: 70.w,
        height: 70.h,
        (index == 4)
            ? AppAssets.profileSelectedIcon
            : AppAssets.profileUnSelectedIcon,
      ),
      label: "",
    ),
  ];

  List<Widget> pages = [
    HomePage(),
    MyJobsPage(),
    ContactPage(),
    MessagePage(),
    ProfilePage(),
  ];

  void changePage(int i) {
    index = i;
    update();
  }
}
