import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/core/network/api_endpoints.dart';
import 'package:flutter_security_workforce/app/modules/message_page/presentation/controllers/message_inbox_page_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MessageInbox extends StatelessWidget {
  MessageInbox({super.key});

  final controller = Get.put(MessageInboxPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.messageBG,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            // Connection status indicator
            Obx(() => controller.isConnected.value
                ? SizedBox.shrink()
                : Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 4.h),
              color: Colors.orange,
              child: Text(
                'Reconnecting...',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 12.sp),
              ),
            )),

            // Messages list
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryOrange,
                    ),
                  );
                }

                if (controller.messages.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          size: 64.w,
                          color: AppColors.secondaryTextColor,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'No messages yet',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.secondaryTextColor,
                          ),
                        ),
                        Text(
                          'Start the conversation!',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.secondaryTextColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  controller: controller.scrollController,
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    final message = controller.messages[index];
                    final showDate = index == 0 ||
                        !_isSameDay(
                          message.timestamp,
                          controller.messages[index - 1].timestamp,
                        );

                    return Column(
                      children: [
                        if (showDate) _buildDateSeparator(message.timestamp),
                        if (showDate) SizedBox(height: 16.h),
                        _buildMessageBubble(message),
                        SizedBox(height: 12.h),
                      ],
                    );
                  },
                );
              }),
            ),

            // Message input
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100.r),
            child: controller.participantImage.isNotEmpty
                ? CachedNetworkImage(
                    width: 35.w,
                    height: 35.h,
                    imageUrl: "${ApiEndpoints.getBaseUrl}${controller.participantImage}",
                    errorWidget: (context, url, error) =>
                        Icon(Icons.person, color: AppColors.primaryGray),
                    placeholder: (context, url) => CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.primaryOrange,
                    ),
                  )
                : Icon(Icons.person, size: 35.w, color: AppColors.primaryGray),
          ),
          SizedBox(width: 14.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.participantName,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Obx(() => Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: controller.isConnected.value
                          ? AppColors.primaryGreen
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                    width: 8.w,
                    height: 8.h,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    controller.isConnected.value ? "Active" : "Offline",
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondaryTextColor,
                    ),
                  ),
                ],
              )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDateSeparator(DateTime date) {
    String dateText;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(date.year, date.month, date.day);

    if (messageDate == today) {
      dateText = 'Today';
    } else if (messageDate == today.subtract(Duration(days: 1))) {
      dateText = 'Yesterday';
    } else {
      dateText = DateFormat('MMM dd, yyyy').format(date);
    }

    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryWhite,
          borderRadius: BorderRadius.circular(16.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 5.h),
        child: Text(
          dateText,
          style: TextStyle(
            color: AppColors.secondaryTextColor,
            fontSize: 12.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    if (message.isMe) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
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
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    message.text,
                    style: TextStyle(
                      color: AppColors.primaryWhite,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    DateFormat('h:mm a').format(message.timestamp),
                    style: TextStyle(
                      color: AppColors.primaryWhite.withOpacity(0.7),
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          controller.participantImage.isNotEmpty
              ? CircleAvatar(
                  radius: 16.r,
                  backgroundImage: NetworkImage(
                    "${ApiEndpoints.getBaseUrl}${controller.participantImage}",
                  ),
                )
              : CircleAvatar(
                  radius: 16.r,
                  child: Icon(Icons.person, size: 16.w),
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
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    DateFormat('h:mm a').format(message.timestamp),
                    style: TextStyle(
                      color: AppColors.secondaryTextColor,
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: Get.width / 6),
        ],
      );
    }
  }

  Widget _buildMessageInput() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.messageBG,
        border: Border(
          top: BorderSide(color: Colors.grey.shade300, width: 0.5),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller.messageTEC,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => controller.sendMessage(),
              decoration: InputDecoration(
                hintText: "Type a message...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: AppColors.secondaryNavyBlue),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 12.h,
                ),
                filled: true,
                fillColor: AppColors.primaryWhite,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Obx(() => Container(
            decoration: BoxDecoration(
              color: controller.isConnected.value
                  ? AppColors.secondaryNavyBlue
                  : Colors.grey,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: IconButton(
              icon: Icon(Icons.send, color: Colors.white),
              onPressed: controller.isConnected.value
                  ? controller.sendMessage
                  : null,
            ),
          )),
        ],
      ),
    );
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}