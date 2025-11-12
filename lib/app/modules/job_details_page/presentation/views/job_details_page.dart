import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_security_workforce/app/core/constants/app_assets.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class JobDetailsPage extends StatelessWidget {
  const JobDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Job Details",
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_outlined),
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 32.h),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Security Company LTD",
                        style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    // SvgPicture.asset(AppAssets.averageIcon,width: 20,),
                    Image.asset(
                      AppAssets.securityIcon,
                      width: 70.w,
                      height: 70.h,
                    ),
                  ],
                ),

                SizedBox(height: 24.h),

                _buildCheckInOutStatus(),

                SizedBox(height: 24.h),

                _buildDutyInformation(),

                SizedBox(height: 24.h),

                Row(
                  children: [
                    Text("Job Locations", style: TextStyle(fontSize: 20.sp)),
                    Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: SvgPicture.asset(AppAssets.mapViewButtonImg),
                    ),
                    SizedBox(height: 17.h),
                  ],
                ),

                SizedBox(height: 19.5.h),

                Row(
                  children: [
                    SvgPicture.asset(
                      AppAssets.doubleLocationIcon,
                      width: 24.w,
                      height: 24.h,
                      fit: BoxFit.cover,
                    ),

                    SizedBox(width: 8.w),

                    Text(
                      " 28 King Street, Melbourne CBD, VIC 3000",
                      style: TextStyle(
                        color: AppColors.secondaryTextColor,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 32.h),

                _buildMessageAndFinishSiftButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _buildMessageAndFinishSiftButton() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.secondaryNavyBlue),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              "Message",
              style: TextStyle(color: AppColors.secondaryNavyBlue),
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondaryNavyBlue,
              foregroundColor: AppColors.primaryWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text("Finish Shift"),
          ),
        ),
      ],
    );
  }

  Column _buildDutyInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Duty Information",
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
        ),

        SizedBox(height: 12.h),

        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(23.r),
            border: Border.all(color: AppColors.primaryBorderColor),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 11.5.h),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Job Role : ",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    Text(
                      "Night Security Guard",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.secondaryTextColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 11.5.h),
                Row(
                  children: [
                    Text(
                      "Duty date :",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    Text(
                      "25 Sep, 2025",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.secondaryTextColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 11.5.h),
                Row(
                  children: [
                    Text(
                      "Start Time :",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    Text(
                      "18:30",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.secondaryTextColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 11.5.h),
                Row(
                  children: [
                    Text(
                      "End Time :",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    Text(
                      "07:30",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.secondaryTextColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 11.5.h),
                Row(
                  children: [
                    Text(
                      "Duration :",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    Text(
                      "10 Hours",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.secondaryTextColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 11.5.h),
                Row(
                  children: [
                    Text(
                      "Salary :",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    Text(
                      "\$13/hour",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.secondaryTextColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Row _buildCheckInOutStatus() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Check-In",
              style: TextStyle(color: AppColors.secondaryTextColor),
            ),
            Text(
              "10:30 pm",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Check-Out",
              style: TextStyle(color: AppColors.secondaryTextColor),
            ),
            Text(
              "--- ",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Status",
              style: TextStyle(color: AppColors.secondaryTextColor),
            ),
            Chip(
              shape: RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.circular(8.r),
              ),
              label: Text(
                "On duty",
                style: TextStyle(color: AppColors.primaryGreen),
              ),
              color: WidgetStatePropertyAll(
                AppColors.primaryGreen.withValues(alpha: .2),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
