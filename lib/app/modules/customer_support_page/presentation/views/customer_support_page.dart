import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_security_workforce/app/core/constants/app_assets.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/modules/profile_page/controllers/profile_page_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CustomerSupportPage extends StatelessWidget {
  const CustomerSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.messageBG,
      appBar: AppBar(
        title: Row(
          children: [
            SvgPicture.asset(AppAssets.supportIcon),
            SizedBox(width: 14.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Customer Support",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 22.h),
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.primaryWhite,
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 24.w,
                              vertical: 5.h,
                            ),
                            child: Text(
                              "Today",
                              style: TextStyle(
                                color: AppColors.secondaryTextColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 56.h),

                      GetBuilder<ProfilePageController>(
                        init: ProfilePageController()..fetchCustomSupport(),
                        builder: (controller) {
                          if (controller.isCustomSupportLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (controller.customSupportModel.messages == null ||
                              controller.customSupportModel.messages!.isEmpty) {
                            return const Center(
                              child: Text("No messages found"),
                            );
                          }

                          return ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                controller.customSupportModel.messages!.length,
                            itemBuilder: (context, index) {
                              final message = controller
                                  .customSupportModel
                                  .messages![index];

                              return Container(
                                decoration: BoxDecoration(
                                  color: AppColors.secondaryNavyBlue,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12.r),
                                    topRight: Radius.circular(12.r),
                                    bottomLeft: Radius.circular(12.r),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.w,
                                    vertical: 5.5.h,
                                  ),
                                  child: Text(
                                    message.message,
                                    style: TextStyle(
                                      color: AppColors.primaryWhite,
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (_, __) => SizedBox(height: 12.h),
                          );
                        },
                      ),



                      SizedBox(height: 16.h),
                    ],
                  ),
                ),
              ),
            ),


            Container(
              decoration: BoxDecoration(
                color: AppColors.messageBG,
                border: Border(
                  top: BorderSide(color: Colors.grey.shade300, width: 0.5),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                child: Row(
                  children: [
                    Expanded(
                      child: GetBuilder<ProfilePageController>(
                        builder: (controller) {
                          return TextField(
                            controller: controller.sendMessageController,
                            onSubmitted: (value) {
                              controller.submitCustomSupport();
                            },
                            decoration: InputDecoration(
                              hintText: "Type a message...",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 8.h,
                              ),
                              filled: true,
                              fillColor: AppColors.primaryWhite,
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 8.w),
                    IconButton(
                      icon: Icon(
                        Icons.send,
                        color: AppColors.secondaryNavyBlue,
                      ),
                      onPressed: () {
                        Get.find<ProfilePageController>().submitCustomSupport();
                      },
                    ),
                  ],
                ),
              ),
            ),
          
          
          ],
        ),
      ),
    );
  }
}
