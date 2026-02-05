import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_security_workforce/app/core/constants/app_assets.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ReferAndBenefitsPage extends StatelessWidget {
  const ReferAndBenefitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Refer and Get Benefits"),
        leading: IconButton(
          onPressed: () {
            if (context.mounted) {
              Get.back();
            }
          },
          icon: Icon(Icons.close),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "1. Copy code",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.secondaryNavyBlue,
                  ),
                ),

                Text(
                  "2. Share with Companies and Security Operatives",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.secondaryNavyBlue,
                  ),
                ),

                Text(
                  "3. Enjoy Upgrades, Discounts and other benefits",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.secondaryNavyBlue,
                  ),
                ),

                Image.asset(AppAssets.giftImage),

                SizedBox(height: 8.h),

                Center(
                  child: Text(
                    "Your referral link:",
                    style: TextStyle(
                      fontSize: 24.sp,
                      color: AppColors.secondaryNavyBlue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                SizedBox(height: 24.h),

                DottedBorder(
                  options: RoundedRectDottedBorderOptions(
                    color: AppColors.primaryGray,
                    strokeWidth: 1,
                    radius: Radius.circular(12.r),
                  ),

                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                      vertical: 3.h,
                    ),
                    decoration: BoxDecoration(color: AppColors.primaryWhite),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "https://example.com/signin/?refer_token...",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Clipboard.setData(
                              ClipboardData(
                                text:
                                    "https://example.com/signin/?refer_token...",
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Copied ✅"),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: SvgPicture.asset(
                              AppAssets.copyClipboardIcon,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 32.h),
                Text(
                  "Share your referral code with your friends and get benefits.",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                    color: AppColors.secondaryTextColor,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 22.h),

                Center(
                  child: SizedBox(
                    width: 217.w,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondaryNavyBlue,
                        foregroundColor: AppColors.primaryWhite,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      onPressed: () {},
                      child: Text("Invite friends"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
