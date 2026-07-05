import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:securiverse_security_workforce/app/core/constants/app_colors.dart';
import 'package:securiverse_security_workforce/app/routes/app_routes.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/app_assets.dart';

class PasswordChangedMessagePage extends StatelessWidget {
  const PasswordChangedMessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                Center(child: Image.asset(AppAssets.securiverseIcon)),
                SizedBox(height: 56.h),
                Text(
                  "Password Change",
                  style: TextStyle(
                    fontSize: 36.sp,
                    color: AppColors.secondaryNavyBlue,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  "Your password has been changed successfully.",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.primaryGray,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 24.h),

                SvgPicture.asset(
                  AppAssets.orangeTickIcon,
                  width: 143.w,
                  height: 143.h,
                ),

                SizedBox(height: 46.h),

                _buildContinueButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox _buildContinueButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Get.offAllNamed(AppRoutes.onBoardingRoute);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondaryNavyBlue,
          foregroundColor: AppColors.primaryWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        child: Text(
          "Continue",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
