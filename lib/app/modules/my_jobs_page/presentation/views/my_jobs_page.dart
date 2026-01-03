import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_security_workforce/app/core/constants/app_assets.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 22.h),
              //
              // _buildSearchInput(),
              //
              // SizedBox(height: 33.h),
              _buildJobCardList(),

              SizedBox(height: 12.h),
            ],
          ),
        ),
      ),
    );
  }

  Expanded _buildJobCardList() {
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
                              Expanded(child: Text("Date & Time :")),
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
                              Expanded(child: Text("Duration : ")),
                              Spacer(),
                              Expanded(child: Text("8 Hours")),
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
                                    children: [Text("Location"), Text("JVAI")],
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
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    backgroundColor:
                                        AppColors.secondaryNavyBlue,
                                    foregroundColor: AppColors.primaryWhite,
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    "Start Shift",
                                    style: TextStyle(fontSize: 16.sp),
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
                      controller.myJobListModel.results?.myJobs?.length ?? 0,
                );
        },
      ),
    );
  }

  GetBuilder<MyJobsPageController> _buildSearchInput() {
    return GetBuilder<MyJobsPageController>(
      init: MyJobsPageController(),
      builder: (controller) {
        return TextField(
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search, color: AppColors.primaryGray),
            hintText: "Search anything…",
            hintStyle: TextStyle(color: AppColors.primaryGray),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: BorderSide(color: AppColors.primaryBorderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: BorderSide(color: AppColors.primaryBorderColor),
            ),
          ),
          controller: controller.searchTEC,
        );
      },
    );
  }
}
