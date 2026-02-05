import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_security_workforce/app/core/constants/app_assets.dart';
import 'package:flutter_security_workforce/app/routes/app_routes.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/app_colors.dart';
import '../controllers/signup_page_controller.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.sp),
            child: Column(
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
                        text: "Create ",
                        style: TextStyle(color: AppColors.secondaryNavyBlue),
                      ),
                      TextSpan(
                        text: "Your Account",
                        style: TextStyle(color: AppColors.primaryOrange),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 48.h),

                GetBuilder<SignupPageController>(
                  builder: (controller) {
                    return Form(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildNameInput(controller),
                          SizedBox(height: 16.h),
                          _buildSirNmaeInput(),
                          SizedBox(height: 16.h),
                          _buildEmailInput(controller),
                          SizedBox(height: 16.h),
                          _buildPasswordInput(controller),
                          SizedBox(height: 16.h),
                          _buildConfirmPasswordInput(controller),
                          // SizedBox(height: 16.h),
                          // _buildReferInput(controller),
                          SizedBox(height: 32.h),
                          _buildSignupButton(context: context),
                          SizedBox(height: 16.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Already have an account? "),

                              InkWell(
                                onTap: () {
                                  Get.toNamed(AppRoutes.loginRoute);
                                },
                                child: Text(
                                  "Sign in",
                                  style: TextStyle(
                                    color: AppColors.primaryOrange,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _buildNameInput(SignupPageController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "First Name",
          style: TextStyle(fontSize: 16.sp, color: AppColors.primaryBlack),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller.nameTec,
          keyboardType: TextInputType.text,

          decoration: InputDecoration(
            hintText: "First Name as it appears on your Security Licence",
            hintStyle: TextStyle(color: AppColors.primaryGray, fontSize: 14),
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

  Column _buildSirNmaeInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Surname",
          style: TextStyle(fontSize: 16.sp, color: AppColors.primaryBlack),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          keyboardType: TextInputType.text,

          decoration: InputDecoration(
            hintText: "Surname as it appears on your Security Licence",
            hintStyle: TextStyle(color: AppColors.primaryGray, fontSize: 14),
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

  // Column _buildReferInput(SignupPageController controller) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         "Refer code (optional)",
  //         style: TextStyle(fontSize: 16.sp, color: AppColors.primaryBlack),
  //       ),
  //       SizedBox(height: 8.h),
  //       TextFormField(
  //         controller: controller.referTec,
  //         decoration: InputDecoration(
  //           hintText: "Refer code",
  //           hintStyle: TextStyle(color: AppColors.primaryGray),
  //           enabledBorder: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(12.r),
  //             borderSide: BorderSide(color: AppColors.secondaryWhite),
  //           ),
  //           focusedBorder: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(12.r),
  //             borderSide: BorderSide(color: AppColors.secondaryWhite),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  SizedBox _buildSignupButton({required BuildContext context}) {
    return SizedBox(
      width: double.infinity,
      child: GetBuilder<SignupPageController>(
        builder: (controller) {
          return ElevatedButton(
            onPressed: () async {
              await controller.signup(context: context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondaryNavyBlue,
              foregroundColor: AppColors.primaryWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
            child: controller.signupInProgress
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryWhite,
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    "Sign Up",
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

  Column _buildConfirmPasswordInput(SignupPageController controller) {
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
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please confirm your password";
            }
            if (value != controller.passwordTec.text) {
              return "Passwords do not match";
            }
            return null;
          },
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: controller.toggleObscureConfirmPass,
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
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }

  Column _buildPasswordInput(SignupPageController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Password",
          style: TextStyle(fontSize: 16.sp, color: AppColors.primaryBlack),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller.passwordTec,
          obscureText: controller.obscurePass,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Password is required";
            }
            if (value.length < 8) {
              return "Password must be at least 8 characters long";
            }
            if (!RegExp(r'[A-Z]').hasMatch(value)) {
              return "Must contain at least one uppercase letter";
            }
            if (!RegExp(r'[a-z]').hasMatch(value)) {
              return "Must contain at least one lowercase letter";
            }
            if (!RegExp(r'[0-9]').hasMatch(value)) {
              return "Must contain at least one number";
            }
            if (!RegExp(
              r'[!@#\$&*~%^()_+\-=\[\]{};:"\\|,.<>\/?]',
            ).hasMatch(value)) {
              return "Must contain at least one special character";
            }
            return null;
          },
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: controller.toggleObscurePass,
              icon: Icon(
                controller.obscurePass
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
              ),
            ),
            hintText: "Enter your password",
            hintStyle: TextStyle(color: AppColors.primaryGray),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AppColors.secondaryWhite),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AppColors.secondaryWhite),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AppColors.secondaryWhite),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }

  Column _buildEmailInput(SignupPageController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Email Address",
          style: TextStyle(fontSize: 16.sp, color: AppColors.primaryBlack),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller.emailTec,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: "Enter your email address",
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
