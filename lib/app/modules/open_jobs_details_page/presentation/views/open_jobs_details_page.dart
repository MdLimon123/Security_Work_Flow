import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_security_workforce/app/core/constants/app_assets.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/core/constants/formate_date.dart';
import 'package:flutter_security_workforce/app/core/network/api_endpoints.dart';
import 'package:flutter_security_workforce/app/modules/home_page/presentation/controllers/home_page_controller.dart';
import 'package:flutter_security_workforce/app/modules/open_jobs_details_page/data/models/job_details_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenJobsDetailsPage extends StatelessWidget {
  OpenJobsDetailsPage({super.key});

  final JobDetailsModel jobDetailsModel = JobDetailsModel.fromJson(
    Get.arguments,
  );

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
                      child: GetBuilder(
                        init: Get.find<HomePageController>(),
                        builder: (controller) => OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.secondaryNavyBlue,
                            side: BorderSide(
                              color: AppColors.secondaryNavyBlue,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          onPressed: () {
                            controller.createChatRoom(
                              userId: jobDetailsModel.jobProvider!.company!.id
                                  .toString(),
                            );
                          },
                          child: Text("Message"),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    GetBuilder<HomePageController>(
                      init: Get.find<HomePageController>(),
                      builder: (controller) {
                        return Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.secondaryNavyBlue,
                              foregroundColor: AppColors.primaryWhite,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                            onPressed: () {
                              Get.dialog(
                                Material(
                                  color: Colors.black45,
                                  child: Center(
                                    child: Container(
                                      width: Get.width * 0.85,
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
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
                                                color:
                                                    AppColors.secondaryNavyBlue,
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
                                            "I hold the correct and current preferred operatives(s) to perform this task.",
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
                                                    foregroundColor:
                                                        AppColors.primaryWhite,
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
                                                    await controller.applyJob(
                                                      jobId: jobDetailsModel.id
                                                          .toString(),
                                                    );
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        AppColors.primaryGreen,
                                                    foregroundColor:
                                                        AppColors.primaryWhite,
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
                                                          child:
                                                              CircularProgressIndicator(
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
                            child: Text("Apply"),
                          ),
                        );
                      },
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
                  "${jobDetailsModel.jobProvider?.averageRatingMain}",
                  style: TextStyle(
                    fontSize: 40.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color:
                          double.tryParse(
                                jobDetailsModel
                                        .jobProvider
                                        ?.averageRatingMain ??
                                    "0.0",
                              )! >=
                              1.0
                          ? AppColors.primaryYellow
                          : AppColors.primaryGray,
                      size: 18.sp,
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.star,
                      color:
                          double.tryParse(
                                jobDetailsModel
                                        .jobProvider
                                        ?.averageRatingMain ??
                                    "0.0",
                              )! >=
                              2.0
                          ? AppColors.primaryYellow
                          : AppColors.primaryGray,
                      size: 18.sp,
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.star,
                      color:
                          double.tryParse(
                                jobDetailsModel
                                        .jobProvider
                                        ?.averageRatingMain ??
                                    "0.0",
                              )! >=
                              3.0
                          ? AppColors.primaryYellow
                          : AppColors.primaryGray,
                      size: 18.sp,
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.star,
                      color:
                          double.tryParse(
                                jobDetailsModel
                                        .jobProvider
                                        ?.averageRatingMain ??
                                    "0.0",
                              )! >=
                              4.0
                          ? AppColors.primaryYellow
                          : AppColors.primaryGray,
                      size: 18.sp,
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.star,
                      color:
                          double.tryParse(
                                jobDetailsModel
                                        .jobProvider
                                        ?.averageRatingMain ??
                                    "0.0",
                              )! >=
                              5.0
                          ? AppColors.primaryYellow
                          : AppColors.primaryGray,
                      size: 18.sp,
                    ),
                  ],
                ),
                // Text("52 Reviews"),
              ],
            ),
          ),
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Text(
              jobDetailsModel.jobProvider?.averageComunication ?? "0",
              style: TextStyle(fontSize: 16.sp),
            ),
            SizedBox(width: 4.w),
            Icon(Icons.star, color: AppColors.primaryYellow, size: 16.sp),
            SizedBox(width: 8.w),
            Text("Communication", style: TextStyle(fontSize: 20.sp)),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Text(
              jobDetailsModel.jobProvider?.averageReliability ?? "0",
              style: TextStyle(fontSize: 16.sp),
            ),
            SizedBox(width: 4.w),
            Icon(Icons.star, color: AppColors.primaryYellow, size: 16.sp),
            SizedBox(width: 8.w),
            Text("Payment reliability ", style: TextStyle(fontSize: 20.sp)),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Text(
              jobDetailsModel.jobProvider?.averagePayRate ?? "0",
              style: TextStyle(fontSize: 16.sp),
            ),
            SizedBox(width: 4.w),
            Icon(Icons.star, color: AppColors.primaryYellow, size: 16.sp),
            SizedBox(width: 8.w),
            Text("Pay rates", style: TextStyle(fontSize: 20.sp)),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Text(
              jobDetailsModel.jobProvider?.averageProfessionalism ?? "0",
              style: TextStyle(fontSize: 16.sp),
            ),
            SizedBox(width: 4.w),
            Icon(Icons.star, color: AppColors.primaryYellow, size: 16.sp),
            SizedBox(width: 8.w),
            Text("Professionalism", style: TextStyle(fontSize: 20.sp)),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Text(
              jobDetailsModel.jobProvider?.averageJobSupport ?? "0",
              style: TextStyle(fontSize: 16.sp),
            ),
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
              "${jobDetailsModel.address}",
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
                    "https://www.google.com/maps?q=${jobDetailsModel.latitude},${jobDetailsModel.longitude}";
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
                      "${jobDetailsModel.jobRole}",
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
                      "${jobDetailsModel.jobDate}",
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
                      "${jobDetailsModel.startTime}",
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
                      "${jobDetailsModel.endTime}",
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
                      "${jobDetailsModel.jobDuration} Hours",
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
          "Job Description",
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
        ),
        Text(
          "${jobDetailsModel.jobDetails}",
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
              "\$${jobDetailsModel.payRate}/hour",
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
              "${jobDetailsModel.jobDuration} Hours",
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
              "Shift Start Date",
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.secondaryTextColor,
              ),
            ),
            Text(
              formatDate(jobDetailsModel.jobDate ?? "N/A"),
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
                "${jobDetailsModel.jobProvider?.companyName ?? ""}",
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.secondaryTextColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "${jobDetailsModel.jobTitle}",
                style: TextStyle(
                  fontSize: 20.sp,
                  color: AppColors.secondaryNavyBlue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),

        // Image.asset(
        //   AppAssets.securityIcon,
        //   width: 70.w,
        //   height: 70.h,
        //   fit: BoxFit.contain,
        // ),
        CachedNetworkImage(
          width: 70.w,
          height: 70.w,
          imageUrl:
              "${ApiEndpoints.getBaseUrl}${jobDetailsModel.jobProvider?.company?.image ?? ""}",
          errorWidget: (context, url, error) =>
              Icon(Icons.broken_image, color: AppColors.primaryRed),
        ),
      ],
    );
  }
}
