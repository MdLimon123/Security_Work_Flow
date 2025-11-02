import 'package:another_xlider/another_xlider.dart';
import 'package:another_xlider/models/handler.dart';
import 'package:another_xlider/models/tooltip/tooltip.dart';
import 'package:another_xlider/models/trackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_colors.dart';
import '../controllers/profile_verification_page_controller.dart';

class StepTwoPage extends StatelessWidget {
  const StepTwoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileVerificationPageController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Personal Information",
              style: TextStyle(
                fontSize: 24.sp,
                color: AppColors.secondaryNavyBlue,
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: 32.h),

            _buildLanguageInput(controller),

            SizedBox(height: 12.h),

            _buildYearOfExperienceInput(controller),

            SizedBox(height: 12.h),

            _buildSummaryInput(controller),

            SizedBox(height: 12.h),

            Text(
              "Preferred Job Radius (km)",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.secondaryNavyBlue,
              ),
            ),

            _buildPreferedJobRadiusSlider(),

            Row(
              children: [
                Checkbox(
                  value: controller.sendNotifications,
                  onChanged: (value) => controller.toggleSendNotifications(),
                  activeColor: AppColors.primaryOrange,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    "Send me job notifications within my selected radius only.",
                    style: TextStyle(color: AppColors.primaryGray),
                  ),
                ),
              ],
            ),

            _buildNextButton(controller),

            SizedBox(height: 12.h),
          ],
        );
      },
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
              child: Text(
                "Next",
                style: TextStyle(color: AppColors.primaryWhite),
              ),
            ),
          );
  }

  FlutterSlider _buildPreferedJobRadiusSlider() {
    return FlutterSlider(
      trackBar: FlutterSliderTrackBar(
        activeTrackBar: BoxDecoration(color: AppColors.primaryOrange),
        inactiveTrackBar: BoxDecoration(color: Colors.grey.shade300),
      ),

      values: [60],
      max: 100,
      min: 1,

      tooltip: FlutterSliderTooltip(
        alwaysShowTooltip: true,
        format: (value) => "$value km",
      ),

      onDragging: (handlerIndex, lowerValue, upperValue) {},

      // ✅ Circular Drag Handler
      handler: FlutterSliderHandler(
        decoration: BoxDecoration(), // remove default circle
        child: Container(
          height: 16.h,
          width: 16.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryWhite, // inner color
            border: Border.all(color: AppColors.primaryOrange, width: 3),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryOrange,
                blurRadius: 8,
                spreadRadius: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column _buildSummaryInput(ProfileVerificationPageController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Experience Summary",
          style: TextStyle(fontSize: 16.sp, color: AppColors.secondaryNavyBlue),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          maxLines: 3,
          maxLength: 400,
          keyboardType: TextInputType.multiline,
          controller: controller.summaryTEC,
          decoration: InputDecoration(
            hintText: "Summarise industries, roles and tasks",
            hintStyle: TextStyle(color: AppColors.primaryGray),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AppColors.secondaryWhite),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AppColors.secondaryWhite),
            ),
          ),
        ),
      ],
    );
  }

  Column _buildYearOfExperienceInput(
    ProfileVerificationPageController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Years of Experience",
          style: TextStyle(fontSize: 16.sp, color: AppColors.secondaryNavyBlue),
        ),
        PopupMenuButton<String>(
          color: AppColors.primaryWhite,
          onSelected: (value) {
            controller.setYearsOfExperience(value);
          },
          itemBuilder: (context) => [
            const PopupMenuItem(value: "0", child: Text("0")),
            const PopupMenuItem(value: "1", child: Text("1")),
          ],
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.secondaryWhite),
            ),
            child: Row(
              children: [
                Icon(Icons.keyboard_arrow_down, color: AppColors.primaryGray),

                SizedBox(width: 8.w),
                Text(
                  controller.selectedYearsOfExperience.isEmpty
                      ? "Select total years of experience"
                      : controller.selectedYearsOfExperience,
                  style: TextStyle(
                    fontSize: 16,
                    color: controller.selectedYearsOfExperience.isEmpty
                        ? AppColors.primaryGray
                        : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Column _buildLanguageInput(ProfileVerificationPageController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Language",
          style: TextStyle(fontSize: 16.sp, color: AppColors.secondaryNavyBlue),
        ),
        PopupMenuButton<String>(
          color: AppColors.primaryWhite,
          onSelected: (value) {
            controller.setLanguage(value);
          },
          itemBuilder: (context) => [
            const PopupMenuItem(value: "English", child: Text("English")),
            const PopupMenuItem(value: "English", child: Text("English")),
          ],
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.secondaryWhite),
            ),
            child: Row(
              children: [
                Icon(Icons.keyboard_arrow_down, color: AppColors.primaryGray),

                SizedBox(width: 8.w),
                Text(
                  controller.selectedLanguage.isEmpty
                      ? "Select your language"
                      : controller.selectedLanguage,
                  style: TextStyle(
                    fontSize: 16,
                    color: controller.selectedLanguage.isEmpty
                        ? AppColors.primaryGray
                        : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
