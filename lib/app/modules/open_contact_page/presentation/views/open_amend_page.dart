import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_security_workforce/app/core/constants/app_assets.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/modules/contact_page/data/amend_contract_model.dart';
import 'package:flutter_security_workforce/app/modules/contact_page/presentation/controllers/contact_page_controller.dart';
import 'package:flutter_security_workforce/app/routes/app_routes.dart';
import 'package:get/get.dart';

class OpenAmendPage extends StatelessWidget {
  final AmendEngagements amendEngagements;

  OpenAmendPage({super.key, required this.amendEngagements});

  final controller = Get.find<ContactPageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Contract Details",
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
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 31.h),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Engagement Contract",
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.secondaryNavyBlue,
                            ),
                          ),
                          Text(
                            "Auto-generated via the Securiverse Platform",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.secondaryTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Chip(
                      label: Text(
                        "Pending",
                        style: TextStyle(color: AppColors.primaryYellow),
                      ),
                      backgroundColor: AppColors.primaryYellow.withValues(
                        alpha: .15,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32.h),

                Text(
                  "Disclaimer",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "Securiverse is a technology platform. It is not the employer of or agent of or act on behalf of the employer or any other party; it does not direct work and is not a party to this contract. Securiverse does not advertise or provide security services and does not employ security officers, crowd controllers, investigators, consultants, installers or any other parties within this agreement. ",
                  style: TextStyle(color: AppColors.secondaryTextColor),
                ),

                SizedBox(height: 32.h),

                Text(
                  "Parties",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                  ),
                ),

                SizedBox(height: 15.h),

                _buildPartyASectionOne(),

                SizedBox(height: 24.h),

                _buildPartyASectionTwo(),

                SizedBox(height: 34.h),

                _buildEngagementDetails(),

                SizedBox(height: 34.h),

                _buildRemuneration(),

                SizedBox(height: 34.h),

                Text(
                  "Compliance Confirmation",
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 8.h),
                Text(
                  "If disputes arise, they extend no further than the parties mentioned within this Agreement & should be addressed as such. Securiverse retains the right to support discussions with disputing parties and the right to disengage at any point. Parties may seek advice and engage, private, State and/or Federal bodies to support resolution.  ",
                  style: TextStyle(color: AppColors.secondaryTextColor),
                ),

                SizedBox(height: 32.h),

                Text(
                  "Privacy & Data",
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 16.h),

                Text(
                  "Consents",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 8.h),

                Text(
                  "Each party consents to the information contained within this Agreement being shared with the other party and stored by Securiverse.",
                  style: TextStyle(color: AppColors.secondaryTextColor),
                ),

                SizedBox(height: 12.h),

                Text(
                  "Data Use",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 8.h),

                Text(
                  "Data collected includes party details, timestamps, and metadata such as location data stored by Securiverse. ",
                  style: TextStyle(color: AppColors.secondaryTextColor),
                ),

                SizedBox(height: 32.h),

                Text(
                  "Acceptance & Signatures",
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 22.h),

                _buildPartyWithSignAvailable(),

                SizedBox(height: 12.h),

                _buildPartyWithoutSign(context: context),

                SizedBox(height: 34.h),

                Text(
                  "Amend Reson",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF002147),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF313131),
                  ),
                ),
                SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => Checkbox(
                        activeColor: AppColors.primaryOrange,
                        value: controller.isCheck.value,
                        onChanged: (value) {
                          controller.isCheck.value = value ?? false;
                        },
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "By agreeing, you confirm that you’ve read and accepted all terms of this contract.",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF313131),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          controller.rejectContract(
                            id: amendEngagements.id.toString(),
                          );
                        },
                        child: Obx(
                          () => Container(
                            width: double.infinity,
                            height: 54,
                            decoration: BoxDecoration(
                              color: Color(0xFFB30C0C),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: controller.isRejectLoading.value
                                  ? CircularProgressIndicator(
                                      color: AppColors.primaryWhite,
                                    )
                                  : Text(
                                      "Reject",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          controller.acceptContract(
                            id: amendEngagements.id.toString(),
                          );
                        },
                        child: Obx(
                          () => Container(
                            width: double.infinity,
                            height: 54,
                            decoration: BoxDecoration(
                              color: Color(0xFF009F07),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: controller.isAcceptLoading.value
                                  ? CircularProgressIndicator(
                                      color: AppColors.primaryWhite,
                                    )
                                  : Text(
                                      "Accept",
                                      style: TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                      ),
                                    ),
                            ),
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
      ),
    );
  }

  Column _buildPartyWithoutSign({required BuildContext context}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Party B — Worker",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
            color: AppColors.secondaryNavyBlue,
          ),
        ),

        SizedBox(height: 16.h),

        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(23.r),
            // border: Border.all(color: AppColors.primaryBorderColor),
          ),

          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Full Name :",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "${amendEngagements.application!.candidate!.firstName}",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 8.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Status :",
                    style: TextStyle(color: AppColors.secondaryTextColor),
                  ),
                  Builder(
                    builder: (_) {
                      bool isSigned =
                          amendEngagements.signaturePartyB != null &&
                          amendEngagements.signaturePartyB!.isNotEmpty;

                      return Chip(
                        backgroundColor: isSigned
                            ? AppColors.primaryGreen.withValues(alpha: 0.1)
                            : Colors.orange.withValues(alpha: 0.1),
                        label: Text(
                          isSigned ? "Signed" : "Pending",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: isSigned
                                ? AppColors.primaryGreen
                                : Colors.orange,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),

              SizedBox(height: 8.h),

              Center(
                child: amendEngagements.signaturePartyB == null
                    ? const SizedBox()
                    : Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: AppColors.primaryBorderColor,
                          ),
                        ),
                        child: Image.network(
                          "http://10.10.12.15:8001${amendEngagements.signaturePartyB}",
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => const SizedBox(),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column _buildPartyWithSignAvailable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Party A — Employer",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
            color: AppColors.secondaryNavyBlue,
          ),
        ),

        SizedBox(height: 16.h),

        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(23.r),
            // border: Border.all(color: AppColors.primaryBorderColor),
          ),

          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Full Name :",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "${amendEngagements.amendJobDetails!.jobProvider!.company!.firstName}",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Status :",
                    style: TextStyle(color: AppColors.secondaryTextColor),
                  ),
                  Builder(
                    builder: (_) {
                      bool isSigned =
                          amendEngagements.signaturePartyA != null &&
                          amendEngagements.signaturePartyA!.isNotEmpty;

                      return Chip(
                        backgroundColor: isSigned
                            ? AppColors.primaryGreen.withValues(alpha: 0.1)
                            : Colors.orange.withValues(alpha: 0.1),
                        label: Text(
                          isSigned ? "Signed" : "Pending",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: isSigned
                                ? AppColors.primaryGreen
                                : Colors.orange,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),

              SizedBox(height: 8.h),

              Center(
                child: amendEngagements.signaturePartyB == null
                    ? const SizedBox()
                    : Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: AppColors.primaryBorderColor,
                          ),
                        ),
                        child: Image.network(
                          "http://10.10.12.15:8001${amendEngagements.signaturePartyA}",
                          fit: BoxFit.contain,
                          errorBuilder: (_, _, _) => const SizedBox(),
                        ),
                      ),
              ),

              SizedBox(height: 8.h),
            ],
          ),
        ),
        SizedBox(height: 32.h),

        Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.primaryBorderColor),
            ),
            child: Image.asset(
              width: Get.width / 1.5,
              height: 57.h,
              AppAssets.signatureImg,
            ),
          ),
        ),
      ],
    );
  }

  Column _buildRemuneration() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Remuneration",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
            color: AppColors.secondaryNavyBlue,
          ),
        ),

        SizedBox(height: 16.h),

        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(23.r),
            border: Border.all(color: AppColors.primaryBorderColor),
          ),

          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Base Hourly Rate (AUD) :",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "\$${amendEngagements.amendJobDetails!.payRate}",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondaryTextColor,
                        ),
                      ),
                    ),
                  ],
                ),

                // SizedBox(height: 8.h),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Expanded(
                //       child: Text(
                //         "Superannuation (% of Hourly Rate)  :",
                //         style: TextStyle(
                //           fontSize: 16.sp,
                //           fontWeight: FontWeight.w500,
                //         ),
                //       ),
                //     ),
                //     Expanded(
                //       child: Text(
                //         "11%",
                //         style: TextStyle(
                //           fontSize: 16.sp,
                //           fontWeight: FontWeight.w400,
                //           color: AppColors.secondaryTextColor,
                //         ),
                //         textAlign: TextAlign.end,
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(height: 8.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Gross Hourly Total (AUD)  :",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "\$${amendEngagements.totalAmount}",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondaryTextColor,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Currency  :",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${amendEngagements.application!.currency}",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondaryTextColor,
                        ),
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

  Column _buildEngagementDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Engagement Details",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
            color: AppColors.secondaryNavyBlue,
          ),
        ),

        SizedBox(height: 16.h),

        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(23.r),
            border: Border.all(color: AppColors.primaryBorderColor),
          ),

          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Engagement Type :",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${amendEngagements.amendJobDetails!.engagementType}",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondaryTextColor,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Role Type :",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${amendEngagements.amendJobDetails!.jobTitle}",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondaryTextColor,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),

                // SizedBox(height: 8.h),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Expanded(
                //       child: Text(
                //         "Site Name :",
                //         style: TextStyle(
                //           fontSize: 16.sp,
                //           fontWeight: FontWeight.w500,
                //         ),
                //       ),
                //     ),
                //     Expanded(
                //       child: Text(
                //         "Event Centre Downtown",
                //         textAlign: TextAlign.end,
                //         style: TextStyle(
                //           fontSize: 16.sp,
                //           fontWeight: FontWeight.w400,
                //           color: AppColors.secondaryTextColor,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(height: 8.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Location Address  :",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${amendEngagements.amendJobDetails!.address} ",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondaryTextColor,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Client Name :",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${amendEngagements.amendJobDetails!.jobProvider!.company!.firstName}",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondaryTextColor,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Date :",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${amendEngagements.amendJobDetails!.jobDate}",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondaryTextColor,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Start Time :",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${amendEngagements.amendJobDetails!.startTime}",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondaryTextColor,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "End Time :",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${amendEngagements.amendJobDetails!.endTime}",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondaryTextColor,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Duration (hours) :",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${amendEngagements.amendJobDetails!.jobDuration}",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondaryTextColor,
                        ),
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

  Column _buildPartyASectionTwo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Party A — Employer",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
            color: AppColors.secondaryNavyBlue,
          ),
        ),

        SizedBox(height: 16.h),

        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(23.r),
            border: Border.all(color: AppColors.primaryBorderColor),
          ),

          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Full Name :",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${amendEngagements.application!.candidate!.firstName}",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondaryTextColor,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Security Licence No. :",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${amendEngagements.application!.candidate!.licences!.first.licenceNo}",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondaryTextColor,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Contact Phone :",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${amendEngagements.application!.candidate!.phone}",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondaryTextColor,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Contact Email :",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${amendEngagements.application!.candidate!.phone}",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondaryTextColor,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Bank Name :",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${amendEngagements.application!.candidate!.bankName}",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondaryTextColor,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Account Name :",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${amendEngagements.application!.candidate!.accountHolderName}",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondaryTextColor,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Bank-State-Branch (BSB) :",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${amendEngagements.application!.candidate!.bankBranch}",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondaryTextColor,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Account Number :",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${amendEngagements.application!.candidate!.accountNo}",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondaryTextColor,
                        ),
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

  Column _buildPartyASectionOne() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Party A — Employer",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
            color: AppColors.secondaryNavyBlue,
          ),
        ),

        SizedBox(height: 16.h),

        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(23.r),
            border: Border.all(color: AppColors.primaryBorderColor),
          ),

          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Legal Name :",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${amendEngagements.amendJobDetails!.jobProvider!.company!.firstName}",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondaryTextColor,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "ABN :",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${amendEngagements.amendJobDetails!.jobProvider!.abnNumber}",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondaryTextColor,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Company License No. :",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${amendEngagements.amendJobDetails!.jobProvider!.company!.licences!.first.licenceNo}",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondaryTextColor,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "State License Held  :",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${amendEngagements.amendJobDetails!.jobProvider!.company!.licences!.first.stateOrTerritory}",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondaryTextColor,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Contact Email :",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${amendEngagements.amendJobDetails!.jobProvider!.company!.email}",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondaryTextColor,
                        ),
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
}
