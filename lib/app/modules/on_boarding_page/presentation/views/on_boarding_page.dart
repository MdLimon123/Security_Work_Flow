import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_security_workforce/app/core/constants/app_assets.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/routes/app_routes.dart';

import 'package:get/get.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Image.asset(
            AppAssets.securityGuardImg,
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
          // BackdropFilter with gradient for darkening effect at the bottom
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    // Top part (transparent)
                    AppColors.primaryBlack,
                    // Bottom part (darker)
                  ],
                  stops: [0.01, 1.0], // Gradual change towards the bottom
                ),
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment(0, 5),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 36.sp,
                            fontWeight: FontWeight.w700,
                          ),
                          children: [
                            TextSpan(
                              text: "Your Business, ",
                              style: TextStyle(color: AppColors.primaryWhite),
                            ),
                            TextSpan(
                              text: "Your Career, ",
                              style: TextStyle(color: AppColors.primaryOrange),),
                            TextSpan(
                              text: "Your Opportunity",
                              style: TextStyle(color: AppColors.primaryOrange),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 90),
                    Text(
                      "Connecting the Security Industry through trust, skill & availability ",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.primaryWhite,
                      ),
                    ),
                    SizedBox(height: 32.h),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.loginRoute);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryOrange,
                          foregroundColor: AppColors.primaryWhite,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          "Login as Operative",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    // SizedBox(height: 16.h),
                    // SizedBox(
                    //   width: double.infinity,
                    //   child: ElevatedButton(
                    //     onPressed: () {},
                    //     style: ElevatedButton.styleFrom(
                    //       backgroundColor: AppColors.primaryOrange,
                    //       foregroundColor: AppColors.primaryWhite,
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(12.r),
                    //       ),
                    //     ),
                    //     child: Text(
                    //       "Login as Company",
                    //       style: TextStyle(
                    //         fontSize: 16.sp,
                    //         fontWeight: FontWeight.w600,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don’t have an account? ",
                          style: TextStyle(color: AppColors.primaryWhite),
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed(AppRoutes.signupRoute);
                          },
                          child: Text(
                            "Create one here",
                            style: TextStyle(color: AppColors.primaryOrange),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
