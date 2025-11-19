import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/modules/message_page/presentation/controllers/message_page_controller.dart';
import 'package:get/get.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Messages",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.sp),
        ),
        centerTitle: true,
        actions: [Icon(Icons.notifications_outlined)],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              _buildSearchInput(),
              SizedBox(height: 24.h),
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(100.r),
                        child: CachedNetworkImage(
                          imageUrl:
                              "https://avatars.githubusercontent.com/u/69637820?v=4",
                          width: 52.w,
                          height: 52.h,
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error, color: AppColors.primaryRed),
                          placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primaryOrange,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Sajid Hossain",
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "09:03 pm",
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.secondaryTextColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Hey, How are You?",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    // color: AppColors.secondaryTextColor,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  width: 16.w,
                                  height: 16.h,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryLightBlue,
                                    borderRadius: BorderRadius.circular(100.r),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "2",
                                      style: TextStyle(
                                        color: AppColors.primaryWhite,
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  separatorBuilder: (context, index) => SizedBox(height: 16.h),
                  itemCount: 100,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  GetBuilder<MessagePageController> _buildSearchInput() {
    return GetBuilder<MessagePageController>(
      init: MessagePageController(),
      builder: (controller) {
        return TextField(
          controller: controller.searchTEC,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            hintText: "Search anything…",
            hintStyle: TextStyle(color: AppColors.secondaryTextColor),
            contentPadding: EdgeInsets.symmetric(
              vertical: 11.h,
              horizontal: 16.w,
            ),
            prefixIcon: Icon(Icons.search, color: AppColors.primaryGray),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: BorderSide(color: AppColors.primaryBorderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: BorderSide(color: AppColors.primaryBorderColor),
            ),
          ),
        );
      },
    );
  }
}
