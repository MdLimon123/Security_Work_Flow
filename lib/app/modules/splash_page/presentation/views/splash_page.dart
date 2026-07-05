import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:securiverse_security_workforce/app/core/constants/app_assets.dart';
import 'package:securiverse_security_workforce/app/modules/splash_page/presentation/controller/splash_page_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashPageController>(
      builder: (controller) {
        return Scaffold(
          body: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: SvgPicture.asset(AppAssets.splashPageHeader),
              ),

              Center(
                child: Image.asset(
                  AppAssets.securiverseIcon,
                  width: 148.w,
                  height: 148.h,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
