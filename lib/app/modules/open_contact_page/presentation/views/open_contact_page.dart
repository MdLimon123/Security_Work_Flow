import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_security_workforce/app/core/constants/app_assets.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/modules/open_contact_page/presentation/widgets/signature_dialog_widget.dart';
import 'package:flutter_security_workforce/app/routes/app_routes.dart';
import 'package:get/get.dart';

class OpenContactPage extends StatelessWidget {
  const OpenContactPage({super.key});

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
          "Party B — Employer",
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
                      "Michael Ross",
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
                  Expanded(
                    child: Text(
                      "Signature Statues :",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Pending",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryYellow,
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
                      "Signature Timestamp  :",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "14 Oct 2025, 18.03",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        SizedBox(height: 32.h),

        Center(
          child: SizedBox(
            width: 148.w,
            height: 41.h,
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const SignatureDialogWidget(),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondaryNavyBlue,
                foregroundColor: AppColors.primaryWhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(12.r),
                ),
              ),
              child: Text("Sign", style: TextStyle(fontSize: 16.sp)),
            ),
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
                      "Michael Ross",
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
                  Expanded(
                    child: Text(
                      "Signature Statues :",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Signed",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryGreen,
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
                      "Signature Timestamp  :",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "14 Oct 2025, 18.03",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
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
                        "\$15/hour",
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
                        "Superannuation (% of Hourly Rate)  :",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "11%",
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
                        "Gross Hourly Total (AUD)  :",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "\$200",
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
                        "AUD",
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
                        "Casual",
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
                        "Crowd Controlle",
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
                        "Site Name :",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Event Centre Downtown",
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
                        "Location Address  :",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "35 Park Ave, Sydney NSW ",
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
                        "EventCo Group Pty Ltd",
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
                        "12 Sep, 2025",
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
                        "18:00",
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
                        "23:00",
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
                        "8 hours",
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
                        "Michael Ross",
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
                        "QLD-SEC-239817",
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
                        "+61 400 123 456",
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
                        "example@example.co",
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
                        "Trust Bank",
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
                        "232651264",
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
                        "062-987",
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
                        "98765432",
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
                        "Apex Security Solutions Pty Ltd",
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
                        "12 345 678 910",
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
                        "SA-482937",
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
                        "New South Wales",
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
                        "name@gmail.com",
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
