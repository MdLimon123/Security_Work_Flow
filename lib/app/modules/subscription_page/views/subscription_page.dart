import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_security_workforce/app/core/constants/app_assets.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/routes/app_routes.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Operative Subscription"),
        leading: IconButton(
          onPressed: () {
            if (context.mounted) {
              Get.back();
            }
          },
          icon: Icon(Icons.close),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Join Now!",
                  style: TextStyle(
                    fontSize: 32.sp,
                    color: AppColors.secondaryNavyBlue,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "To receive job notifications and apply for available shifts, you’ll need to subscribe to Securiverse.",
                  style: TextStyle(color: AppColors.secondaryTextColor),
                ),
                SizedBox(height: 16.h),

                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "\$6",
                        style: TextStyle(
                          color: AppColors.primaryOrange,
                          fontSize: 36.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: "/per month",
                        style: TextStyle(
                          color: AppColors.secondaryTextColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16.h),

                Text(
                  "Benefits:",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 16.h),

                _buildBenefitElement(title: "Take control of your income"),
                SizedBox(height: 12.h),
                _buildBenefitElement(title: "Fast track your career"),
                SizedBox(height: 12.h),
                _buildBenefitElement(
                  title: "Access to thousands of jobs on your terms",
                ),
                SizedBox(height: 12.h),
                _buildBenefitElement(
                  title:
                      "Access hundreds of verified companies and expand your network",
                ),
                SizedBox(height: 20.h),
                _buildSubscribeButton(),
                SizedBox(height: 10.h),

                Center(
                  child: InkWell(
                    onTap: () {},
                    child: Text(
                      "Do It Later",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                        color: AppColors.secondaryNavyBlue,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 24.h),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    "You can subscribe now or choose “Do it later” — but you’ll need an active subscription before receiving or applying for any job",
                    style: TextStyle(color: AppColors.secondaryTextColor),
                    textAlign: TextAlign.center,
                  ),
                ),

                SizedBox(height: 12.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox _buildSubscribeButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Get.toNamed(AppRoutes.referAndBenefitRoute);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondaryNavyBlue,
          foregroundColor: AppColors.primaryWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        child: Text(
          "Subscribe Now",
          style: TextStyle(color: AppColors.primaryWhite),
        ),
      ),
    );
  }

  Row _buildBenefitElement({required String title}) {
    return Row(
      children: [
        SvgPicture.asset(
          AppAssets.orangeCircleTickIcon,
          width: 16.w,
          height: 16.h,
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(title, style: TextStyle(fontSize: 16.sp)),
        ),
      ],
    );
  }
}
