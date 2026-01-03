import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../controllers/profile_verification_page_controller.dart';

class StepOnePage extends StatelessWidget {
  const StepOnePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileVerificationPageController>(
      builder: (controller) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    controller.increasePageIndex();
                  },
                  child: Text(
                    "Skip",
                    style: TextStyle(color: AppColors.primaryOrange),
                  ),
                ),
              ],
            ),

            Text(
              "Personal Information",
              style: TextStyle(
                fontSize: 24.sp,
                color: AppColors.secondaryNavyBlue,
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: 32.h),

            controller.profileImage == null
                ? InkWell(
                    onTap: () async {
                      await controller.pickPicture();
                    },
                    child: SvgPicture.asset(
                      AppAssets.uploadProfileImageImg,
                      width: 159.w,
                      height: 134.h,
                    ),
                  )
                : InkWell(
                    onTap: () async {
                      await controller.pickPicture();
                    },
                    child: Stack(
                      children: [
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(100.r),
                            child: Image.file(
                              File(controller.profileImage!.paths.first ?? ""),
                              width: 135.w,
                              height: 135.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Icon(
                            Icons.change_circle_outlined,
                            color: AppColors.primaryWhite,
                            size: 45.sp,
                          ),
                        ),
                      ],
                    ),
                  ),

            SizedBox(height: 60.h),
            _buildFullNameInput(controller),
            SizedBox(height: 12.h),

            _buildPhoneNumberInput(controller),
            SizedBox(height: 12.h),

            _buildGenderInput(controller),

            SizedBox(height: 40.h),

            _buildNextButton(controller, context: context),

            SizedBox(height: 12.h),
          ],
        );
      },
    );
  }

  SizedBox _buildNextButton(
    ProfileVerificationPageController controller, {
    required BuildContext context,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          await controller.submitFirstStepData(context: context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondaryNavyBlue,
          foregroundColor: AppColors.primaryWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        child: controller.nextButtonInProgress
            ? Center(
                child: CircularProgressIndicator(color: AppColors.primaryWhite),
              )
            : Text(
                "Next",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
      ),
    );
  }

  Column _buildGenderInput(ProfileVerificationPageController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Gender",
          style: TextStyle(fontSize: 16.sp, color: AppColors.secondaryNavyBlue),
        ),
        PopupMenuButton<String>(
          color: AppColors.primaryWhite,
          onSelected: (value) {
            controller.setGender(value);
          },
          itemBuilder: (context) => [
            const PopupMenuItem(value: "Male", child: Text("Male")),
            const PopupMenuItem(value: "Female", child: Text("Female")),
            const PopupMenuItem(value: "Non-binary", child: Text("Non-binary")),
            const PopupMenuItem(
              value: "Prefer not to say",
              child: Text("Prefer not to say"),
            ),
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
                  controller.selectedGender.isEmpty
                      ? "Select your gender"
                      : controller.selectedGender,
                  style: TextStyle(
                    fontSize: 16,
                    color: controller.selectedGender.isEmpty
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

  Column _buildFullNameInput(ProfileVerificationPageController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Full Name",
          style: TextStyle(fontSize: 16.sp, color: AppColors.secondaryNavyBlue),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller.fullNameTEC,
          decoration: InputDecoration(
            hintText: "Enter your full name",
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

  Column _buildPhoneNumberInput(ProfileVerificationPageController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Phone Number",
          style: TextStyle(fontSize: 16.sp, color: AppColors.secondaryNavyBlue),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller.phoneTEC,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            hintText: "Enter your phone number",
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
}
