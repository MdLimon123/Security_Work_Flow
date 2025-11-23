import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_security_workforce/app/core/constants/app_assets.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/modules/profile_page/controllers/profile_page_controller.dart';
import 'package:flutter_security_workforce/app/routes/app_routes.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
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
                _buildHeaderSection(),
                SizedBox(height: 32.h),
                Text("Personal Details", style: TextStyle(fontSize: 20.sp)),
                SizedBox(height: 8.h),
                _buildPersonalDetails(),
                SizedBox(height: 21.h),
                Text("Others Details", style: TextStyle(fontSize: 20.sp)),
                SizedBox(height: 8.h),
                _buildOtherDetails(),
                SizedBox(height: 17.h),
                Row(
                  children: [
                    Text("Referral Link", style: TextStyle(fontSize: 20.sp)),
                    Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryOrange,
                        foregroundColor: AppColors.primaryWhite,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      onPressed: () async {
                        await Clipboard.setData(
                          ClipboardData(
                            text:
                                "https:/.com/signin/?refer_token=p8ZV9u356c...",
                          ),
                        );
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Copied to clipboard')),
                          );
                        }
                      },
                      child: Text("Share Link"),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                TextField(
                  style: TextStyle(
                    color: AppColors.primaryBlue,
                    overflow: TextOverflow.ellipsis,
                  ),
                  enabled: false,
                  controller: TextEditingController(
                    text: "https:/.com/signin/?refer_token=p8ZV9u356c...",
                  ),
                  decoration: InputDecoration(
                    filled: true,

                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 12.5.h,
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.secondaryGray.withValues(alpha: .5),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 51.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _buildOtherDetails() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
        border: Border.all(
          color: AppColors.secondaryGray.withValues(alpha: .5),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.h),
        child: Column(
          children: [
            _buildActionableButton(
              onTap: () {
                Get.toNamed(AppRoutes.myReferralUserRoute);
              },
              title: "My Referral user",
              appAsset: AppAssets.referralIcon,
            ),
            SizedBox(height: 16.h),
            _buildActionableButton(
              onTap: () {
                Get.toNamed(AppRoutes.subscriptionRoute);
              },
              title: "Subscription",
              appAsset: AppAssets.subscriptionIcon,
            ),
            SizedBox(height: 16.h),

            _buildActionableButton(
              onTap: () {},
              title: "Notifications",
              appAsset: AppAssets.notificationIcon,
              isNotification: true,
            ),
            SizedBox(height: 16.h),

            _buildActionableButton(
              onTap: () {
                Get.toNamed(AppRoutes.jobHistoryRoute);
              },
              title: "Job History",
              appAsset: AppAssets.historyIcon,
            ),
            SizedBox(height: 16.h),

            _buildActionableButton(
              onTap: () {
                Get.toNamed(AppRoutes.customerSupportRoute);
              },
              title: "Customer Support ",
              appAsset: AppAssets.supportIcon,
            ),
            SizedBox(height: 16.h),

            _buildActionableButton(
              onTap: () {
                Get.defaultDialog(
                  title: "",
                  backgroundColor: AppColors.primaryWhite,
                  content: Column(
                    children: [
                      SvgPicture.asset(AppAssets.shutdownIcon),
                      SizedBox(height: 16.h),
                      Text(
                        "Logout Account",
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {},
                              child: Text(
                                "Cancel",
                                style: TextStyle(color: AppColors.primaryBlack),
                              ),
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryRed,
                                foregroundColor: AppColors.primaryWhite,
                              ),
                              onPressed: () {},
                              child: Text("Logout"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              title: "Logout",
              appAsset: AppAssets.logoutIcon,
              isLogout: true,
            ),
          ],
        ),
      ),
    );
  }

  Container _buildPersonalDetails() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
        border: Border.all(
          color: AppColors.secondaryGray.withValues(alpha: .5),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.h),
        child: Column(
          children: [
            _buildActionableButton(
              onTap: () {
                Get.toNamed(AppRoutes.editProfileRoute);
              },
              title: "Edit Profile info",
              appAsset: AppAssets.profileIcon,
            ),
            SizedBox(height: 16.h),
            _buildActionableButton(
              onTap: () {
                Get.toNamed(AppRoutes.forgetPassRoute);
              },
              title: "Password Change",
              appAsset: AppAssets.lockIcon,
            ),
            SizedBox(height: 16.h),

            _buildActionableButton(
              onTap: () {
                Get.toNamed(AppRoutes.superannuationRoute);
              },
              title: "Superannuation Details",
              appAsset: AppAssets.timerIcon,
            ),
            SizedBox(height: 16.h),

            _buildActionableButton(
              onTap: () {
                Get.toNamed(AppRoutes.licencesAndCertificatesRoute);
              },
              title: "Licences & Certificates",
              appAsset: AppAssets.listIcon,
            ),
            SizedBox(height: 16.h),

            _buildActionableButton(
              onTap: () {
                Get.toNamed(AppRoutes.otherAccrediationsPage);
              },
              title: "Other Accreditations",
              appAsset: AppAssets.achievementIcon,
            ),
            SizedBox(height: 16.h),

            _buildActionableButton(
              onTap: () {
                Get.toNamed(AppRoutes.cardEditPageRoute);
              },
              title: "Card Payment Details ",
              appAsset: AppAssets.cardIcon,
            ),

            SizedBox(height: 16.h),

            _buildActionableButton(
              onTap: () {
                Get.toNamed(AppRoutes.wagesToBePaidRoute);
              },
              title: "Wages to be paid",
              appAsset: AppAssets.bankIcon,
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  GestureDetector _buildActionableButton({
    required VoidCallback? onTap,
    required String title,
    required String appAsset,
    bool isNotification = false,
    bool isLogout = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          SvgPicture.asset(appAsset, width: 42.w, height: 42.h),
          SizedBox(width: 12.w),
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              color: !isLogout ? AppColors.primaryBlack : AppColors.primaryRed,
            ),
          ),
          Spacer(),
          isNotification
              ? GetBuilder<ProfilePageController>(
                  init: ProfilePageController(),
                  builder: (controller) {
                    return Switch(
                      value: controller.notificationOn,
                      onChanged: (value) => controller.toggleNotification(),
                      inactiveTrackColor: AppColors.secondaryGray,
                      inactiveThumbColor: AppColors.primaryWhite,
                    );
                  },
                )
              : Icon(Icons.arrow_forward_ios, size: 24.sp),
        ],
      ),
    );
  }

  Column _buildHeaderSection() {
    return Column(
      children: [
        Center(
          child: Stack(
            children: [
              SizedBox(
                width: 92.w,
                height: 92.h,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primaryBlue),
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      "https://b3262381.smushcdn.com/3262381/wp-content/uploads/2017/04/security-guard-foyer-ssi-crop-sq-1024x675.jpg?lossy=2&strip=1&webp=1",
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Icon(color: AppColors.primaryBlue, Icons.verified),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        Center(
          child: Text(
            "Jhon Marbel",
            style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
