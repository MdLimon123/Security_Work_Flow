import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_security_workforce/app/modules/auth/new_password_page/presentation/controllers/new_password_page_controller.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/constants/app_colors.dart';

class NewPasswordPage extends StatelessWidget {
  const NewPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.sp),
            child: GetBuilder<NewPasswordPageController>(
              builder: (controller) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                            text: "Reset ",
                            style: TextStyle(
                              color: AppColors.secondaryNavyBlue,
                            ),
                          ),
                          TextSpan(
                            text: "Password",
                            style: TextStyle(color: AppColors.primaryOrange),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 48.h),

                    _buildPasswordInput(controller),

                    SizedBox(height: 16.h),

                    _buildConfirmPasswordInput(controller),

                    SizedBox(height: 32.h),

                    _buildResetPasswordButton(context: context),

                    SizedBox(height: 16.h),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Column _buildPasswordInput(NewPasswordPageController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "New Password",
          style: TextStyle(fontSize: 16.sp, color: AppColors.primaryBlack),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller.passwordTec,
          obscureText: controller.obscurePass,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () {
                controller.toggleObscurePass();
              },
              icon: Icon(
                controller.obscurePass
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
              ),
            ),
            hintText: "Enter your password",
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
      ],
    );
  }

  Column _buildConfirmPasswordInput(NewPasswordPageController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Confirm Password",
          style: TextStyle(fontSize: 16.sp, color: AppColors.primaryBlack),
        ),
        SizedBox(height: 8.h),

        TextFormField(
          controller: controller.confirmPasswordTec,
          obscureText: controller.obscureConfirmPass,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () {
                controller.toggleObscureConfirmPass();
              },
              icon: Icon(
                controller.obscureConfirmPass
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
              ),
            ),
            hintText: "Re-type your password",
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
      ],
    );
  }

  SizedBox _buildResetPasswordButton({required BuildContext context}) {
    return SizedBox(
      width: double.infinity,
      child: GetBuilder<NewPasswordPageController>(
        builder: (controller) {
          return ElevatedButton(
            onPressed: () async {
              await controller.reset(
                context: context,
                accessToken: Get.arguments,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondaryNavyBlue,
              foregroundColor: AppColors.primaryWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
            child: controller.resetPassInProgress
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryWhite,
                    ),
                  )
                : Text(
                    "Reset Password",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          );
        },
      ),
    );
  }
}
