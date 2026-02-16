import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_security_workforce/app/core/data/models/job_details_model.dart';
import 'package:flutter_security_workforce/app/modules/job_history_page/presentation/controllers/job_history_page_controller.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../routes/app_routes.dart';

class JobHistoryPage extends StatelessWidget {
  const JobHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Job History",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
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

        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: GetBuilder<JobHistoryPageController>(
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
                                      AppColors.primaryBlue.withValues(
                                        alpha: .2,
                                      ),
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
                                  Expanded(child: Text("Date & Time :")),
                                  Spacer(),
                                  Expanded(
                                    child: Text(
                                      "${controller.jobHistoryListModel.results?.myJobs?[index].jobDetails?.jobDate}",
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
                                        await launchUrl(
                                          Uri.parse(googleMapsUrl),
                                        );
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
                                          borderRadius: BorderRadius.circular(
                                            12.r,
                                          ),
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
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 16.h),
                      itemCount:
                          controller
                              .jobHistoryListModel
                              .results
                              ?.myJobs
                              ?.length ??
                          0,
                    );
            },
          ),
        ),
      
     
     
      ),
    );
  }
}
