import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_security_workforce/app/core/constants/app_assets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_colors.dart';
import '../controllers/profile_verification_page_controller.dart';

class StepSixPage extends StatelessWidget {
  const StepSixPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Almost There!",
          style: TextStyle(
            fontSize: 24.sp,
            color: AppColors.secondaryNavyBlue,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          "We’re reviewing your profile. Approval confirmation will be sent to your email.",
          style: TextStyle(fontSize: 16.sp, color: AppColors.secondaryGray),
          textAlign: TextAlign.center,
        ),

        SizedBox(height: 32.h),
        SvgPicture.asset(
          width: 143.w,
          height: 143.h,
          AppAssets.navyBlueTickIcon,
        ),
        SizedBox(height: 20.h),

        GetBuilder<ProfileVerificationPageController>(
          builder: (controller) {
            return _buildNextButton(controller);
          },
        ),

        SizedBox(height: 12.h),
      ],
    );
  }

  SizedBox _buildNextButton(ProfileVerificationPageController controller) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          controller.increasePageIndex();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondaryNavyBlue,
          foregroundColor: AppColors.primaryWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        child: Text("Next", style: TextStyle(color: AppColors.primaryWhite)),
      ),
    );
  }
}
