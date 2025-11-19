import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/modules/message_page/presentation/controllers/message_page_controller.dart';
import 'package:get/get.dart';

class MessageInbox extends StatelessWidget {
  const MessageInbox({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.messageBG,
      appBar: AppBar(
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100.r),
              child: CachedNetworkImage(
                width: 35.w,
                height: 35.h,
                imageUrl:
                    "https://avatars.githubusercontent.com/u/69637820?v=4",
                errorWidget: (context, url, error) =>
                    Icon(Icons.error, color: AppColors.primaryRed),
              ),
            ),
            SizedBox(width: 14.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sajid Hossain",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryGreen,
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      width: 8.w,
                      height: 8.h,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      "Active",
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.secondaryTextColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                // reverse: true,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 22.h),
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.primaryWhite,
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 24.w,
                              vertical: 5.h,
                            ),
                            child: Text(
                              "Today",
                              style: TextStyle(
                                color: AppColors.secondaryTextColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 56.h),
                      _buildMessageFromOtherSide(),
                      SizedBox(height: 16.h),
                      _buildMessageFromUser(),
                      SizedBox(height: 16.h),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColors.messageBG,
                border: Border(
                  top: BorderSide(color: Colors.grey.shade300, width: 0.5),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                child: Row(
                  children: [
                    Expanded(
                      child: GetBuilder<MessagePageController>(
                        builder: (controller) {
                          return TextField(
                            controller: controller.messageTEC,
                            decoration: InputDecoration(
                              hintText: "Type a message...",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 8.h,
                              ),
                              filled: true,
                              fillColor: AppColors.primaryWhite,
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 8.w),
                    IconButton(
                      icon: Icon(
                        Icons.send,
                        color: AppColors.secondaryNavyBlue,
                      ),
                      onPressed: () {
                        // Add send functionality here
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _buildMessageFromUser() {
    return Row(
      children: [
        SizedBox(width: 8.w),
        SizedBox(width: Get.width / 6),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.secondaryNavyBlue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                topRight: Radius.circular(12.r),
                bottomLeft: Radius.circular(12.r),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.5.h),
              child: Text(
                "Hi there how are you?",
                style: TextStyle(color: AppColors.primaryWhite),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row _buildMessageFromOtherSide() {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(
            "https://avatars.githubusercontent.com/u/69637820?v=4",
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.primaryWhite,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                topRight: Radius.circular(12.r),
                bottomRight: Radius.circular(12.r),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.5.h),
              child: Text("Hi there how are you?"),
            ),
          ),
        ),
        SizedBox(width: Get.width / 6),
      ],
    );
  }
}
