import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/core/constants/app_keys.dart';
import 'package:flutter_security_workforce/app/core/errors/app_exceptions.dart';
import 'package:flutter_security_workforce/app/core/network/api_endpoints.dart';
import 'package:flutter_security_workforce/app/core/network/dio_client.dart';
import 'package:flutter_security_workforce/app/modules/auth/login_page/data/models/login_response_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../routes/app_routes.dart';

class LoginPageController extends GetxController {
  final TextEditingController emailTEC = TextEditingController();
  final TextEditingController passwordTEC = TextEditingController();

  bool obscurePass = true;
  bool rememberMe = false;
  bool signInInProgress = false;

  void toggleRememberMe() {
    rememberMe = !rememberMe;
    update();
  }

  void toggleObscurePass() {
    obscurePass = !obscurePass;
    update();
  }

  Future<void> login({required BuildContext context}) async {
    signInInProgress = true;
    update();

    DioClient dioClient = DioClient();

    try {
      dynamic data = await dioClient.post(
        ApiEndpoints.loginUrl,
        data: {"email": emailTEC.text, "password": passwordTEC.text},
      );

      LoginResponseModel loginResponse = LoginResponseModel.fromJson(data);

      if (rememberMe) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();

        await sharedPreferences.setString(
          AppKeys.loginKey,
          jsonEncode(loginResponse.toJson()),
        );
      }

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      if (loginResponse.access != null) {
        await sharedPreferences.setString(
          AppKeys.accessTokenKey,
          loginResponse.access ?? "",
        );
      }

      // print("sajid testing ${loginResponse}");

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(loginResponse.message ?? ""),
            backgroundColor: AppColors.primaryGreen,
          ),
        );
      }

      if (loginResponse.isProfileCompleted ?? false) {
        print("sajid testing ${loginResponse.isProfileCompleted}");
        Get.offAllNamed(AppRoutes.bottomNavbarRoute);
      } else {
        // print("sajid testing ${loginResponse.verified}");
        Get.offAllNamed(
          AppRoutes.profileVerificationRoute,
          arguments: loginResponse.toJson(),
        );
      }
    } on AppException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message),
            backgroundColor: AppColors.primaryRed,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: AppColors.primaryRed,
          ),
        );
      }
    }

    signInInProgress = false;
    update();
  }

  // Future<void> login({required BuildContext context}) async {
  //   signInInProgress = true;
  //   update();

  //   try {
  //     final dioClient = DioClient();

  //     final data = await dioClient.post(
  //       ApiEndpoints.loginUrl,
  //       data: {"email": emailTEC.text, "password": passwordTEC.text},
  //     );

  //     final loginResponse = LoginResponseModel.fromJson(data);
  //     final prefs = await SharedPreferences.getInstance();

  //     //  Save access token always
  //     if (loginResponse.access != null &&
  //         loginResponse.access!.trim().isNotEmpty) {
  //       await prefs.setString(AppKeys.accessTokenKey, loginResponse.access!);
  //     }

  //     //  Remember Me logic
  //     if (rememberMe) {
  //       await prefs.setString(
  //         AppKeys.loginKey,
  //         jsonEncode(loginResponse.toJson()),
  //       );
  //     } else {
  //       await prefs.remove(AppKeys.loginKey);
  //     }

  //     if (context.mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(loginResponse.message ?? "Login Successful"),
  //           backgroundColor: AppColors.primaryGreen,
  //         ),
  //       );
  //     }

  //     // final candidate = loginResponse.guardDetails?.candidate;
  //     // final gender = candidate?.gender;

  //     // final isFirstTime =
  //     //     candidate == null || gender == null || gender.trim().isEmpty;

  //     // if (isFirstTime) {
  //     //   Get.offAllNamed(
  //     //     AppRoutes.profileVerificationRoute,
  //     //     arguments: loginResponse.toJson(),
  //     //   );
  //     //   return;
  //     // }

  //     // if (loginResponse.verified ?? false) {
  //     //   Get.offAllNamed(AppRoutes.bottomNavbarRoute);
  //     // } else {
  //     //   Get.offAllNamed(AppRoutes.verificationScreen);
  //     // }

  //     if (loginResponse.verified == true) {
  //       Get.offAllNamed(AppRoutes.bottomNavbarRoute);
  //       return;
  //     }

  //     final candidate = loginResponse.guardDetails?.candidate;
  //     final gender = candidate?.gender;

  //     final isFirstTime =
  //         candidate == null || gender == null || gender.trim().isEmpty;

  //     if (isFirstTime) {
  //       Get.offAllNamed(
  //         AppRoutes.profileVerificationRoute,
  //         arguments: loginResponse.toJson(),
  //       );
  //     } else {
  //       Get.offAllNamed(AppRoutes.loginRoute);
  //     }
  //   } catch (e) {
  //     if (context.mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(e.toString()),
  //           backgroundColor: AppColors.primaryRed,
  //         ),
  //       );
  //     }
  //   } finally {
  //     signInInProgress = false;
  //     update();
  //   }
  // }

  // Future<void> login({required BuildContext context}) async {
  //   signInInProgress = true;
  //   update();

  //   try {
  //     final dioClient = DioClient();

  //     final data = await dioClient.post(
  //       ApiEndpoints.loginUrl,
  //       data: {
  //         "email": emailTEC.text.trim(),
  //         "password": passwordTEC.text.trim(),
  //       },
  //     );

  //     final loginResponse = LoginResponseModel.fromJson(data);
  //     final prefs = await SharedPreferences.getInstance();

  //     //  Save access token
  //     if (loginResponse.access != null &&
  //         loginResponse.access!.trim().isNotEmpty) {
  //       await prefs.setString(
  //         AppKeys.accessTokenKey,
  //         loginResponse.access!,
  //       );
  //     }

  //     //  Remember Me logic
  //     if (rememberMe) {
  //       await prefs.setString(
  //         AppKeys.loginKey,
  //         jsonEncode(loginResponse.toJson()),
  //       );
  //     } else {
  //       await prefs.remove(AppKeys.loginKey);
  //     }

  //     //  Success message
  //     if (context.mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(loginResponse.message ?? "Login Successful"),
  //           backgroundColor: AppColors.primaryGreen,
  //         ),
  //       );
  //     }

  //     // ===================== NAVIGATION LOGIC =====================

  //     final candidate = loginResponse.guardDetails?.candidate;
  //     final gender = candidate?.gender;

  //     final isProfileSetupDone =
  //         candidate != null && gender != null && gender.trim().isNotEmpty;

  //     //
  //     if (!isProfileSetupDone) {
  //       Get.offAllNamed(
  //         AppRoutes.profileVerificationRoute,
  //         arguments: loginResponse.toJson(),
  //       );
  //       return;
  //     }

  //     //
  //     Get.offAllNamed(AppRoutes.bottomNavbarRoute);

  //   } catch (e) {
  //     if (context.mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(e.toString()),
  //           backgroundColor: AppColors.primaryRed,
  //         ),
  //       );
  //     }
  //   } finally {
  //     signInInProgress = false;
  //     update();
  //   }
  // }
}
