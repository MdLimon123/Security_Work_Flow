import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_security_workforce/app/core/constants/app_assets.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/core/constants/formate_date.dart';
import 'package:flutter_security_workforce/app/core/constants/formate_time.dart';
import 'package:flutter_security_workforce/app/core/data/models/job_details_model.dart';
import 'package:flutter_security_workforce/app/modules/contact_page/data/engagement_list_model.dart';
import 'package:flutter_security_workforce/app/modules/my_jobs_page/data/model/upcoming_job_model.dart';
import 'package:flutter_security_workforce/app/modules/my_jobs_page/presentation/controllers/my_jobs_page_controller.dart';
import 'package:flutter_security_workforce/app/routes/app_routes.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

// "08:30:00" → "08:30 AM", "14:00:00" → "02:00 PM"
String _formatTime24(String? time) {
  if (time == null || time.isEmpty) return "";
  final parts = time.split(":");
  if (parts.length < 2) return time;
  int hour = int.tryParse(parts[0]) ?? 0;
  final minute = parts[1];
  final period = hour >= 12 ? "PM" : "AM";
  if (hour == 0) hour = 12;
  if (hour > 12) hour -= 12;
  return "${hour.toString().padLeft(2, '0')}:$minute $period";
}

/// Build API-shaped JSON for [JobDetailsModel] from an upcoming engagement row.
Map<String, dynamic> _upcomingJobToJobDetailsModelJson(UpcomingJob job) {
  final d = job.jobDetails;
  final p = d.jobProvider;
  final c = p.company;
  return {
    'id': job.id,
    'operative_trackers': job.operativeTrackers,
    'contacts_trackers': job.contactsTrackers,
    'amend_trackers': job.amendTrackers,
    'amend_details': job.amendDetails,
    'new_end_time': job.newEndTime,
    'total_amount': job.totalAmount.toString(),
    'new_job_duration': job.newJobDuration.toString(),
    'signature_party_a': job.signaturePartyA,
    'signature_party_b': job.signaturePartyB,
    'job_details': {
      'id': d.id,
      'job_title': d.jobTitle,
      'job_provider': {
        'id': p.id,
        'company': {
          'id': c.id,
          'first_name': c.firstName,
          'email': c.email,
          'phone': c.phone,
          'is_email_varified': c.isEmailVarified,
          'image': c.image,
          'user_type': c.userType,
          'is_admin_aproved': c.isAdminApproved,
          'is_subscribe': c.isSubscribe,
        },
        'company_name': p.companyName,
        'phone_number': p.phoneNumber,
        'abn_number': p.abnNumber,
        'average_rating_main': p.averageRatingMain.toString(),
        'average_comunication': p.averageCommunication.toString(),
        'average_reliability': p.averageReliability.toString(),
        'average_pay_rate': p.averagePayRate.toString(),
        'average_professionalism': p.averageProfessionalism.toString(),
        'average_job_support': p.averageJobSupport.toString(),
      },
      'latitude': d.latitude,
      'longitude': d.longitude,
      'address': d.address,
      'job_date': d.jobDate,
      'start_time': d.startTime,
      'end_time': d.endTime,
      'job_duration': d.jobDuration.toString(),
      'pay_type': d.payType,
      'pay_rate': d.payRate.toString(),
      'operative_required': d.operativeRequired,
      'licence_type_requirements': d.licenceTypeRequirements,
      'min_rating_requirements': d.minRatingRequirements,
      'accreditations_requirements': d.accreditationsRequirements,
      'is_preferred_guard': d.isPreferredGuard,
      'gender_requirements': d.genderRequirements,
      'language_requirements': d.languageRequirements,
      'status': d.status,
      'engagement_type': d.engagementType,
      'provident_fund': d.providentFund,
      'job_details': d.jobDetails,
      'created_at': d.createdAt,
      'updated_at': d.updatedAt,
    },
  };
}

bool _upcomingJobPendingContact(UpcomingJob job) =>
    job.contactsTrackers.toLowerCase().trim() == 'pending';

bool _upcomingJobContractSigned(UpcomingJob job) {
  final b = job.signaturePartyB;
  return b != null && b.trim().isNotEmpty;
}

/// After signing, API often clears `pending` on contacts_trackers — still show the row (disabled).
bool _upcomingJobShowsSignContractRow(UpcomingJob job) =>
    _upcomingJobPendingContact(job) || _upcomingJobContractSigned(job);

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

  Widget _buildUpcomingJobCardList() {
    return GetBuilder<MyJobsPageController>(
      builder: (controller) {
        return controller.pageLoading3
            ? Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryOrange,
                ),
              )
            : ListView.separated(
                shrinkWrap: false,
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
                                  _formatTime24(
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
                                  _formatTime24(
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
                                        controller
                                                .upcomingJobModel
                                                .results
                                                ?.myJobs[index]
                                                .jobDetails
                                                .address ??
                                            "",
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () async {
                                  final locJob = controller
                                      .upcomingJobModel
                                      .results
                                      ?.myJobs[index];
                                  if (locJob == null) return;
                                  String googleMapsUrl =
                                      "https://www.google.com/maps?q=${locJob.jobDetails.latitude},${locJob.jobDetails.longitude}";
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
                                    final jobs = controller
                                        .upcomingJobModel
                                        .results
                                        ?.myJobs;
                                    if (jobs == null || index >= jobs.length) {
                                      return;
                                    }
                                    Get.toNamed(
                                      AppRoutes.jobDetailsRoute,
                                      arguments: JobDetailsModel.fromJson(
                                        _upcomingJobToJobDetailsModelJson(
                                          jobs[index],
                                        ),
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
                                      .upcomingJobModel
                                      .results
                                      ?.myJobs[index]
                                      .operativeTrackers !=
                                  "on_duty")
                                // 15 মিনিট আগের চেক
                                Expanded(
                                  child: GetBuilder<MyJobsPageController>(
                                    builder: (controller) {
                                      final job = controller
                                          .upcomingJobModel
                                          .results
                                          ?.myJobs[index];
                                      final jobId = job?.id.toString() ?? "";
                                      final isLoading =
                                          controller.jobLoading[jobId] ?? false;
                                      final shiftStartedOnce = jobId.isNotEmpty &&
                                          controller.upcomingShiftStartedJobIds
                                              .contains(jobId);
                                      // Only "tasked" may enable Start Shift; all other statuses stay disabled.
                                      final isTaskedStatus =
                                          (job?.jobDetails.status ?? '')
                                              .toLowerCase()
                                              .trim() ==
                                          'tasked';

                                      // Job start time - combine jobDate + startTime (local time)
                                      final jobDateString =
                                          job?.jobDetails.jobDate ?? "";
                                      final startTimeString =
                                          job?.jobDetails.startTime ?? "";
                                      DateTime? jobStartTime;
                                      if (jobDateString.isNotEmpty &&
                                          startTimeString.isNotEmpty) {
                                        jobStartTime = DateTime.tryParse(
                                          "${jobDateString}T$startTimeString",
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
                                          backgroundColor: shiftStartedOnce ||
                                                  !isTaskedStatus
                                              ? Colors.grey
                                              : canStartShift
                                                  ? AppColors.secondaryNavyBlue
                                                  : Colors.grey,
                                          foregroundColor:
                                              AppColors.primaryWhite,
                                        ),
                                        onPressed: isLoading ||
                                                shiftStartedOnce ||
                                                !isTaskedStatus ||
                                                !canStartShift
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
                            ],
                          ),
                          Builder(
                            builder: (context) {
                              final jobs =
                                  controller.upcomingJobModel.results?.myJobs;
                              if (jobs == null || index >= jobs.length) {
                                return const SizedBox.shrink();
                              }
                              final job = jobs[index];
                              if (!_upcomingJobShowsSignContractRow(job)) {
                                return const SizedBox.shrink();
                              }
                              final signed = _upcomingJobContractSigned(job);
                              return Padding(
                                padding: EdgeInsets.only(top: 12.h),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                      ),
                                      backgroundColor: signed
                                          ? Colors.grey
                                          : AppColors.secondaryNavyBlue,
                                      foregroundColor: AppColors.primaryWhite,
                                      disabledBackgroundColor: Colors.grey,
                                      disabledForegroundColor:
                                          AppColors.primaryWhite,
                                    ),
                                    onPressed: signed
                                        ? null
                                        : () async {
                                            final engagement =
                                                Engagement.fromJson(
                                              _upcomingJobToJobDetailsModelJson(
                                                job,
                                              ),
                                            );
                                            await Get.toNamed(
                                              AppRoutes.openContactRoute,
                                              arguments: engagement,
                                            );
                                            await controller
                                                .refreshUpcomingJobs();
                                          },
                                    child: Text(
                                      'Sign Contract Now',
                                      style: TextStyle(fontSize: 16.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  separatorBuilder: (context, index) => SizedBox(height: 16.h),
                  itemCount:
                      controller.upcomingJobModel.results?.myJobs.length ?? 0,
                );
      },
    );
  }




  Widget _buildCompletedJobCard() {
    return GetBuilder<MyJobsPageController>(
      builder: (controller) {
        return controller.pageLoading2
            ? Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryOrange,
                ),
              )
            : ListView.separated(
                shrinkWrap: false,
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
                              if (controller
                                      .jobHistoryListModel
                                      .results
                                      ?.myJobs?[index]
                                      .isGuardReted !=
                                  true) ...[
                                SizedBox(width: 16.w),
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                      ),
                                      backgroundColor:
                                          AppColors.secondaryNavyBlue,
                                      foregroundColor: AppColors.primaryWhite,
                                    ),
                                    onPressed: () {
                                      Get.toNamed(
                                        AppRoutes.finishShiftRoute,
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
                                      "Rate now",
                                      style: TextStyle(fontSize: 16.sp),
                                    ),
                                  ),
                                ),
                              ],
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
    );
  }

 
 
  Widget _buildJobInProgressCardList() {
    return GetBuilder<MyJobsPageController>(
      builder: (controller) {
        return controller.pageLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryOrange,
                ),
              )
            : ListView.separated(
                shrinkWrap: false,
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
                                  formatDate(
                                    controller
                                            .myJobListModel
                                            .results
                                            ?.myJobs?[index]
                                            .jobDetails
                                            ?.jobDate ??
                                        "",
                                  ),
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
                                  _formatTime24(
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
                                  _formatTime24(
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
                                      final finishShiftOnce =
                                          jobId.isNotEmpty &&
                                              controller
                                                  .inProgressFinishShiftJobIds
                                                  .contains(jobId);

                                      return ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              12.r,
                                            ),
                                          ),
                                          backgroundColor: isLoading ||
                                                  finishShiftOnce
                                              ? Colors.grey
                                              : AppColors.secondaryNavyBlue,
                                          foregroundColor:
                                              AppColors.primaryWhite,
                                        ),
                                        onPressed: isLoading ||
                                                finishShiftOnce
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
    );
  }



}
