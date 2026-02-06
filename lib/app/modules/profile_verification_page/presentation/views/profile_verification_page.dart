import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_security_workforce/app/core/constants/app_assets.dart';
import 'package:flutter_security_workforce/app/modules/profile_verification_page/presentation/controllers/profile_verification_page_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProfileVerificationPage extends StatelessWidget {
  const ProfileVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GetBuilder<ProfileVerificationPageController>(
          builder: (controller) {
            return controller.pageIndex != 0
                ? IconButton(
                    onPressed: () {
                      controller.decreasePageIndex();
                    },
                    icon: Icon(Icons.arrow_back),
                  )
                : SizedBox.shrink();
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: GetBuilder<ProfileVerificationPageController>(
            builder: (controller) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 35),
                      child: SvgPicture.asset(
                        AppAssets.getProfileVerifyProgressImg(
                          progressCompleted: controller.pageIndex,
                        ),
                      ),
                    ),

                    SizedBox(height: 34.h),
                    controller.pages[controller.pageIndex],
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
