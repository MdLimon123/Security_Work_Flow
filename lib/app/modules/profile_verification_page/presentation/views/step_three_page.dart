import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_security_workforce/app/core/constants/app_assets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_colors.dart';
import '../controllers/profile_verification_page_controller.dart';

class StepThreePage extends StatelessWidget {
  const StepThreePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileVerificationPageController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Licences & Certifications",
                style: TextStyle(
                  fontSize: 24.sp,
                  color: AppColors.secondaryNavyBlue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            SizedBox(height: 32.h),

            _buildStateOrTerritoryInput(controller),

            SizedBox(height: 16.h),

            _buildLicenseTypeInput(controller),

            SizedBox(height: 16.h),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Licence Upload",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.secondaryNavyBlue,
                  ),
                ),

                GestureDetector(
                  onTap: () async {
                    await controller.pickLicences(context: context);
                  },
                  child: SvgPicture.asset(
                    AppAssets.uploadBackFrontImageLicenseImage,
                  ),
                ),

                SizedBox(height: 8.h),

                for (
                  int i = 0;
                  i <
                      (controller.licenceFiles?.files == null
                          ? 0
                          : controller.licenceFiles!.files.length);
                  i++
                )
                  Column(
                    children: [
                      controller.fileUploaded
                          ? Text(
                              controller.licenceFiles?.files[i].name ?? "",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )
                          : _buildUploadFileStatus(),
                      SizedBox(height: 16.h),
                    ],
                  ),

                _buildLicenseExpireInput(controller),

                SizedBox(height: 20.h),
                _buildNextButton(controller, context: context),
                SizedBox(height: 12.h),
              ],
            ),
          ],
        );
      },
    );
  }

  Column _buildLicenseExpireInput(
    ProfileVerificationPageController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Licence Expiry Date",
          style: TextStyle(fontSize: 16.sp, color: AppColors.secondaryNavyBlue),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          keyboardType: TextInputType.datetime,
          controller: controller.licenseExpireTEC,
          decoration: InputDecoration(
            hintText: "2000-01-30",
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

  Visibility _buildUploadFileStatus() {
    return Visibility(
      visible: true,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.primaryGray),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Uploading...",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        GetBuilder<ProfileVerificationPageController>(
                          builder: (controller) {
                            return Text(
                              "${controller.uploadingPercent}%  • ${controller.uploadSeconds} seconds remaining",
                              style: TextStyle(
                                color: AppColors.secondaryTextColor,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  // Spacer(),
                  // Row(
                  //   children: [
                  //     InkWell(
                  //       onTap: () {},
                  //       child: SvgPicture.asset(
                  //         AppAssets.pauseIcon,
                  //         width: 24.w,
                  //         height: 24.h,
                  //       ),
                  //     ),
                  //     SizedBox(width: 4.w),
                  //     InkWell(
                  //       onTap: () {},
                  //       child: SvgPicture.asset(
                  //         AppAssets.cancelIcon,
                  //         width: 24.w,
                  //         height: 24.h,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),

              SizedBox(height: 8.h),
              SizedBox(
                width: double.infinity,
                child: GetBuilder<ProfileVerificationPageController>(
                  builder: (controller) {
                    return LinearProgressIndicator(
                      value: controller.uploadingPercent / 100,
                      minHeight: 8.sp,
                      borderRadius: BorderRadius.circular(6.r),
                      color: AppColors.primaryBlue,
                      backgroundColor: AppColors.lightGrey,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column _buildStateOrTerritoryInput(
    ProfileVerificationPageController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "State or Territory",
          style: TextStyle(fontSize: 16.sp, color: AppColors.secondaryNavyBlue),
        ),
        PopupMenuButton<String>(
          color: AppColors.primaryWhite,
          onSelected: (value) {
            controller.setStateOrTerritory(value);
          },
          itemBuilder: (context) => [
            PopupMenuItem(value: "NSW", child: Text("NSW (New South Wales)")),
            PopupMenuItem(value: "VIC", child: Text("VIC (Victoria)")),
            PopupMenuItem(value: "WA", child: Text("WA (Western Australia)")),
            PopupMenuItem(value: "QLD", child: Text("QLD (Queensland)")),
            PopupMenuItem(value: "SA", child: Text("SA (South Australia)")),
            PopupMenuItem(
              value: "ACT",
              child: Text("ACT (Australian Capital Territory)"),
            ),
            PopupMenuItem(value: "NT", child: Text("NT (Northern Territory)")),
            PopupMenuItem(value: "TAS", child: Text("TAS (Tasmania)")),
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
                  controller.selectedStateOrTerritory.isEmpty
                      ? "Select your State or Territory"
                      : controller.selectedStateOrTerritory,
                  style: TextStyle(
                    fontSize: 16,
                    color: controller.selectedStateOrTerritory.isEmpty
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

  Column _buildLicenseTypeInput(ProfileVerificationPageController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Licence Type(s)",
          style: TextStyle(fontSize: 16.sp, color: AppColors.secondaryNavyBlue),
        ),
        PopupMenuButton<String>(
          color: AppColors.primaryWhite,
          onSelected: (value) {
            controller.setSelectedLicenseType(value);
          },
          itemBuilder: (context) => [
            for (
              int i = 0;
              i < controller.listOfLicenceTypeModel.licenceTypes!.length;
              i++
            )
              PopupMenuItem(
                value:
                    controller.listOfLicenceTypeModel.licenceTypes?[i].title ??
                    "0",
                child: Text(
                  controller.listOfLicenceTypeModel.licenceTypes?[i].title ??
                      "",
                ),
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
                  controller.selectedLicenseType.isEmpty
                      ? "Select your State or Territory"
                      : controller.selectedLicenseType,
                  style: TextStyle(
                    fontSize: 16,
                    color: controller.selectedLicenseType.isEmpty
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

  SizedBox _buildNextButton(
    ProfileVerificationPageController controller, {
    required BuildContext context,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          controller.submitThirdStepData(
            context: context,
            controller: controller,
          );
          // controller.increasePageIndex();
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
            : Text("Next", style: TextStyle(color: AppColors.primaryWhite)),
      ),
    );
  }
}
