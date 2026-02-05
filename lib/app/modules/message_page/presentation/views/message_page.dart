import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/core/network/api_endpoints.dart';
import 'package:flutter_security_workforce/app/modules/message_page/presentation/controllers/message_page_controller.dart';
import 'package:flutter_security_workforce/app/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(AppRoutes.notificationRoute);
            },
            icon: Icon(Icons.notifications_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              // _buildSearchInput(),
              // SizedBox(height: 24.h),
              _buildMessageList(),
            ],
          ),
        ),
      ),
    );
  }

  Expanded _buildMessageList() {
    return Expanded(
      child: GetBuilder<MessagePageController>(
        builder: (controller) {
          return ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              // String formattedTime = "";
              try {
                if (controller
                        .chatlistModel
                        .data?[index]
                        .lastMessage
                        ?.createdAt !=
                    null) {
                  // formattedTime = DateFormat('ha').format(controller.chatlistModel.data?[index].lastMessage!.createdAt!);
                }
              } catch (e) {
                // Handle parsing error if needed
              }
              return InkWell(
                onTap: () {
                  final chatData = controller.chatlistModel.data?[index];
                  if (chatData == null) return;

                  Get.toNamed(
                    AppRoutes.messageInboxRoute,
                    arguments: {
                      'conversation_id': chatData.id?.toString() ?? '',
                      'participant_name':
                          chatData.participants?[0].firstName ?? 'Unknown',
                      'participant_image':
                          chatData.participants?[0].image ?? '',
                    },
                  )?.then((_) {
                    // Refresh chat list when returning from conversation
                    controller.fetchChatList();
                  });
                },
                child: Row(
                  children: [
                    SizedBox(width: 12.w),
                    ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(100.r),
                      child: CachedNetworkImage(
                        imageUrl:
                            "${ApiEndpoints.getBaseUrl}${controller.chatlistModel.data?[index].participants![0].image}",
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
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${controller.chatlistModel.data?[index].participants?[0].firstName}",
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                              Text(
                                controller
                                            .chatlistModel
                                            .data?[index]
                                            .lastMessage
                                            ?.createdAt !=
                                        null
                                    ? DateFormat('hh:mm a').format(
                                        controller
                                            .chatlistModel
                                            .data![index]
                                            .lastMessage!
                                            .createdAt!,
                                      )
                                    : '',
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
                              Expanded(
                                child: Text(
                                  controller
                                          .chatlistModel
                                          .data?[index]
                                          .lastMessage
                                          ?.text ??
                                      "",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    // color: AppColors.secondaryTextColor,
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
              );
            },
            separatorBuilder: (context, index) => SizedBox(height: 16.h),
            itemCount: controller.chatlistModel.data?.length ?? 0,
          );
        },
      ),
    );
  }
}
