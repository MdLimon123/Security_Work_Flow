import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/modules/my_refferal_user_page/presentation/controllers/my_referral_user_page_controller.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';

class MyReferralUserPage extends StatelessWidget {
  const MyReferralUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Referral user",
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: _buildReferList(),
        ),
      ),
    );
  }

  GetBuilder<MyReferralUserPageController> _buildReferList() {
    return GetBuilder<MyReferralUserPageController>(
      builder: (controller) {
        return ListView.separated(
          itemBuilder: (context, index) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: AppColors.primaryBorderColor),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
              child: Column(
                children: [
                  _buildInfoElementRow(
                    leftString: "Name :",
                    rightString:
                        "${controller.myReferListModel.users?[index].firstName}",
                  ),
                  SizedBox(height: 8.h),
                  _buildInfoElementRow(
                    leftString: "Email :",
                    rightString:
                        "${controller.myReferListModel.users?[index].email}",
                  ),
                  SizedBox(height: 8.h),
                  _buildInfoElementRow(
                    leftString: "Address : ",
                    rightString:
                        "${controller.myReferListModel.users?[index].address}",
                  ),
                  SizedBox(height: 8.h),
                  _buildInfoElementRow(
                    leftString: "Join Date : ",
                    rightString:
                        "${controller.myReferListModel.users?[index].createAt}",
                  ),
                  SizedBox(height: 8.h),
                  _buildInfoElementRow(
                    leftString: "Subscribed : ",
                    rightString:
                        (controller
                                .myReferListModel
                                .users?[index]
                                .isSubscribe ??
                            false)
                        ? "YES"
                        : "NO",
                  ),
                  // SizedBox(height: 8.h),
                  // _buildInfoElementRow(
                  //   leftString: "Purchase Date :",
                  //   rightString: "22 Oct 2025",
                  // ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Text(
                        "Status :",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.secondaryTextColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),

                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color:
                              (controller
                                      .myReferListModel
                                      .users?[index]
                                      .isEarned ??
                                  false)
                              ? AppColors.primaryBlue
                              : AppColors.primaryOrange,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(4.sp),
                          child: Text(
                            (controller
                                        .myReferListModel
                                        .users?[index]
                                        .isEarned ??
                                    false)
                                ? "Earned"
                                : "Pending",
                            style: TextStyle(color: AppColors.primaryWhite),
                          ),
                        ),
                      ),

                    ],
                  ),

                  SizedBox(height: 24.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(16.r),
                        ),
                        backgroundColor: AppColors.secondaryNavyBlue,
                        foregroundColor: AppColors.primaryWhite,
                      ),
                      onPressed: () {
                        Get.toNamed(AppRoutes.messageRoute);
                      },
                      child: Text("Message"),
                    ),
                  ),
                ],
              ),
            ),
          ),
          separatorBuilder: (context, index) => SizedBox(height: 24.h),
          itemCount: controller.myReferListModel.users?.length ?? 0,
        );
      },
    );
  }

  Row _buildInfoElementRow({
    required String leftString,
    required String rightString,
  }) {
    return Row(
      children: [
        Text(
          leftString,
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.secondaryTextColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        Spacer(),
        Text(
          rightString,
          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
