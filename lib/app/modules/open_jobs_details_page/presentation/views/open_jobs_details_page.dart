import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_security_workforce/app/core/constants/app_assets.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenJobsDetailsPage extends StatelessWidget {
  const OpenJobsDetailsPage({super.key});

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
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeaderSection(),
                SizedBox(height: 24.h),
                _buildStatus(),
                SizedBox(height: 24.h),
                _buildJobDescriptions(),
                SizedBox(height: 32.h),
                _buildDutyInformation(),
                SizedBox(height: 32.h),
                _buildJobLocation(),
                SizedBox(height: 32.h),
                _buildCompanyRating(),
                SizedBox(height: 40.h),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.secondaryNavyBlue,
                          side: BorderSide(color: AppColors.secondaryNavyBlue),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        onPressed: () {},
                        child: Text("Message"),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondaryNavyBlue,
                          foregroundColor: AppColors.primaryWhite,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        onPressed: () {},
                        child: Text("Apply"),
                      ),
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

  Column _buildCompanyRating() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Company Rating",
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 24.h),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.primaryCream,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "4.0",
                  style: TextStyle(
                    fontSize: 40.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: AppColors.primaryYellow,
                      size: 18.sp,
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.star,
                      color: AppColors.primaryYellow,
                      size: 18.sp,
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.star,
                      color: AppColors.primaryYellow,
                      size: 18.sp,
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.star,
                      color: AppColors.primaryYellow,
                      size: 18.sp,
                    ),
                    SizedBox(width: 4.w),
                    Icon(Icons.star, color: AppColors.primaryGray, size: 18.sp),
                  ],
                ),
                Text("52 Reviews"),
              ],
            ),
          ),
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Text("2.0", style: TextStyle(fontSize: 16.sp)),
            SizedBox(width: 4.w),
            Icon(Icons.star, color: AppColors.primaryYellow, size: 16.sp),
            SizedBox(width: 8.w),
            Text("Communication", style: TextStyle(fontSize: 20.sp)),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Text("4.0", style: TextStyle(fontSize: 16.sp)),
            SizedBox(width: 4.w),
            Icon(Icons.star, color: AppColors.primaryYellow, size: 16.sp),
            SizedBox(width: 8.w),
            Text("Payment reliability ", style: TextStyle(fontSize: 20.sp)),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Text("5.0", style: TextStyle(fontSize: 16.sp)),
            SizedBox(width: 4.w),
            Icon(Icons.star, color: AppColors.primaryYellow, size: 16.sp),
            SizedBox(width: 8.w),
            Text("Pay rates", style: TextStyle(fontSize: 20.sp)),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Text("3.0", style: TextStyle(fontSize: 16.sp)),
            SizedBox(width: 4.w),
            Icon(Icons.star, color: AppColors.primaryYellow, size: 16.sp),
            SizedBox(width: 8.w),
            Text("Professionalism", style: TextStyle(fontSize: 20.sp)),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Text("1.0", style: TextStyle(fontSize: 16.sp)),
            SizedBox(width: 4.w),
            Icon(Icons.star, color: AppColors.primaryYellow, size: 16.sp),
            SizedBox(width: 8.w),
            Text("Job Support", style: TextStyle(fontSize: 20.sp)),
          ],
        ),
      ],
    );
  }

  Column _buildJobLocation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Job Location",
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 19.h),

        Row(
          children: [
            SvgPicture.asset(AppAssets.doubleLocationIcon),
            SizedBox(width: 8.w),
            Text(
              "Join Venture AI (JVAI)",
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.secondaryTextColor,
              ),
            ),
          ],
        ),

        SizedBox(height: 24.h),

        Center(
          child: SizedBox(
            width: Get.width / 2,
            child: OutlinedButton(
              onPressed: () async {
                String googleMapsUrl =
                    "https://www.google.com/maps?q=${23.780860837403864},${90.40757911256006}";
                if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
                  await launchUrl(Uri.parse(googleMapsUrl));
                } else {
                  Get.snackbar(
                    "Something went wrong",
                    "Location error",
                    backgroundColor: AppColors.primaryRed,
                  );
                }
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.secondaryNavyBlue,
                side: BorderSide(color: AppColors.secondaryNavyBlue),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text("View On Map"),
            ),
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
            padding: EdgeInsets.symmetric(vertical: 11.5.h, horizontal: 20.w),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Job Role :",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    Text(
                      "Night Security Guard",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.secondaryTextColor,
                        fontWeight: FontWeight.w500,
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
                        fontWeight: FontWeight.w500,
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
                        fontWeight: FontWeight.w500,
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
                        fontWeight: FontWeight.w500,
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
                        fontWeight: FontWeight.w500,
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

  Column _buildJobDescriptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Job Descriptions",
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
        ),
        Text(
          "SecureOne Protection Services is seeking a professional Night Security Guard to ensure the safety of a corporate office building during after-hours operations. The ideal candidate will be punctual, observant, and confident in handling routine and emergency situations.",
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.secondaryTextColor,
          ),
        ),
      ],
    );
  }

  Row _buildStatus() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Salary",
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.secondaryTextColor,
              ),
            ),
            Text(
              "\$13/hour",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.secondaryNavyBlue,
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Duration",
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.secondaryTextColor,
              ),
            ),
            Text(
              "10 Hours",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.secondaryNavyBlue,
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Expiry Date",
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.secondaryTextColor,
              ),
            ),
            Text(
              "26 Sep, 2025",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.secondaryNavyBlue,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Row _buildHeaderSection() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Security Company LTD",
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.secondaryTextColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "Need An Experienced Night Security Guard",
                style: TextStyle(
                  fontSize: 20.sp,
                  color: AppColors.secondaryNavyBlue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Image.asset(
          AppAssets.securityIcon,
          // width: 70.w,
          // height: 70.h,
          fit: BoxFit.contain,
        ),
      ],
    );
  }
}
