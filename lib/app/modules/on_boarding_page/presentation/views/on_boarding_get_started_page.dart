import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_security_workforce/app/core/constants/app_assets.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/routes/app_routes.dart';
import 'package:get/get.dart';

class OnBoardingGetStartedPage extends StatelessWidget {
  const OnBoardingGetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double imageSize;

                  if (constraints.maxWidth > 600) {
                    imageSize = 250;
                  } else {
                    imageSize = 148;
                  }

                  return Image.asset(
                    AppAssets.securiverseIcon,
                    width: imageSize,
                    height: imageSize,
                  );
                },
              ),
            ),
            SizedBox(height: 24.h),
            Center(
              child: Text(
                "Securiverse",
                style: TextStyle(
                  fontSize: 48.sp,
                  color: AppColors.secondaryNavyBlue,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Center(
              child: Text(
                "Opportunity. On Demand",
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.primarySteelBlue,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            // SizedBox(height: 20),
            // Center(
            //   child: Text(
            //     "Take control of Your Career. Earn money on Your Terms .Create Your Account now!",

            //     style: TextStyle(
            //       fontSize: 16.sp,
            //       color: AppColors.primarySteelBlue,
            //       fontWeight: FontWeight.w700,
            //     ),
            //     textAlign: TextAlign.center,
            //   ),
            // ),

            SizedBox(height: 70),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.loginRoute);
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(color: AppColors.primaryOrange),
                  child: Center(
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryWhite,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
