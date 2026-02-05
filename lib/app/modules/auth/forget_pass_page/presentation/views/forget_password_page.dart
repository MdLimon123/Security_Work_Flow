import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_security_workforce/app/modules/auth/forget_pass_page/presentation/controllers/forget_password_page_controller.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/constants/app_colors.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.sp),
            child: Column(
              children: [
                Center(child: Image.asset(AppAssets.securiverseIcon)),

                SizedBox(height: 56.h),

                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 40.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    children: [
                      TextSpan(
                        text: "Forget Password? ",
                        style: TextStyle(color: AppColors.secondaryNavyBlue),
                      ),
                      TextSpan(
                        text: "Enter Your Email",
                        style: TextStyle(color: AppColors.primaryOrange),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20.h),
                GetBuilder<ForgetPasswordPageController>(
                  builder: (controller) {
                    return _buildEmailInput(controller, context: context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _buildEmailInput(
    ForgetPasswordPageController controller, {
    required BuildContext context,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Email",
          style: TextStyle(fontSize: 16.sp, color: AppColors.primaryBlack),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          controller: controller.emailTec,
          decoration: InputDecoration(
            hintText: "name@gmail.com",
            hintStyle: TextStyle(color: AppColors.primaryGray),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AppColors.secondaryWhite),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AppColors.secondaryWhite),
            ),
          ),
        ),
        SizedBox(height: 20.h),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              await controller.forgetPass(context: context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondaryNavyBlue,
              foregroundColor: AppColors.primaryWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
            child: controller.forgetPassInProgress
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryWhite,
                    ),
                  )
                : Text(
                    "Send OTP",
                    style: TextStyle(color: AppColors.primaryWhite),
                  ),
          ),
        ),
      ],
    );
  }
}
