import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/core/constants/formate_date.dart';
import 'package:flutter_security_workforce/app/modules/contact_page/data/amend_contract_model.dart';
import 'package:flutter_security_workforce/app/modules/contact_page/data/engagement_list_model.dart';
import 'package:flutter_security_workforce/app/routes/app_routes.dart';
import 'package:get/get.dart';

import '../controllers/contact_page_controller.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  bool isSigned(String? path) {
    return path != null &&
        path.trim().isNotEmpty &&
        path.toLowerCase() != 'null';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<ContactPageController>(
          init: ContactPageController(),
          builder: (controller) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  // _buildHeaderSection(controller),
                  SizedBox(height: 13.h),
                  _buildNewContactAmendContactSelection(),
                  SizedBox(height: 29.h),

                  Expanded(
                    child: controller.isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primaryOrange,
                            ),
                          )
                        : controller.selectedIndex == 0
                        ? (controller.engagementListModel.engagements!.isEmpty
                              ? Center(child: Text("No contracts found"))
                              : ListView.separated(
                                  itemBuilder: (context, index) {
                                    final contract = controller
                                        .engagementListModel
                                        .engagements![index];
                                    return _buildContractItem(contract);
                                  },
                                  separatorBuilder: (_, __) =>
                                      SizedBox(height: 24.h),
                                  itemCount: controller
                                      .engagementListModel
                                      .engagements!
                                      .length,
                                ))
                        : (controller
                                  .amendContractModel
                                  .amendEngagements
                                  .isEmpty
                              ? Center(
                                  child: Text("No amended contracts found"),
                                )
                              : ListView.separated(
                                  itemBuilder: (context, index) {
                                    final amend = controller
                                        .amendContractModel
                                        .amendEngagements[index];
                                    return _buildAmendContractItem(amend);
                                  },
                                  separatorBuilder: (_, __) =>
                                      SizedBox(height: 24.h),
                                  itemCount: controller
                                      .amendContractModel
                                      .amendEngagements
                                      .length,
                                )),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  GetBuilder<ContactPageController> _buildNewContactAmendContactSelection() {
    return GetBuilder<ContactPageController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    controller.updateIndex(0);
                  },
                  child: Text(
                    "New Contract",
                    style: TextStyle(
                      color: controller.selectedIndex == 0
                          ? AppColors.primaryOrange
                          : AppColors.primaryBlack,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                // Spacer(),
                InkWell(
                  onTap: () {
                    controller.updateIndex(1);
                  },
                  child: Text(
                    "Amend Contract",
                    style: TextStyle(
                      color: controller.selectedIndex != 0
                          ? AppColors.primaryOrange
                          : AppColors.primaryBlack,
                      fontWeight: FontWeight.w600,
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
              ],
            ),
          ],
        );
      },
    );
  }



  Widget _buildAmendContractItem(AmendEngagements amend) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.primaryBorderColor),
      ),
      padding: EdgeInsets.all(12.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Contract ID: ",
                  style: TextStyle(color: AppColors.secondaryNavyBlue),
                ),
                TextSpan(
                  text: "${amend.id ?? ""}",
                  style: TextStyle(color: AppColors.primaryOrange),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Company Name :",
                style: TextStyle(color: AppColors.secondaryTextColor),
              ),
              Text(
                amend.amendJobDetails?.jobProvider?.company?.firstName ?? "",
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Job Role :",
                style: TextStyle(color: AppColors.secondaryTextColor),
              ),
              Text(
                amend.amendJobDetails?.jobTitle ?? "",
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Date :",
                style: TextStyle(color: AppColors.secondaryTextColor),
              ),
              Text(
                formatDate(amend.amendJobDetails?.jobDate),
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Status :",
                style: TextStyle(color: AppColors.secondaryTextColor),
              ),
              Chip(
                color: WidgetStatePropertyAll(
                  AppColors.primaryGreen.withValues(alpha: 0.10),
                ),
                label: Text(
                  amend.signaturePartyA ?? "Pending",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryGreen,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 32.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Get.toNamed(AppRoutes.openAmendRoute, arguments: amend);
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                backgroundColor: AppColors.secondaryNavyBlue,
                foregroundColor: AppColors.primaryWhite,
              ),
              child: Text(
                "Open Contract",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContractItem(Engagement contract) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.primaryBorderColor),
      ),
      padding: EdgeInsets.all(12.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Contract ID:",
                  style: TextStyle(color: AppColors.secondaryNavyBlue),
                ),
                TextSpan(
                  text: " ${contract.id ?? ""}",
                  style: TextStyle(color: AppColors.primaryOrange),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Company Name :",
                style: TextStyle(color: AppColors.secondaryTextColor),
              ),
              Text(
                contract.jobDetails?.jobProvider?.company?.firstName ?? "",
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Job Role :",
                style: TextStyle(color: AppColors.secondaryTextColor),
              ),
              Text(
                contract.jobDetails?.jobTitle ?? "",
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Date :",
                style: TextStyle(color: AppColors.secondaryTextColor),
              ),
              Text(
                formatDate(contract.jobDetails?.jobDate),
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Status :",
                style: TextStyle(color: AppColors.secondaryTextColor),
              ),
              Builder(
                builder: (_) {
                  // Check if signature URL exists
                  bool isSigned =
                      contract.signaturePartyB != null &&
                      contract.signaturePartyB!.isNotEmpty;

                  return Chip(
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
                  );
                },
              ),
            ],
          ),

          SizedBox(height: 32.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () =>
                  Get.toNamed(AppRoutes.openContactRoute, arguments: contract),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                backgroundColor: AppColors.secondaryNavyBlue,
                foregroundColor: AppColors.primaryWhite,
              ),
              child: Text(
                "Open Contract",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
