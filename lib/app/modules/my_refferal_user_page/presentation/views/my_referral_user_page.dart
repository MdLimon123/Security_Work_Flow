import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';

class MyReferralUserPage extends StatelessWidget {
  const MyReferralUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Referral user",
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
        child: ListView.separated(
          itemBuilder: (context, index) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: AppColors.primaryBorderColor),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
              child: Column(
                children: [
                  _buildInfoElementRow(
                    leftString: "User Name :",
                    rightString: "Jhone",
                  ),
                  SizedBox(height: 8.h),
                  _buildInfoElementRow(
                    leftString: "Email :",
                    rightString: "name@gmail.com",
                  ),
                  SizedBox(height: 8.h),
                  _buildInfoElementRow(
                    leftString: "Address : ",
                    rightString: "Uk",
                  ),
                  SizedBox(height: 8.h),
                  _buildInfoElementRow(
                    leftString: "Join Date : ",
                    rightString: "22 Oct 2025",
                  ),
                  SizedBox(height: 8.h),
                  _buildInfoElementRow(
                    leftString: "Subscribed : ",
                    rightString: "Yes",
                  ),
                  SizedBox(height: 8.h),
                  _buildInfoElementRow(
                    leftString: "Purchase Date :",
                    rightString: "22 Oct 2025",
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Text(
                        "Status :",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.secondaryTextColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryBlue.withValues(
                            alpha: .15,
                          ),
                          foregroundColor: AppColors.primaryBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(8.r),
                          ),
                        ),
                        onPressed: () {},
                        child: Text("Earned"),
                      ),
                    ],
                  ),

                  SizedBox(height: 24.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(16.r),
                        ),
                        backgroundColor: AppColors.secondaryNavyBlue,
                        foregroundColor: AppColors.primaryWhite,
                      ),
                      onPressed: () {
                        Get.toNamed(AppRoutes.messageRoute);
                      },
                      child: Text("Message"),
                    ),
                  ),
                ],
              ),
            ),
          ),
          separatorBuilder: (context, index) => SizedBox(height: 24.h),
          itemCount: 20,
        ),
      ),
    );
  }

  Row _buildInfoElementRow({
    required String leftString,
    required String rightString,
  }) {
    return Row(
      children: [
        Text(
          leftString,
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.secondaryTextColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        Spacer(),
        Text(
          rightString,
          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
