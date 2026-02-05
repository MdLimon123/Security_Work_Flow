import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/modules/contact_page/data/engagement_list_model.dart';
import 'package:flutter_security_workforce/app/modules/open_contact_page/presentation/widgets/signature_dialog_widget.dart';
import 'package:flutter_security_workforce/app/routes/app_routes.dart';
import 'package:get/get.dart';

class OpenContactPage extends StatelessWidget {
  final Engagement engagementListData;

  const OpenContactPage({super.key, required this.engagementListData});

  @override
  Widget build(BuildContext context) {
    bool isSigned =
        engagementListData.signaturePartyB != null &&
        engagementListData.signaturePartyB!.isNotEmpty;
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
                      backgroundColor: isSigned
                          ? AppColors.primaryGreen.withOpacity(0.1)
                          : Colors.orange.withOpacity(0.1),
                      label: Text(
                        isSigned ? "Signed" : "Pending",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: isSigned
                              ? AppColors.primaryGreen
                              : Colors.orange,
                        ),
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

                _buildPartyWithoutSign(
                  context: context,
                  id: engagementListData.id.toString(),
                ),

                SizedBox(height: 34.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _buildPartyWithoutSign({
    required BuildContext context,
    required String id,
  }) {
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
                      "${engagementListData.application!.candidate!.firstName}",
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
                          engagementListData.signaturePartyB != null &&
                          engagementListData.signaturePartyB!.isNotEmpty;

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
                child: engagementListData.signaturePartyB == null
                    ? const SizedBox()
                    : Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: AppColors.primaryBorderColor,
                          ),
                        ),
                        child: Image.network(
                          "http://10.10.12.15:8001${engagementListData.signaturePartyB}",
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => const SizedBox(),
                        ),
                      ),
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
                  builder: (context) => SignatureDialogWidget(id: id),
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
                      "${engagementListData.jobDetails!.jobProvider!.company!.firstName}",
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
                          engagementListData.signaturePartyA != null &&
                          engagementListData.signaturePartyA!.isNotEmpty;

                      return Chip(
                        backgroundColor: isSigned
                            ? AppColors.primaryGreen.withValues(alpha: 0.1)
                            : Colors.orange.withValues(alpha: 0.1),
                        label: Text(
                          isSigned ? "Signed" : "Pendings",
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
            ],
          ),
        ),
        SizedBox(height: 32.h),

        Center(
          child: engagementListData.signaturePartyB == null
              ? const SizedBox()
              : Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: AppColors.primaryBorderColor),
                  ),
                  child: Image.network(
                    "http://10.10.12.15:8001${engagementListData.signaturePartyA}",
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => const SizedBox(),
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
                        "\$${engagementListData.jobDetails!.payRate}",
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
                        "Gross Hourly Total (AUD)  :",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "\$${engagementListData.totalAmount}",
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
                        "${engagementListData.application!.currency}",
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
                        "${engagementListData.jobDetails!.engagementType}",
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
                        "${engagementListData.jobDetails!.jobTitle}",
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
                        "Location Address  :",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${engagementListData.jobDetails!.address}",
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
                        "${engagementListData.jobDetails!.jobProvider!.company!.firstName}",
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
                        "${engagementListData.jobDetails!.jobDate}",
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
                        "${engagementListData.jobDetails!.startTime}",
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
                        "${engagementListData.jobDetails!.endTime}",
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
                        "${engagementListData.jobDetails!.jobDuration}",
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
    final application = engagementListData.application;
    final candidate = application?.candidate;

    final company = engagementListData.jobDetails?.jobProvider?.company;

    final licences = company?.licences ?? [];

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
                /// Full Name
                _buildRow("Full Name :", candidate?.firstName ?? 'N/A'),

                SizedBox(height: 8.h),

                /// Security Licence No
                _buildRow(
                  "Security Licence No. :",
                  licences.isNotEmpty
                      ? licences.first.licenceNo ?? 'N/A'
                      : 'N/A',
                ),

                SizedBox(height: 8.h),

                /// Contact Phone
                _buildRow("Contact Phone :", candidate?.phone ?? 'N/A'),

                SizedBox(height: 8.h),

                /// Contact Email
                _buildRow("Contact Email :", candidate?.email ?? 'N/A'),

                SizedBox(height: 8.h),

                /// Bank Name
                _buildRow("Bank Name :", company?.bankName ?? 'N/A'),

                SizedBox(height: 8.h),

                /// Account Name
                _buildRow(
                  "Account Name :",
                  company?.accountHolderName ?? 'N/A',
                ),

                SizedBox(height: 8.h),

                /// Bank Branch (BSB)
                _buildRow(
                  "Bank-State-Branch (BSB) :",
                  company?.bankBranch ?? 'N/A',
                ),

                SizedBox(height: 8.h),

                /// Account Number
                _buildRow("Account Number :", company?.accountNo ?? 'N/A'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Column _buildPartyASectionOne() {
    final company = engagementListData.jobDetails?.jobProvider?.company;

    final licences = company?.licences ?? [];

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
                /// Legal Name
                _buildRow("Legal Name :", company?.firstName ?? 'N/A'),

                SizedBox(height: 8.h),

                /// ABN
                _buildRow(
                  "ABN :",
                  engagementListData.jobDetails?.jobProvider?.abnNumber
                          ?.toString() ??
                      'N/A',
                ),

                SizedBox(height: 8.h),

                /// Company Licence No
                _buildRow(
                  "Company License No. :",
                  licences.isNotEmpty
                      ? licences.first.licenceNo ?? 'N/A'
                      : 'N/A',
                ),

                SizedBox(height: 8.h),

                /// State Licence Held
                _buildRow(
                  "State License Held :",
                  licences.length > 1
                      ? licences[1].stateOrTerritory ?? 'N/A'
                      : 'N/A',
                ),

                SizedBox(height: 8.h),

                /// Email
                _buildRow("Contact Email :", company?.email ?? 'N/A'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.secondaryTextColor,
            ),
          ),
        ),
      ],
    );
  }
}
