import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_security_workforce/app/core/constants/app_assets.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/modules/wages_to_be_paid_page/presentation/controllers/wages_to_be_paid_page_controller.dart';
import 'package:flutter_security_workforce/app/routes/app_routes.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class WagesToBePaidPage extends StatelessWidget {
  const WagesToBePaidPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Bank Account Details",
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
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                SizedBox(height: 26.h),
                _buildBankNameInput(),
                SizedBox(height: 12.h),
                _buildAccountHolderNameInput(),
                SizedBox(height: 12.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "BSB/Account Number",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    _buildAccountNumberInput(),
                    SizedBox(height: 44.h),
                    _buildSaveAndUpdateButton(),
                    SizedBox(height: 18.h),
                    _buildCancelButton(),
                    SizedBox(height: 18.h),
                    Row(
                      children: [
                        SvgPicture.asset(AppAssets.cautionIcon),
                        SizedBox(width: 8.w),
                        Text(
                          "For your wages to be paid.",
                          style: TextStyle(color: AppColors.secondaryTextColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Center _buildCancelButton() {
    return Center(
      child: InkWell(
        onTap: () {},
        child: Text(
          "Cancel",
          style: TextStyle(
            color: AppColors.secondaryNavyBlue,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  SizedBox _buildSaveAndUpdateButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondaryNavyBlue,
          foregroundColor: AppColors.primaryWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        child: Text(
          "Save & Update",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  GetBuilder<WagesToBePaidPageController> _buildAccountNumberInput() {
    return GetBuilder<WagesToBePaidPageController>(
      builder: (controller) {
        return TextField(
          keyboardType: TextInputType.number,
          controller: controller.accountNumberTEC,
          decoration: InputDecoration(
            hintText: "123456789",
            hintStyle: TextStyle(color: AppColors.secondaryTextColor),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AppColors.primaryBorderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AppColors.primaryBorderColor),
            ),
          ),
        );
      },
    );
  }

  Column _buildAccountHolderNameInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Account Holder Name",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 4.h),
        GetBuilder<WagesToBePaidPageController>(
          builder: (controller) {
            return TextField(
              controller: controller.accountHolderNameTEC,
              decoration: InputDecoration(
                hintText: "John Smith",
                hintStyle: TextStyle(color: AppColors.secondaryTextColor),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: AppColors.primaryBorderColor),
                ),
                enabledBorder: OutlineInputBorder(
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

  Column _buildBankNameInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Bank Name",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 4.h),
        GetBuilder<WagesToBePaidPageController>(
          builder: (controller) {
            return TextField(
              controller: controller.bankNameTEC,
              decoration: InputDecoration(
                hintText: "Commonwealth Bank",
                hintStyle: TextStyle(color: AppColors.secondaryTextColor),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: AppColors.primaryBorderColor),
                ),
                enabledBorder: OutlineInputBorder(
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
