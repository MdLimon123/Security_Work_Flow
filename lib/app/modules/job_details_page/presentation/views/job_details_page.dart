import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_security_workforce/app/core/constants/app_assets.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/core/constants/formate_date.dart';
import 'package:flutter_security_workforce/app/core/constants/formate_time.dart';
import 'package:flutter_security_workforce/app/modules/home_page/presentation/controllers/home_page_controller.dart';
import 'package:flutter_security_workforce/app/modules/my_jobs_page/presentation/controllers/my_jobs_page_controller.dart';
import 'package:flutter_security_workforce/app/core/data/models/job_details_model.dart';
import 'package:flutter_security_workforce/app/routes/app_routes.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class JobDetailsPage extends StatelessWidget {
  JobDetailsPage({super.key});

  final JobDetailsModel jobDetailsModel = Get.arguments;

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
            padding: EdgeInsets.symmetric(horizontal: 20.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 32.h),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        jobDetailsModel.jobDetails?.jobTitle ?? "",
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
                      onTap: () async {
                        String googleMapsUrl =
                            "https://www.google.com/maps?q=${jobDetailsModel.jobDetails?.latitude},${jobDetailsModel.jobDetails?.longitude}";
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
                      " ${jobDetailsModel.jobDetails?.address}",
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
          child: GetBuilder<HomePageController>(
            init: Get.find<HomePageController>(),
            builder: (controller) => OutlinedButton(
              onPressed: () {
                controller.createChatRoom(
                  userId: jobDetailsModel.jobDetails!.jobProvider!.company!.id
                      .toString(),
                );
              },
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
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: GetBuilder<MyJobsPageController>(
            builder: (controller) {
              final jobId = jobDetailsModel.id.toString();
              final isLoading = controller.jobLoading[jobId] ?? false;

              return ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () async {
                        await controller.endJob(jobId: jobId);
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondaryNavyBlue,
                  foregroundColor: AppColors.primaryWhite,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: isLoading
                    ? SizedBox(
                        height: 20.h,
                        width: 20.w,
                        child: CircularProgressIndicator(
                          color: AppColors.primaryWhite,
                          strokeWidth: 2,
                        ),
                      )
                    : Text("Finish Shift", style: TextStyle(fontSize: 16.sp)),
              );
            },
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
          "Job Information",
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
                      jobDetailsModel.jobDetails?.jobTitle ?? "",
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
                      "Job date :",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    Text(
                      formatDate(jobDetailsModel.jobDetails?.jobDate),
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
                      formatUtcToLocal(
                        jobDetailsModel.jobDetails?.jobDate,
                        jobDetailsModel.jobDetails?.startTime,
                      ),
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
                      formatUtcToLocal(
                        jobDetailsModel.jobDetails?.jobDate,
                        jobDetailsModel.jobDetails?.endTime,
                      ),
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
                      "${jobDetailsModel.jobDetails?.jobDuration} Hours",
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
                      "\$${jobDetailsModel.jobDetails?.payRate}/hour",
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
              "${jobDetailsModel.jobDetails?.startTime}",
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
              "${jobDetailsModel.jobDetails?.endTime}",
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
                "${jobDetailsModel.operativeTrackers}",
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
