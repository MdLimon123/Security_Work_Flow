import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_security_workforce/app/core/constants/app_assets.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/core/network/api_endpoints.dart';
import 'package:flutter_security_workforce/app/modules/home_page/presentation/controllers/home_page_controller.dart';
import 'package:flutter_security_workforce/app/routes/app_routes.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: GetBuilder<HomePageController>(
            builder: (controller) {
              return controller.fullPageLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryOrange,
                      ),
                    )
                  : Column(
                      children: [
                        GetBuilder<HomePageController>(
                          builder: (controller) {
                            return controller.profileInfoLoaded
                                ? _buildAppbarSection()
                                : Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.primaryOrange,
                                    ),
                                  );
                          },
                        ),
                        SizedBox(height: 22.h),
                        GetBuilder<HomePageController>(
                          builder: (controller) {
                            return controller.dashBoardInfoLoaded
                                ? _buildDashboard()
                                : Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.primaryOrange,
                                    ),
                                  );
                          },
                        ),
                        _buildSeeMoreOpenJobs(),
                        SizedBox(height: 12.h),
                        _buildJobListing(),
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }

  Column _buildDashboard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFirstStatRow(),
        SizedBox(height: 12.h),
        _buildSecondStatRow(),
        SizedBox(height: 12.h),
        _buildThirdStateRow(),
        SizedBox(height: 12.h),
      ],
    );
  }

  Widget _buildJobListing() {
    return Expanded(
      child: SizedBox(
        // height: Get.height / 2.5,
        child: GetBuilder<HomePageController>(
          builder: (controller) {
            return ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.r),
                  border: Border.all(color: AppColors.primaryBorderColor),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.5.w,
                    vertical: 8.5.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CachedNetworkImage(
                            imageUrl:
                                "${ApiEndpoints.getBaseUrl}${controller.openJobListModel.data?[index].jobProvider?.company?.image ?? ""}",
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error, color: AppColors.primaryRed),
                            width: 46.w,
                            height: 46.w,
                          ),

                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              "${controller.openJobListModel.data?[index].jobTitle}",
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: AppColors.secondaryNavyBlue,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 19.h),

                      Row(
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Posted In ",
                                  style: TextStyle(
                                    color: AppColors.secondaryTextColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      controller
                                          .openJobListModel
                                          .data?[index]
                                          .jobRole ??
                                      "N/A",
                                  style: TextStyle(
                                    color: AppColors.secondaryNavyBlue,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Spacer(),

                          Column(
                            children: [
                              Text(
                                "Shift Date: ",
                                style: TextStyle(
                                  color: AppColors.secondaryNavyBlue,
                                  fontSize: 12.sp,
                                ),
                              ),
                              Text(
                                "${controller.openJobListModel.data?[index].jobDate}",
                                style: TextStyle(
                                  color: AppColors.secondaryTextColor,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: 32.h),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "\$${controller.openJobListModel.data?[index].payRate}",
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  color: AppColors.primaryOrange,
                                ),
                              ),
                              Text(
                                "Per Hour",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: AppColors.secondaryNavyBlue,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 24.w),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                Get.toNamed(
                                  AppRoutes.openJobsDetailsRoute,
                                  arguments: controller
                                      .openJobListModel
                                      .data?[index]
                                      .toJson(),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                  side: BorderSide(
                                    color: AppColors.secondaryNavyBlue,
                                  ),
                                ),
                              ),
                              child: Text(
                                "Details",
                                style: TextStyle(
                                  color: AppColors.secondaryNavyBlue,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(width: 12.w),

                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                backgroundColor: AppColors.secondaryNavyBlue,
                                foregroundColor: AppColors.primaryWhite,
                              ),
                              onPressed: () async {

                                
                                Get.dialog(
                                  Material(
                                    color: Colors.black45,
                                    child: Center(
                                      child: Container(
                                        width: Get.width * 0.85,
                                        padding: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Center(
                                              child: Text(
                                                "Fit for Duty Confirmation",
                                                style: TextStyle(
                                                  fontSize: 24.sp,
                                                  color: AppColors
                                                      .secondaryNavyBlue,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),

                                            const SizedBox(height: 16),
                                            Text(
                                              "I confirm that:",
                                              style: TextStyle(
                                                fontSize: 18.sp,
                                                color:
                                                    AppColors.secondaryNavyBlue,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(height: 12),

                                            _buildBullet(
                                              "I hold the correct and current license(s) to perform this task.",
                                            ),
                                            _buildBullet(
                                              "I have no injuries preventing me from completing this or related tasks.",
                                            ),
                                            _buildBullet(
                                              "I am free from alcohol or intoxication (including medication).",
                                            ),
                                            _buildBullet(
                                              "I am sufficiently rested and not affected by illness or fatigue.",
                                            ),
                                            _buildBullet(
                                              "I understand the job requirements and am capable of performing my duties.",
                                            ),

                                            const SizedBox(height: 28),

                                            Row(
                                              children: [
                                                Expanded(
                                                  child: ElevatedButton(
                                                    onPressed: () => Get.back(),
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          AppColors.primaryRed,
                                                      foregroundColor: AppColors
                                                          .primaryWhite,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              10,
                                                            ),
                                                      ),
                                                    ),
                                                    child: const Text("Cancel"),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                
                                                Expanded(
                                                  child: ElevatedButton(
                                                    onPressed: () async {
                                                      log(
                                                        "job id ${controller.openJobListModel.data?[index].id.toString()}",
                                                      );
                                                      await controller.applyJob(
                                                        jobId:
                                                            controller
                                                                .openJobListModel
                                                                .data?[index]
                                                                .id
                                                                .toString() ??
                                                            "",
                                                      );
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: AppColors
                                                          .primaryGreen,
                                                      foregroundColor: AppColors
                                                          .primaryWhite,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              10,
                                                            ),
                                                      ),
                                                    ),
                                                    child:
                                                        controller
                                                            .applyButtonLoading
                                                        ? Center(
                                                            child: CircularProgressIndicator(
                                                              color: AppColors
                                                                  .primaryWhite,
                                                            ),
                                                          )
                                                        : Text("Confirm"),
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
                             
                             
                              },
                              child: controller.applyButtonLoading
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.primaryWhite,
                                      ),
                                    )
                                  : Text("Apply"),
                            ),
                          ),
                       
                       
                       
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              separatorBuilder: (context, index) => SizedBox(height: 16.h),
              itemCount: controller.openJobListModel.data?.length ?? 0,
            );
          },
        ),
      ),
    );
  }

  Widget _buildBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 6, right: 8),
            decoration: BoxDecoration(
              color: AppColors.primaryOrange,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  Row _buildSeeMoreOpenJobs() {
    return Row(
      children: [
        Text(
          "Open Jobs",
          style: TextStyle(
            fontSize: 20.sp,
            color: AppColors.secondaryNavyBlue,
            fontWeight: FontWeight.w500,
          ),
        ),
        Spacer(),

        // GestureDetector(
        //   onTap: () {},
        //   child: Text(
        //     "See more",
        //     style: TextStyle(fontSize: 16.sp, color: AppColors.primaryOrange),
        //   ),
        // ),
      ],
    );
  }

  Row _buildThirdStateRow() {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.primaryBorderColor),
            ),
            child: Padding(
              padding: EdgeInsets.all(10.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GetBuilder<HomePageController>(
                        builder: (controller) {
                          return Text(
                            "${controller.dashBoardInfoModel.dashboardData?.totalUpcomingJobs ?? "N/A"}",
                            style: TextStyle(
                              fontSize: 26.sp,
                              color: AppColors.secondaryNavyBlue,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        },
                      ),
                      Spacer(),
                      SvgPicture.asset(AppAssets.upComingJobIcon),
                    ],
                  ),
                  Text(
                    "Upcoming Jobs",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.secondaryTextColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 14.w),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.primaryBorderColor),
            ),
            child: Padding(
              padding: EdgeInsets.all(10.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(AppAssets.starIcon),
                          SizedBox(width: 4.w),
                          GetBuilder<HomePageController>(
                            builder: (controller) {
                              return Text(
                                controller
                                        .dashBoardInfoModel
                                        .dashboardData
                                        ?.avgRating
                                        .toString() ??
                                    "N/A",
                                style: TextStyle(
                                  fontSize: 26.sp,
                                  color: AppColors.secondaryNavyBlue,
                                  fontWeight: FontWeight.w600,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      Spacer(),
                      SvgPicture.asset(AppAssets.averageIcon),
                    ],
                  ),
                  Text(
                    "Average Rating",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.secondaryTextColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row _buildSecondStatRow() {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.primaryBorderColor),
            ),
            child: Padding(
              padding: EdgeInsets.all(10.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GetBuilder<HomePageController>(
                        builder: (controller) {
                          return Text(
                            "${controller.dashBoardInfoModel.dashboardData?.totalCompletedJobs ?? "N/A"}",
                            style: TextStyle(
                              fontSize: 26.sp,
                              color: AppColors.secondaryNavyBlue,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        },
                      ),
                      Spacer(),
                      SvgPicture.asset(AppAssets.jobCompletedIcon),
                    ],
                  ),
                  Text(
                    "Jobs Completed",
                    style: TextStyle(
                      color: AppColors.secondaryTextColor,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 14.w),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.primaryBorderColor),
            ),
            child: Padding(
              padding: EdgeInsets.all(10.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GetBuilder<HomePageController>(
                        builder: (controller) {
                          return Text(
                            "${controller.dashBoardInfoModel.dashboardData?.pastJobs ?? "N/A"}",
                            style: TextStyle(
                              fontSize: 26.sp,
                              color: AppColors.secondaryNavyBlue,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        },
                      ),
                      Spacer(),
                      SvgPicture.asset(AppAssets.pastJobIcon),
                    ],
                  ),
                  Text(
                    "Past Jobs",
                    style: TextStyle(
                      color: AppColors.secondaryTextColor,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row _buildFirstStatRow() {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.primaryBorderColor),
            ),
            child: Padding(
              padding: EdgeInsets.all(10.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GetBuilder<HomePageController>(
                        builder: (controller) {
                          return Text(
                            "\$${controller.dashBoardInfoModel.dashboardData?.totalEarningsThisWeek ?? "N/A"}",
                            style: TextStyle(
                              fontSize: 26.sp,
                              color: AppColors.secondaryNavyBlue,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        },
                      ),
                      Spacer(),
                      SvgPicture.asset(AppAssets.earningThisWeekIcon),
                    ],
                  ),
                  Text(
                    "Earnings this week",
                    style: TextStyle(
                      color: AppColors.secondaryTextColor,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 14.w),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.primaryBorderColor),
            ),
            child: Padding(
              padding: EdgeInsets.all(10.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GetBuilder<HomePageController>(
                        builder: (controller) {
                          return Text(
                            "${controller.dashBoardInfoModel.dashboardData?.totalAppliedJobs ?? "N/A"}",
                            style: TextStyle(
                              fontSize: 26.sp,
                              color: AppColors.secondaryNavyBlue,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        },
                      ),
                      Spacer(),
                      SvgPicture.asset(AppAssets.jobAppliedIcon),
                    ],
                  ),
                  Text(
                    "Jobs Applied",
                    style: TextStyle(
                      color: AppColors.secondaryTextColor,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  GetBuilder<HomePageController> _buildAppbarSection() {
    return GetBuilder<HomePageController>(
      builder: (controller) {
        return Row(
          children: [
            SizedBox(
              width: 46.w,
              height: 46.h,
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  ApiEndpoints.getBaseUrl +
                      (controller.profileInfoModel.data?.image ?? ""),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hey, Glad You’re Here",
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: AppColors.primaryBlack,
                  ),
                ),
                Text(
                  controller.profileInfoModel.data?.accountHolderName ?? "",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.secondaryTextColor,
                  ),
                ),
              ],
            ),
            Spacer(),
            IconButton(
              style: IconButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.r),
                  side: BorderSide(color: AppColors.primaryBorderColor),
                ),
              ),
              onPressed: () {
                Get.toNamed(AppRoutes.searchPageRoute);
              },
              icon: Icon(Icons.search),
            ),
            IconButton(
              style: IconButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.r),
                  side: BorderSide(color: AppColors.primaryBorderColor),
                ),
              ),
              onPressed: () {
                Get.toNamed(AppRoutes.notificationRoute);
              },
              icon: Icon(Icons.notifications_outlined),
            ),
          ],
        );
      },
    );
  }
}
