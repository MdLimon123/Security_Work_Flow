import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_security_workforce/app/modules/license_and_certificates_page/controllers/license_and_certificates_page_controller.dart';
import 'package:flutter_security_workforce/app/routes/app_routes.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';

class AddLicensePage extends StatelessWidget {
  const AddLicensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Add Licence",
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
        ),
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
                SizedBox(height: 26.h),
                _buildLicenceTypeInput(),
                SizedBox(height: 16.h),
                _buildLicenceUpload(),
                SizedBox(height: 8.h),
                _buildUploading(),
                SizedBox(height: 16.h),

                _buildLicenceExpiryDateInput(),
                SizedBox(height: 42.h),

                _buildSubmitButton(),

                SizedBox(height: 18.h),

                _buildCancelButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Center _buildCancelButton() {
    return Center(
      child: InkWell(
        onTap: () {},
        child: Text(
          "Cancel",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  SizedBox _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: GetBuilder<LicenseAndCertificatesPageController>(
        builder: (controller) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondaryNavyBlue,
              foregroundColor: AppColors.primaryWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(16.r),
              ),
            ),
            onPressed: () async {
              await controller.submitLicence();
            },
            child: controller.submitting
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryWhite,
                    ),
                  )
                : Text("Submit"),
          );
        },
      ),
    );
  }

  Column _buildLicenceExpiryDateInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Licence Expiry Date",
          style: TextStyle(fontSize: 16.sp, color: AppColors.secondaryNavyBlue),
        ),
        SizedBox(height: 4.h),

        GetBuilder<LicenseAndCertificatesPageController>(
          builder: (controller) {
            return TextField(
              controller: controller.expireDateTEC,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                hintText: "2029-10-10",
                hintStyle: TextStyle(color: AppColors.secondaryTextColor),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: AppColors.primaryBorderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: AppColors.primaryBorderColor),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Container _buildUploading() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.primaryBorderColor),
      ),
      child: GetBuilder<LicenseAndCertificatesPageController>(
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Text(
              controller.licenceFile?.path ?? "",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          );
        },
      ),
    );
  }

  InkWell _buildLicenceUpload() {
    return InkWell(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Licence Upload",
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.secondaryNavyBlue,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(color: AppColors.primaryOrange),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 18.h,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Upload your licence",
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      Spacer(),
                      GetBuilder<LicenseAndCertificatesPageController>(
                        builder: (controller) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.secondaryNavyBlue,
                              foregroundColor: AppColors.primaryWhite,

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                            onPressed: () async {
                              controller.pickLicenceFile();
                            },
                            child: Text("Upload"),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  GetBuilder<LicenseAndCertificatesPageController> _buildLicenceTypeInput() {
    return GetBuilder<LicenseAndCertificatesPageController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "license Type(s)",
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.secondaryNavyBlue,
              ),
            ),
            GetBuilder<LicenseAndCertificatesPageController>(
              builder: (controller) {
                return controller.licencesListFetching
                    ? Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryOrange,
                        ),
                      )
                    : PopupMenuButton<String>(
                        color: AppColors.primaryWhite,
                        onSelected: (value) {
                          controller.setSelectedLicenseType(value);
                        },
                        itemBuilder: (context) => [
                          for (
                            int i = 0;
                            i <
                                controller
                                    .licenceTypesModel
                                    .licenceTypes!
                                    .length;
                            i++
                          )
                            PopupMenuItem(
                              value:
                                  "${controller.licenceTypesModel.licenceTypes![i].title}",
                              child: Text(
                                "${controller.licenceTypesModel.licenceTypes![i].title}",
                              ),
                            ),

                          // const PopupMenuItem(
                          //   value: "Passport",
                          //   child: Text("Passport"),
                          // ),
                        ],
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.secondaryWhite),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: AppColors.primaryGray,
                              ),

                              SizedBox(width: 8.w),
                              Text(
                                controller.selectedLicenseType.isEmpty
                                    ? "Select your license type"
                                    : controller.selectedLicenseType,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: controller.selectedLicenseType.isEmpty
                                      ? AppColors.primaryGray
                                      : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
              },
            ),
          ],
        );
      },
    );
  }
}
