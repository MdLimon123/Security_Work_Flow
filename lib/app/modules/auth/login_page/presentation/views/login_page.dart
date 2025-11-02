import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_security_workforce/app/modules/auth/login_page/presentation/controllers/login_page_controller.dart';
import 'package:flutter_security_workforce/app/routes/app_routes.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/constants/app_colors.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: GetBuilder<LoginPageController>(
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
                            text: "Login to ",
                            style: TextStyle(
                              color: AppColors.secondaryNavyBlue,
                            ),
                          ),
                          TextSpan(
                            text: "your Account",
                            style: TextStyle(color: AppColors.primaryOrange),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 48.h),

                    _buildEmailInput(controller),

                    SizedBox(height: 16.h),

                    _buildPasswordInput(controller),
                    SizedBox(height: 12.h),

                    Row(
                      children: [
                        SizedBox(
                          width: 24.w,
                          height: 24.h,
                          child: Checkbox(
                            value: controller.rememberMe,
                            onChanged: (value) => controller.toggleRememberMe(),
                            activeColor: AppColors.secondaryNavyBlue,
                          ),
                        ),

                        SizedBox(width: 12.w),

                        Text(
                          "Remember me ",
                          style: TextStyle(color: AppColors.primaryBlack),
                        ),

                        Spacer(),
                        InkWell(
                          onTap: () {
                            Get.toNamed(AppRoutes.forgetPassRoute);
                          },
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(color: AppColors.primaryOrange),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 32.h),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.offAllNamed(AppRoutes.profileVerificationRoute);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondaryNavyBlue,
                          foregroundColor: AppColors.primaryWhite,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                        ),
                        child: Text(
                          "Sign In",
                          style: TextStyle(color: AppColors.primaryWhite),
                        ),
                      ),
                    ),

                    SizedBox(height: 16.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don’t have an account? ",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed(AppRoutes.signupRoute);
                          },
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                              color: AppColors.primaryOrange,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Column _buildEmailInput(LoginPageController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Email",
          style: TextStyle(fontSize: 16.sp, color: AppColors.secondaryNavyBlue),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          controller: controller.emailTEC,
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
      ],
    );
  }

  Column _buildPasswordInput(LoginPageController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Password",
          style: TextStyle(fontSize: 16.sp, color: AppColors.secondaryNavyBlue),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller.passwordTEC,
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
            hintText: "********",
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
}
