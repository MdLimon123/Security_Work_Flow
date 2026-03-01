import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_security_workforce/app/core/constants/app_assets.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/core/constants/formate_date.dart';
import 'package:flutter_security_workforce/app/core/constants/formate_time.dart';
import 'package:flutter_security_workforce/app/core/data/models/job_details_model.dart';
import 'package:flutter_security_workforce/app/modules/my_jobs_page/presentation/controllers/my_jobs_page_controller.dart';
import 'package:flutter_security_workforce/app/routes/app_routes.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class MyJobsPage extends StatelessWidget {
  const MyJobsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "My Jobs",
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: IconButton(
              onPressed: () {
                Get.toNamed(AppRoutes.notificationRoute);
              },
              icon: Icon(Icons.notifications_outlined),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: GetBuilder<MyJobsPageController>(
          init: MyJobsPageController(),
          builder: (controller) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  SizedBox(height: 22.h),

                  _buildMyJobsSelection(),

                  //
                  // SizedBox(height: 33.h),
                  // _buildJobCardList(),
                  SizedBox(height: 29.h),

                  Expanded(
                    child: controller.selectedIndex == 0
                        ? _buildUpcomingJobCardList()
                        : controller.selectedIndex == 1
                        ? _buildJobInProgressCardList()
                        : _buildCompletedJobCard(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  GetBuilder<MyJobsPageController> _buildMyJobsSelection() {
    return GetBuilder<MyJobsPageController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => controller.updateIndex(0),
                    child: Center(
                      child: Text(
                        "Upcoming Jobs",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: controller.selectedIndex == 0
                              ? AppColors.primaryOrange
                              : AppColors.primaryBlack,
                          fontWeight: FontWeight.w600,
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () => controller.updateIndex(1),
                    child: Center(
                      child: Text(
                        "Jobs in Progress",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: controller.selectedIndex == 1
                              ? AppColors.primaryOrange
                              : AppColors.primaryBlack,
                          fontWeight: FontWeight.w600,
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () => controller.updateIndex(2),
                    child: Center(
                      child: Text(
                        "Completed Jobs",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: controller.selectedIndex == 2
                              ? AppColors.primaryOrange
                              : AppColors.primaryBlack,
                          fontWeight: FontWeight.w600,
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      controller.updateIndex(0);
                    },
                    child: Divider(
                      color: controller.selectedIndex == 0
                          ? AppColors.primaryOrange
                          : AppColors.primaryGray,
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      controller.updateIndex(1);
                    },
                    child: Divider(
                      color: controller.selectedIndex != 0
                          ? AppColors.primaryOrange
                          : AppColors.primaryGray,
                    ),
                  ),
                ),

                Expanded(
                  child: InkWell(
                    onTap: () {
                      controller.updateIndex(2);
                    },
                    child: Divider(
                      color: controller.selectedIndex != 0
                          ? AppColors.primaryOrange
                          : AppColors.primaryGray,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Expanded _buildUpcomingJobCardList() {
    return Expanded(
      child: GetBuilder<MyJobsPageController>(
        builder: (controller) {
          return controller.pageLoading3
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryOrange,
                  ),
                )
              : ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: AppColors.primaryGray),
                    ),

                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 16.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Job ID: ",
                                        style: TextStyle(
                                          color: AppColors.primaryBlack,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            "#${controller.upcomingJobModel.results?.myJobs[index].id}",
                                        style: TextStyle(
                                          color: AppColors.primaryOrange,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              Spacer(),

                              Chip(
                                label: Text(
                                  (controller
                                                  .upcomingJobModel
                                                  .results
                                                  ?.myJobs[index]
                                                  .jobDetails
                                                  .status
                                                  .toLowerCase() ==
                                              "untasked")
                                      ? "Upcoming"
                                      : controller
                                              .upcomingJobModel
                                              .results
                                              ?.myJobs[index]
                                              .jobDetails
                                              .status ??
                                          "N/A",
                                  style: TextStyle(
                                    color: AppColors.primaryBlue,
                                  ),
                                ),
                                color: WidgetStatePropertyAll(
                                  AppColors.primaryBlue.withValues(alpha: .2),
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              Expanded(child: Text("Job Role : ")),

                              Spacer(),

                              Expanded(
                                child: Text(
                                  "${controller.upcomingJobModel.results?.myJobs[index].jobDetails.jobTitle}",
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 12.h),

                          Row(
                            children: [
                              Expanded(child: Text("Company Name : ")),
                              Spacer(),
                              Expanded(
                                child: Text(
                                  "${controller.upcomingJobModel.results?.myJobs[index].jobDetails.jobProvider.company.firstName}",
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 12.h),

                          Row(
                            children: [
                              Expanded(child: Text("Date:")),
                              Spacer(),
                              Expanded(
                                child: Text(
                                  formatDate(
                                    controller
                                        .upcomingJobModel
                                        .results
                                        ?.myJobs[index]
                                        .jobDetails
                                        .jobDate,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            children: [
                              Expanded(child: Text("Start Time:")),
                              Spacer(),
                              Expanded(
                                child: Text(
                                  formatUtcToLocal(
                                    controller
                                            .upcomingJobModel
                                            .results
                                            ?.myJobs[index]
                                            .jobDetails
                                            .jobDate ??
                                        "",
                                    controller
                                            .upcomingJobModel
                                            .results
                                            ?.myJobs[index]
                                            .jobDetails
                                            .startTime ??
                                        "",
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            children: [
                              Expanded(child: Text("End Time:")),
                              Spacer(),
                              Expanded(
                                child: Text(
                                  formatUtcToLocal(
                                    controller
                                            .upcomingJobModel
                                            .results
                                            ?.myJobs[index]
                                            .jobDetails
                                            .jobDate ??
                                        "",
                                    controller
                                            .upcomingJobModel
                                            .results
                                            ?.myJobs[index]
                                            .jobDetails
                                            .endTime ??
                                        "",
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 12.h),

                          Row(
                            children: [
                              Expanded(child: Text("Duration : ")),
                              Spacer(),
                              Expanded(
                                child: Text(
                                  "${controller.upcomingJobModel.results?.myJobs[index].jobDetails.jobDuration} Hours",
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 12.h),

                          Row(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: AppColors.primaryOrange,
                                  ),

                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Location"),
                                      Text(
                                        "${controller.upcomingJobModel.results!.myJobs[index].jobDetails.address}",
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () async {
                                  String googleMapsUrl =
                                      "https://www.google.com/maps?q=${controller.upcomingJobModel.results?.myJobs?[index].jobDetails?.latitude},${controller.upcomingJobModel.results?.myJobs?[index].jobDetails?.longitude}";
                                  if (await canLaunchUrl(
                                    Uri.parse(googleMapsUrl),
                                  )) {
                                    await launchUrl(Uri.parse(googleMapsUrl));
                                  } else {
                                    Get.snackbar(
                                      "Something went wrong",
                                      "Location error",
                                      backgroundColor: AppColors.primaryRed,
                                    );
                                  }
                                },
                                child: SvgPicture.asset(
                                  AppAssets.mapViewButtonImg,
                                  width: 93.w,
                                  height: 29.h,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 34.h),

                          // Row(
                          //   children: [
                          //     Expanded(
                          //       child: OutlinedButton(
                          //         style: OutlinedButton.styleFrom(
                          //           shape: RoundedRectangleBorder(
                          //             borderRadius: BorderRadius.circular(12.r),
                          //             side: BorderSide(
                          //               color: AppColors.secondaryNavyBlue,
                          //             ),
                          //           ),
                          //         ),
                          //         onPressed: () {
                          //           Get.toNamed(
                          //             AppRoutes.jobDetailsRoute,
                          //             arguments: JobDetailsModel.fromJson(
                          //               controller
                          //                   .jobHistoryListModel
                          //                   .results
                          //                   ?.myJobs?[index]
                          //                   .toJson(),
                          //             ),
                          //           );
                          //         },
                          //         child: Text(
                          //           "Details",
                          //           style: TextStyle(
                          //             fontSize: 16.sp,
                          //             color: AppColors.secondaryNavyBlue,
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ),
                  separatorBuilder: (context, index) => SizedBox(height: 16.h),
                  itemCount:
                      controller.upcomingJobModel.results?.myJobs.length ?? 0,
                );
        },
      ),
    );
  }

  Expanded _buildCompletedJobCard() {
    return Expanded(
      child: GetBuilder<MyJobsPageController>(
        builder: (controller) {
          return controller.pageLoading2
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryOrange,
                  ),
                )
              : ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: AppColors.primaryGray),
                    ),

                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 16.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Job ID: ",
                                        style: TextStyle(
                                          color: AppColors.primaryBlack,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            "#${controller.jobHistoryListModel.results?.myJobs?[index].id}",
                                        style: TextStyle(
                                          color: AppColors.primaryOrange,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              Spacer(),

                              Chip(
                                label: Text(
                                  "Complete",
                                  style: TextStyle(
                                    color: AppColors.primaryBlue,
                                  ),
                                ),
                                color: WidgetStatePropertyAll(
                                  AppColors.primaryBlue.withValues(alpha: .2),
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              Expanded(child: Text("Job Role : ")),

                              Spacer(),

                              Expanded(
                                child: Text(
                                  "${controller.jobHistoryListModel.results?.myJobs?[index].jobDetails?.jobTitle}",
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 12.h),

                          Row(
                            children: [
                              Expanded(child: Text("Company Name : ")),
                              Spacer(),
                              Expanded(
                                child: Text(
                                  "${controller.jobHistoryListModel.results?.myJobs?[index].jobDetails?.jobProvider?.company?.firstName}",
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 12.h),

                          Row(
                            children: [
                              Expanded(child: Text("Date:")),
                              Spacer(),
                              Expanded(
                                child: Text(
                                  formatDate(
                                    controller
                                        .jobHistoryListModel
                                        .results
                                        ?.myJobs?[index]
                                        .jobDetails
                                        ?.jobDate,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              Expanded(child: Text("Start Time:")),
                              Spacer(),
                              Expanded(
                                child: Text(
                                  formatUtcToLocal(
                                    controller
                                        .jobHistoryListModel
                                        .results
                                        ?.myJobs?[index]
                                        .jobDetails
                                        ?.jobDate,
                                    controller
                                        .jobHistoryListModel
                                        .results
                                        ?.myJobs?[index]
                                        .jobDetails
                                        ?.startTime,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            children: [
                              Expanded(child: Text("End Time:")),
                              Spacer(),
                              Expanded(
                                child: Text(
                                  formatUtcToLocal(
                                    controller
                                        .jobHistoryListModel
                                        .results
                                        ?.myJobs?[index]
                                        .jobDetails
                                        ?.jobDate,
                                    controller
                                        .jobHistoryListModel
                                        .results
                                        ?.myJobs?[index]
                                        .jobDetails
                                        ?.endTime,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 12.h),

                          Row(
                            children: [
                              Expanded(child: Text("Duration : ")),
                              Spacer(),
                              Expanded(
                                child: Text(
                                  "${controller.jobHistoryListModel.results?.myJobs?[index].jobDetails?.jobDuration} Hours",
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 12.h),

                          Row(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: AppColors.primaryOrange,
                                  ),

                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Location"),
                                      Text(
                                        "${controller.jobHistoryListModel.results?.myJobs?[index].jobDetails?.address}",
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () async {
                                  String googleMapsUrl =
                                      "https://www.google.com/maps?q=${controller.jobHistoryListModel.results?.myJobs?[index].jobDetails?.latitude},${controller.jobHistoryListModel.results?.myJobs?[index].jobDetails?.longitude}";
                                  if (await canLaunchUrl(
                                    Uri.parse(googleMapsUrl),
                                  )) {
                                    await launchUrl(Uri.parse(googleMapsUrl));
                                  } else {
                                    Get.snackbar(
                                      "Something went wrong",
                                      "Location error",
                                      backgroundColor: AppColors.primaryRed,
                                    );
                                  }
                                },
                                child: SvgPicture.asset(
                                  AppAssets.mapViewButtonImg,
                                  width: 93.w,
                                  height: 29.h,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 34.h),

                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                      side: BorderSide(
                                        color: AppColors.secondaryNavyBlue,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    Get.toNamed(
                                      AppRoutes.jobDetailsRoute,
                                      arguments: JobDetailsModel.fromJson(
                                        controller
                                            .jobHistoryListModel
                                            .results
                                            ?.myJobs?[index]
                                            .toJson(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Details",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: AppColors.secondaryNavyBlue,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  separatorBuilder: (context, index) => SizedBox(height: 16.h),
                  itemCount:
                      controller.jobHistoryListModel.results?.myJobs?.length ??
                      0,
                );
        },
      ),
    );
  }

  Expanded _buildJobInProgressCardList() {
    return Expanded(
      child: GetBuilder<MyJobsPageController>(
        builder: (controller) {
          return controller.pageLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryOrange,
                  ),
                )
              : ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: AppColors.primaryGray),
                    ),

                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 16.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Job ID: ",
                                        style: TextStyle(
                                          color: AppColors.primaryBlack,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            "#${controller.myJobListModel.results?.myJobs?[index].id ?? ""}",
                                        style: TextStyle(
                                          color: AppColors.primaryOrange,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              Spacer(),

                              // Chip(
                              //   label: Text(
                              //     "On duty",
                              //     style: TextStyle(
                              //       color: AppColors.primaryGreen,
                              //     ),
                              //   ),
                              //
                              //   color: WidgetStatePropertyAll(
                              //     AppColors.primaryGreen.withValues(alpha: .2),
                              //   ),
                              // ),
                            ],
                          ),

                          Row(
                            children: [
                              Expanded(child: Text("Job Role : ")),

                              Spacer(),

                              Expanded(
                                child: Text(
                                  controller
                                          .myJobListModel
                                          .results
                                          ?.myJobs?[index]
                                          .jobDetails
                                          ?.jobTitle ??
                                      "",
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 12.h),

                          Row(
                            children: [
                              Expanded(child: Text("Company Name : ")),
                              Spacer(),
                              Expanded(
                                child: Text(
                                  "${controller.myJobListModel.results?.myJobs?[index].jobDetails?.jobProvider?.company?.firstName}",
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 12.h),

                          Row(
                            children: [
                              Expanded(child: Text("Date:")),
                              Spacer(),
                              Expanded(
                                child: Text(
                                  controller
                                          .myJobListModel
                                          .results
                                          ?.myJobs?[index]
                                          .jobDetails
                                          ?.jobDate ??
                                      "",
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),

                          Row(
                            children: [
                              Expanded(child: Text("Start Time : ")),
                              Spacer(),
                              Expanded(
                                child: Text(
                                  formatUtcToLocal(
                                    controller
                                        .myJobListModel
                                        .results
                                        ?.myJobs?[index]
                                        .jobDetails
                                        ?.jobDate,
                                    controller
                                        .myJobListModel
                                        .results
                                        ?.myJobs?[index]
                                        .jobDetails
                                        ?.startTime,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 12.h),

                          Row(
                            children: [
                              Expanded(child: Text("End Time : ")),
                              Spacer(),
                              Expanded(
                                child: Text(
                                  formatUtcToLocal(
                                    controller
                                        .myJobListModel
                                        .results
                                        ?.myJobs?[index]
                                        .jobDetails
                                        ?.jobDate,
                                    controller
                                        .myJobListModel
                                        .results
                                        ?.myJobs?[index]
                                        .jobDetails
                                        ?.endTime,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 12.h),

                          Row(
                            children: [
                              Expanded(child: Text("Duration : ")),
                              Spacer(),
                              Expanded(
                                child: Text(
                                  "${controller.myJobListModel.results?.myJobs?[index].jobDetails?.jobDuration}",
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 12.h),

                          Row(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: AppColors.primaryOrange,
                                  ),

                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Location"),
                                      Text(
                                        "${controller.myJobListModel.results?.myJobs?[index].jobDetails?.address}",
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () async {
                                  String googleMapsUrl =
                                      "https://www.google.com/maps?q=${controller.myJobListModel.results?.myJobs?[index].jobDetails?.latitude},${controller.myJobListModel.results?.myJobs?[index].jobDetails?.longitude}";
                                  if (await canLaunchUrl(
                                    Uri.parse(googleMapsUrl),
                                  )) {
                                    await launchUrl(Uri.parse(googleMapsUrl));
                                  } else {
                                    Get.snackbar(
                                      "Something went wrong",
                                      "Location error",
                                      backgroundColor: AppColors.primaryRed,
                                    );
                                  }
                                },
                                child: SvgPicture.asset(
                                  AppAssets.mapViewButtonImg,
                                  width: 93.w,
                                  height: 29.h,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 34.h),

                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                      side: BorderSide(
                                        color: AppColors.secondaryNavyBlue,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    Get.toNamed(
                                      AppRoutes.jobDetailsRoute,
                                      arguments: JobDetailsModel.fromJson(
                                        controller
                                            .myJobListModel
                                            .results
                                            ?.myJobs?[index]
                                            .toJson(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Details",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: AppColors.secondaryNavyBlue,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 16.w),

                              if (controller
                                      .myJobListModel
                                      .results
                                      ?.myJobs?[index]
                                      .operativeTrackers !=
                                  "on_duty")
                                Expanded(
                                  child: GetBuilder<MyJobsPageController>(
                                    builder: (controller) {
                                      final job = controller
                                          .myJobListModel
                                          .results
                                          ?.myJobs?[index];
                                      final jobId = job?.id.toString() ?? "";
                                      final isLoading =
                                          controller.jobLoading[jobId] ?? false;

                                      // Job start time
                                      final startTimeString =
                                          job?.jobDetails?.startTime ?? "";
                                      DateTime? jobStartTime;
                                      if (startTimeString.isNotEmpty) {
                                        jobStartTime = DateTime.tryParse(
                                          startTimeString,
                                        );
                                      }

                                      final now = DateTime.now();

                                      // 15 মিনিট আগের চেক
                                      bool isAfter15MinsBeforeStart = false;
                                      if (jobStartTime != null) {
                                        isAfter15MinsBeforeStart = now.isAfter(
                                          jobStartTime.subtract(
                                            const Duration(minutes: 15),
                                          ),
                                        );
                                      }

                                      bool canStartShift =
                                          isAfter15MinsBeforeStart;

                                      return ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              12.r,
                                            ),
                                          ),
                                          backgroundColor: canStartShift
                                              ? AppColors.secondaryNavyBlue
                                              : Colors.grey,
                                          foregroundColor:
                                              AppColors.primaryWhite,
                                        ),
                                        onPressed: isLoading || !canStartShift
                                            ? null
                                            : () async {
                                                await controller.startJob(
                                                  jobId: jobId,
                                                );
                                              },
                                        child: isLoading
                                            ? SizedBox(
                                                height: 20.h,
                                                width: 20.w,
                                                child:
                                                    CircularProgressIndicator(
                                                      color: AppColors
                                                          .primaryWhite,
                                                      strokeWidth: 2,
                                                    ),
                                              )
                                            : Text(
                                                "Start Shift",
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                ),
                                              ),
                                      );
                                    },
                                  ),
                                ),

                              if (controller
                                      .myJobListModel
                                      .results
                                      ?.myJobs?[index]
                                      .operativeTrackers ==
                                  "on_duty")
                                Expanded(
                                  child: GetBuilder<MyJobsPageController>(
                                    builder: (controller) {
                                      final job = controller
                                          .myJobListModel
                                          .results
                                          ?.myJobs?[index];
                                      final jobId = job?.id.toString() ?? "";
                                      final isLoading =
                                          controller.jobLoading[jobId] ?? false;

                                      return ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              12.r,
                                            ),
                                          ),
                                          backgroundColor: isLoading
                                              ? Colors.grey
                                              : AppColors.secondaryNavyBlue,
                                          foregroundColor:
                                              AppColors.primaryWhite,
                                        ),
                                        onPressed: isLoading
                                            ? null
                                            : () async {
                                                await controller.endJob(
                                                  jobId: jobId,
                                                );
                                              },
                                        child: isLoading
                                            ? SizedBox(
                                                height: 20.h,
                                                width: 20.w,
                                                child:
                                                    CircularProgressIndicator(
                                                      color: AppColors
                                                          .primaryWhite,
                                                      strokeWidth: 2,
                                                    ),
                                              )
                                            : Text(
                                                "Finish Shift",
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                ),
                                              ),
                                      );
                                    },
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  separatorBuilder: (context, index) => SizedBox(height: 16.h),
                  itemCount:
                      controller.myJobListModel.results?.myJobs?.length ?? 0,
                );
        },
      ),
    );
  }
}
