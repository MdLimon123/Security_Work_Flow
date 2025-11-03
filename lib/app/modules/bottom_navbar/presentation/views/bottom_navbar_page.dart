import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/modules/bottom_navbar/presentation/controllers/bottom_navbar_page_controller.dart';
import 'package:get/get.dart';

class BottomNavbarPage extends StatelessWidget {
  const BottomNavbarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GetBuilder<BottomNavbarPageController>(
        builder: (controller) {
          return SafeArea(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primaryWhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryBlack,
                    blurRadius: 12,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  currentIndex: controller.index,
                  onTap: controller.changePage,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  backgroundColor: AppColors.primaryWhite,
                  elevation: 0,
                  items: controller.bottomNavbarItems,
                ),
              ),
            ),
          );
        },
      ),

      body: GetBuilder<BottomNavbarPageController>(
        builder: (controller) => controller.pages[controller.index],
      ),
    );
  }
}
