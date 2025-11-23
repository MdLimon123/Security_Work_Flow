import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/routes/app_routes.dart';
import 'package:get/get.dart';

import '../controllers/contact_page_controller.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

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
                  _buildHeaderSection(controller),
                  SizedBox(height: 13.h),
                  _buildNewContactAmendContactSelection(),
                  SizedBox(height: 29.h),

                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: false,
                      itemBuilder: (context, index) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: AppColors.primaryBorderColor,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12.sp),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Contract ID:",
                                      style: TextStyle(
                                        color: AppColors.secondaryNavyBlue,
                                      ),
                                    ),
                                    TextSpan(
                                      text: " #232025",
                                      style: TextStyle(
                                        color: AppColors.primaryOrange,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Company Name :",
                                    style: TextStyle(
                                      color: AppColors.secondaryTextColor,
                                    ),
                                  ),
                                  Text(
                                    "SecurePro Pty Ltd",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Job Role :",
                                    style: TextStyle(
                                      color: AppColors.secondaryTextColor,
                                    ),
                                  ),
                                  Text(
                                    "Event Security Officer",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Date : ",
                                    style: TextStyle(
                                      color: AppColors.secondaryTextColor,
                                    ),
                                  ),
                                  Text(
                                    "22 Oct 2025",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Status : ",
                                    style: TextStyle(
                                      color: AppColors.secondaryTextColor,
                                    ),
                                  ),

                                  Chip(
                                    color: WidgetStatePropertyAll(
                                      AppColors.primaryGreen.withValues(
                                        alpha: 0.10,
                                      ),
                                    ),
                                    label: Text(
                                      "Signed",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        // backgroundColor: ,
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
                                    Get.toNamed(AppRoutes.openContactRoute);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.r),
                                    ),
                                    backgroundColor:
                                        AppColors.secondaryNavyBlue,
                                    foregroundColor: AppColors.primaryWhite,
                                  ),
                                  child: Text(
                                    "Open Contract",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 24.h),
                      itemCount: 30,
                    ),
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

  Row _buildHeaderSection(ContactPageController controller) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller.searchTEC,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: AppColors.secondaryTextColor,
              ),
              hintText: "Search for jobs or shifts…",
              hintStyle: TextStyle(color: AppColors.secondaryTextColor),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide(color: AppColors.primaryBorderColor),
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            Get.toNamed(AppRoutes.notificationRoute);
          },
          icon: Icon(Icons.notifications_outlined),
        ),
      ],
    );
  }
}
