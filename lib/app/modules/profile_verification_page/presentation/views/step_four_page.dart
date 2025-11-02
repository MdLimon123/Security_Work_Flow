import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_security_workforce/app/core/constants/app_assets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_colors.dart';
import '../controllers/profile_verification_page_controller.dart';

class StepFourPage extends StatelessWidget {
  const StepFourPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileVerificationPageController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Other Accreditations",
                style: TextStyle(
                  fontSize: 24.sp,
                  color: AppColors.secondaryNavyBlue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            SizedBox(height: 32.h),

            _buildAccreditationInput(controller),

            SizedBox(height: 16.h),

            Text(
              "Accreditation Upload",
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.secondaryNavyBlue,
              ),
            ),

            InkWell(
              onTap: () {},
              child: SvgPicture.asset(
                AppAssets.uploadBackFrontImageAccreditationImage,
              ),
            ),

            _buildUploadedElementStatus(),

            SizedBox(height: 16.h),

            _buildExpireDateAccreditationInput(controller),

            SizedBox(height: 20.h),
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
        child: Text("Next", style: TextStyle(color: AppColors.primaryWhite)),
      ),
    );
  }

  Column _buildExpireDateAccreditationInput(
    ProfileVerificationPageController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Expiry Date",
          style: TextStyle(fontSize: 16.sp, color: AppColors.secondaryNavyBlue),
        ),

        TextFormField(
          keyboardType: TextInputType.datetime,
          controller: controller.accreditationTEC,
          decoration: InputDecoration(
            hintText: "Enter accreditation expiry date",
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

  Visibility _buildUploadedElementStatus() {
    return Visibility(
      visible: true,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.primaryGray),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.sp),
          child: Row(
            children: [
              SvgPicture.asset(AppAssets.pdfIcon),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "assets.zip",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "5.3MB",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryTextColor,
                    ),
                  ),
                ],
              ),
              Spacer(),
              InkWell(
                onTap: () {},
                child: SvgPicture.asset(
                  AppAssets.cancelIcon,
                  width: 24.w,
                  height: 24.h,
                  colorFilter: ColorFilter.mode(
                    AppColors.primaryGray,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column _buildAccreditationInput(
    ProfileVerificationPageController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Accreditation Type",
          style: TextStyle(fontSize: 16.sp, color: AppColors.secondaryNavyBlue),
        ),
        PopupMenuButton<String>(
          color: AppColors.primaryWhite,
          onSelected: (value) {
            controller.setSelectedAccreditation(value);
          },
          itemBuilder: (context) => [
            const PopupMenuItem(value: "Accepted", child: Text("Accepted")),
            const PopupMenuItem(
              value: "Not Accepted",
              child: Text("Not Accepted"),
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
                  controller.selectedAccreditation.isEmpty
                      ? "Select your accreditation type"
                      : controller.selectedAccreditation,
                  style: TextStyle(
                    fontSize: 16,
                    color: controller.selectedAccreditation.isEmpty
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
