import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/modules/superannuation_details_page/presentation/controllers/superannuation_details_page_controller.dart';
import 'package:flutter_security_workforce/app/routes/app_routes.dart';
import 'package:get/get.dart';

class SuperannuationDetailsPage extends StatelessWidget {
  const SuperannuationDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Superannuation Details",
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,

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
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                _buildTaxFileNumberInput(),
                SizedBox(height: 14.h),
                _buildFundName(),
                SizedBox(height: 14.h),
                _buildFundUSIInput(),
                SizedBox(height: 14.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Superannuation Member Number",
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    SizedBox(height: 4.h),
                    GetBuilder<SuperannuationDetailsPageController>(
                      builder: (controller) {
                        return TextField(
                          controller: controller.memberNumberTEC,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                              color: AppColors.secondaryTextColor,
                            ),
                            hintText: "AS-458932",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(
                                color: AppColors.primaryBorderColor,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(
                                color: AppColors.primaryBorderColor,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 14.h),
                _buildDOBInput(),
                SizedBox(height: 40.h),
                _buildSaveAndUpdateButton(),
                SizedBox(height: 18.h),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: AppColors.secondaryNavyBlue,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox _buildSaveAndUpdateButton() {
    return SizedBox(
      width: double.infinity,

      child: GetBuilder<SuperannuationDetailsPageController>(
        builder: (controller) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondaryNavyBlue,
              foregroundColor: AppColors.primaryWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
            onPressed: () async {
              await controller.saveAndUpdate();
            },
            child: controller.isLoading
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

  Column _buildDOBInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Date of Birth", style: TextStyle(fontSize: 16.sp)),
        SizedBox(height: 4.h),
        GetBuilder<SuperannuationDetailsPageController>(
          builder: (controller) {
            return TextField(
              controller: controller.dateOfBirthTEC,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                hintStyle: TextStyle(color: AppColors.secondaryTextColor),
                hintText: "2025-05-05",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: AppColors.primaryBorderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: AppColors.primaryBorderColor),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Column _buildFundUSIInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Superannuation Fund USI", style: TextStyle(fontSize: 16.sp)),
        SizedBox(height: 4.h),
        GetBuilder<SuperannuationDetailsPageController>(
          builder: (controller) {
            return TextField(
              controller: controller.fundUSITEC,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintStyle: TextStyle(color: AppColors.secondaryTextColor),
                hintText: "123456789001",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: AppColors.primaryBorderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: AppColors.primaryBorderColor),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Column _buildFundName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Superannuation Fund Name", style: TextStyle(fontSize: 16.sp)),
        SizedBox(height: 4.h),
        GetBuilder<SuperannuationDetailsPageController>(
          builder: (controller) {
            return TextField(
              controller: controller.fundNameTEC,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintStyle: TextStyle(color: AppColors.secondaryTextColor),
                hintText: "AustralianSuper",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: AppColors.primaryBorderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: AppColors.primaryBorderColor),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Column _buildTaxFileNumberInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Tax File Number", style: TextStyle(fontSize: 16.sp)),
        SizedBox(height: 4.h),
        GetBuilder<SuperannuationDetailsPageController>(
          builder: (controller) {
            return TextField(
              controller: controller.taxFileNumTEC,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintStyle: TextStyle(color: AppColors.secondaryTextColor),
                hintText: "1233222",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: AppColors.primaryBorderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: AppColors.primaryBorderColor),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
