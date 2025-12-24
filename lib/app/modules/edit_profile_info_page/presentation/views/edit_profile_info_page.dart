import 'package:another_xlider/another_xlider.dart';
import 'package:another_xlider/models/handler.dart';
import 'package:another_xlider/models/tooltip/tooltip.dart';
import 'package:another_xlider/models/trackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_security_workforce/app/core/constants/app_assets.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/modules/edit_profile_info_page/presentation/controllers/edit_profile_info_page_controller.dart';
import 'package:flutter_security_workforce/app/routes/app_routes.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class EditProfileInfoPage extends StatelessWidget {
  const EditProfileInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Edit Profile info",
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(AppRoutes.notificationRoute);
            },
            icon: Icon(Icons.notifications_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 22.h),

                _buildProfilePictureEdit(),

                SizedBox(height: 32.h),

                _buildFullNameInput(),

                SizedBox(height: 12.h),

                _buildPhoneNumberInput(),

                SizedBox(height: 12.h),

                _buildAddressInput(),

                SizedBox(height: 12.h),

                _buildLanguageInput(),

                SizedBox(height: 12.h),

                _buildGenderInput(),

                SizedBox(height: 12.h),

                _buildPrefferedJobRadius(),

                _buildNotificationSendCheckBox(),

                SizedBox(height: 16.h),

                _buildSaveAndUpdateButton(),
                SizedBox(height: 18.h),
                _buildCancleButton(),
                SizedBox(height: 18.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Center _buildCancleButton() {
    return Center(
      child: InkWell(
        onTap: () {},
        child: Text(
          "Cancel",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.secondaryNavyBlue,
          ),
        ),
      ),
    );
  }

  SizedBox _buildSaveAndUpdateButton() {
    return SizedBox(
      width: double.infinity,
      child: GetBuilder<EditProfileInfoPageController>(
        builder: (controller) {
          return ElevatedButton(
            onPressed: () async {
              await controller.updateProfileInfo();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondaryNavyBlue,

              foregroundColor: AppColors.primaryWhite,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
            child: controller.saveAndUpdateButtonLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryWhite,
                    ),
                  )
                : Text(
                    "Save & Update",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          );
        },
      ),
    );
  }

  GetBuilder<EditProfileInfoPageController> _buildNotificationSendCheckBox() {
    return GetBuilder<EditProfileInfoPageController>(
      builder: (controller) {
        return Row(
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
        );
      },
    );
  }

  Column _buildPrefferedJobRadius() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Preferred Job Radius (km)",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
        ),

        GetBuilder<EditProfileInfoPageController>(
          builder: (controller) {
            return FlutterSlider(
              trackBar: FlutterSliderTrackBar(
                activeTrackBar: BoxDecoration(color: AppColors.primaryOrange),
                inactiveTrackBar: BoxDecoration(color: Colors.grey.shade300),
              ),

              values: [controller.preferredJobRadius],
              max: 100,
              min: 1,

              tooltip: FlutterSliderTooltip(
                alwaysShowTooltip: true,
                format: (value) {
                  controller.preferredJobRadius = double.tryParse(value) ?? 1.0;
                  return "$value km";
                },
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
                    border: Border.all(
                      color: AppColors.primaryOrange,
                      width: 3,
                    ),
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
          },
        ),
      ],
    );
  }

  GetBuilder<EditProfileInfoPageController> _buildGenderInput() {
    return GetBuilder<EditProfileInfoPageController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Gender", style: TextStyle(fontSize: 16.sp)),
            SizedBox(height: 4.h),
            PopupMenuButton<String>(
              color: AppColors.primaryWhite,
              onSelected: (value) {
                controller.setGender(value);
              },
              itemBuilder: (context) => [
                const PopupMenuItem(value: "Male", child: Text("Male")),
                const PopupMenuItem(value: "Female", child: Text("Female")),
                const PopupMenuItem(
                  value: "Non-binary",
                  child: Text("Non-binary"),
                ),
                const PopupMenuItem(
                  value: "Prefer not to say",
                  child: Text("Prefer not to say"),
                ),
              ],
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.secondaryWhite),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.primaryGray,
                    ),

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
      },
    );
  }

  GetBuilder<EditProfileInfoPageController> _buildLanguageInput() {
    return GetBuilder<EditProfileInfoPageController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Language", style: TextStyle(fontSize: 16.sp)),
            SizedBox(height: 4.h),
            PopupMenuButton<String>(
              color: AppColors.primaryWhite,
              onSelected: (value) {
                controller.setLanguage(value);
              },
              itemBuilder: (context) => [
                const PopupMenuItem(value: "English", child: Text("English")),
                // const PopupMenuItem(value: "English", child: Text("English")),
              ],
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.secondaryWhite),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.primaryGray,
                    ),

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
      },
    );
  }

  Column _buildAddressInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Address",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 4.h),
        GetBuilder<EditProfileInfoPageController>(
          builder: (controller) {
            return TextField(
              decoration: InputDecoration(
                hintText: "Address",
                hintStyle: TextStyle(color: AppColors.secondaryTextColor),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: AppColors.primaryBorderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: AppColors.primaryBorderColor),
                ),
              ),
              controller: controller.addressTEC,
            );
          },
        ),
      ],
    );
  }

  Column _buildPhoneNumberInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Phone Number",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 4.h),
        GetBuilder<EditProfileInfoPageController>(
          builder: (controller) {
            return TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Phone Number",
                hintStyle: TextStyle(color: AppColors.secondaryTextColor),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: AppColors.primaryBorderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: AppColors.primaryBorderColor),
                ),
              ),
              controller: controller.phoneNumTEC,
            );
          },
        ),
      ],
    );
  }

  Column _buildFullNameInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Full Name",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 4.h),
        GetBuilder<EditProfileInfoPageController>(
          builder: (controller) {
            return TextField(
              decoration: InputDecoration(
                hintText: "Full Name",
                hintStyle: TextStyle(color: AppColors.secondaryTextColor),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: AppColors.primaryBorderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: AppColors.primaryBorderColor),
                ),
              ),
              controller: controller.fullNameTEC,
            );
          },
        ),
      ],
    );
  }

  GetBuilder<EditProfileInfoPageController> _buildProfilePictureEdit() {
    return GetBuilder<EditProfileInfoPageController>(
      builder: (controller) {
        return Stack(
          children: [
            Center(
              child: InkWell(
                onTap: () async {
                  await controller.pickImage();
                },
                child: SizedBox(
                  width: 92.w,
                  height: 92.w,
                  child: CircleAvatar(
                    backgroundImage: controller.selectedImageFile == null
                        ? NetworkImage(controller.currentImageUrl ?? "")
                        : FileImage(controller.selectedImageFile!),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: Align(
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  AppAssets.editIcon,
                  width: 24.w,
                  height: 24.h,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
