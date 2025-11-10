import 'package:flutter_security_workforce/app/modules/auth/forget_pass_page/presentation/binding/forget_password_page_binding.dart';
import 'package:flutter_security_workforce/app/modules/auth/forget_pass_page/presentation/binding/verify_forget_pass_otp_page_binding.dart';
import 'package:flutter_security_workforce/app/modules/auth/forget_pass_page/presentation/views/forget_password_page.dart';
import 'package:flutter_security_workforce/app/modules/auth/forget_pass_page/presentation/views/verify_forget_pass_otp_page.dart';
import 'package:flutter_security_workforce/app/modules/auth/login_page/presentation/binding/login_page_binding.dart';
import 'package:flutter_security_workforce/app/modules/auth/login_page/presentation/views/login_page.dart';
import 'package:flutter_security_workforce/app/modules/auth/new_password_page/presentation/binding/new_password_page_binding.dart';
import 'package:flutter_security_workforce/app/modules/auth/new_password_page/presentation/views/new_password_page.dart';
import 'package:flutter_security_workforce/app/modules/bottom_navbar/presentation/binding/bottom_navbar_page_binding.dart';
import 'package:flutter_security_workforce/app/modules/bottom_navbar/presentation/views/bottom_navbar_page.dart';
import 'package:flutter_security_workforce/app/modules/my_jobs_page/presentation/binding/my_jobs_page_binding.dart';
import 'package:flutter_security_workforce/app/modules/my_jobs_page/presentation/views/my_jobs_page.dart';
import 'package:flutter_security_workforce/app/modules/on_boarding_page/presentation/bindings/on_boarding_get_started_page_binding.dart';
import 'package:flutter_security_workforce/app/modules/on_boarding_page/presentation/bindings/on_boarding_page_binding.dart';
import 'package:flutter_security_workforce/app/modules/on_boarding_page/presentation/views/on_boarding_get_started_page.dart';
import 'package:flutter_security_workforce/app/modules/on_boarding_page/presentation/views/on_boarding_page.dart';
import 'package:flutter_security_workforce/app/modules/profile_verification_page/presentation/binding/profile_verification_page_binding.dart';
import 'package:flutter_security_workforce/app/modules/profile_verification_page/presentation/views/profile_verification_page.dart';
import 'package:flutter_security_workforce/app/modules/refer_and_benefits_page/binding/refer_and_benefits_page_binding.dart';
import 'package:flutter_security_workforce/app/modules/refer_and_benefits_page/views/refer_and_benefits_page.dart';
import 'package:flutter_security_workforce/app/modules/search_page/binding/search_page_binding.dart';
import 'package:flutter_security_workforce/app/modules/search_page/views/search_page.dart';
import 'package:flutter_security_workforce/app/modules/splash_page/presentation/binding/slpash_page_binding.dart';
import 'package:flutter_security_workforce/app/modules/splash_page/presentation/views/splash_page.dart';
import 'package:flutter_security_workforce/app/modules/subscription_page/binding/subscription_page_binding.dart';
import 'package:flutter_security_workforce/app/modules/subscription_page/views/subscription_page.dart';
import 'package:get/get.dart';
import '../modules/auth/signup_page/presentation/binding/signup_page_binding.dart';
import '../modules/auth/signup_page/presentation/binding/verify_registration_otp_page_binding.dart';
import '../modules/auth/signup_page/presentation/views/signup_page.dart';
import '../modules/auth/signup_page/presentation/views/verify_registration_otp_page.dart';
import '../modules/home_page/presentation/bindings/home_binding.dart';
import '../modules/home_page/presentation/views/home_page.dart';
import 'app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.homeRoute,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),

    GetPage(
      name: AppRoutes.splashRoute,
      page: () => SplashPage(),
      binding: SlpashPageBinding(),
    ),

    GetPage(
      name: AppRoutes.onBoardingGetStartedRoute,
      page: () => OnBoardingGetStartedPage(),
      binding: OnBoardingGetStartedPageBinding(),
    ),

    GetPage(
      name: AppRoutes.onBoardingRoute,
      page: () => OnBoardingPage(),
      binding: OnBoardingPageBinding(),
    ),

    GetPage(
      name: AppRoutes.signupRoute,
      page: () => SignupPage(),
      binding: SignupPageBinding(),
    ),

    GetPage(
      name: AppRoutes.verifyRegistrationOtpRoute,
      page: () => VerifyRegistrationOtpPage(),
      binding: VerifyRegistrationOtpPageBinding(),
    ),

    GetPage(
      name: AppRoutes.loginRoute,
      page: () => LoginPage(),
      binding: LoginPageBinding(),
    ),

    GetPage(
      name: AppRoutes.forgetPassRoute,
      page: () => ForgetPasswordPage(),
      binding: ForgetPasswordPageBinding(),
    ),

    GetPage(
      name: AppRoutes.verifyForgetPassRoute,
      page: () => VerifyForgetPassOtpPage(),
      binding: VerifyForgetPassOtpPageBinding(),
    ),

    GetPage(
      name: AppRoutes.newPassRoute,
      page: () => NewPasswordPage(),
      binding: NewPasswordPageBinding(),
    ),

    GetPage(
      name: AppRoutes.profileVerificationRoute,
      page: () => ProfileVerificationPage(),
      binding: ProfileVerificationPageBinding(),
    ),

    GetPage(
      name: AppRoutes.subscriptionRoute,
      page: () => SubscriptionPage(),
      binding: SubscriptionPageBinding(),
    ),

    GetPage(
      name: AppRoutes.referAndBenefitRoute,
      page: () => ReferAndBenefitsPage(),
      binding: ReferAndBenefitsPageBinding(),
    ),

    GetPage(
      name: AppRoutes.bottomNavbarRoute,
      page: () => BottomNavbarPage(),
      binding: BottomNavbarPageBinding(),
    ),

    GetPage(
      name: AppRoutes.searchPageRoute,
      page: () => SearchPage(),
      binding: SearchPageBinding(),
    ),

    GetPage(
      name: AppRoutes.myJobsRoute,
      page: () => MyJobsPage(),
      binding: MyJobsPageBinding(),
    ),
  ];
}
