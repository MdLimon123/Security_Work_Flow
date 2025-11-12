import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_security_workforce/app/core/constants/app_assets.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_outlined),
          ),
        ],
        centerTitle: true,
        title: Text(
          "Notifications",
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                SizedBox(height: 39.h),
                _buildNotificationList(notificationTitle: "Today"),
                _buildNotificationList(notificationTitle: "Yesterday"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _buildNotificationList({required String notificationTitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notificationTitle,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.secondaryTextColor,
              ),
            ),

            SizedBox(height: 16.h),

            Row(
              children: [
                SvgPicture.asset(
                  AppAssets.circularGreenTickIcon,
                  width: 48.w,
                  height: 48.h,
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Job Assigned",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "You’ve been selected for a new job,Please review and sign the contract.",
                        style: TextStyle(color: AppColors.secondaryTextColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(color: AppColors.primaryBorderColor),

            SizedBox(height: 16.h),

            Row(
              children: [
                SvgPicture.asset(
                  AppAssets.circularNewIcon,
                  width: 48.w,
                  height: 48.h,
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "New Job Available",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Recently",
                        style: TextStyle(color: AppColors.secondaryTextColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(color: AppColors.primaryBorderColor),

            SizedBox(height: 16.h),

            Row(
              children: [
                SvgPicture.asset(
                  AppAssets.circularCancelIcon,
                  width: 48.w,
                  height: 48.h,
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Your Job Applied Has Been Cancelled",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "19 Jun 2023",
                        style: TextStyle(color: AppColors.secondaryTextColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 24.h),
            Divider(color: AppColors.primaryBorderColor, thickness: 4.sp),
          ],
        ),
      ],
    );
  }
}
