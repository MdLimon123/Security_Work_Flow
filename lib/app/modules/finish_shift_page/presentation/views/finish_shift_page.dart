import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_security_workforce/app/core/constants/app_assets.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/core/data/models/job_details_model.dart';
import 'package:flutter_security_workforce/app/modules/finish_shift_page/presentation/controllers/finish_shift_page_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class FinishShiftPage extends StatelessWidget {
  FinishShiftPage({super.key});

  final JobDetailsModel jobDetailsModel = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_outlined),
          ),
        ],
        title: Text(
          "Rate This Company",
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: GetBuilder<FinishShiftPageController>(
          builder: (controller) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "• Communication",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    _buildCommunicationRating(),

                    SizedBox(height: 24.h),

                    Text(
                      "• Payment reliability",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    _buildPaymentRating(),

                    SizedBox(height: 24.h),

                    Text(
                      "• Pay rates",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    _buildPayRates(),

                    SizedBox(height: 24.h),

                    Text(
                      "• Professionalism",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    _buildProfessionalism(),

                    SizedBox(height: 24.h),

                    Text(
                      "• Job Support",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    _buildJobSupport(),

                    SizedBox(height: 24.h),

                    _buildCommentsInput(controller),

                    SizedBox(height: 46.h),

                    _buildLaterAndSubmitButton(context: context, controller),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Row _buildLaterAndSubmitButton(
    FinishShiftPageController controller, {
    required BuildContext context,
  }) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
                side: BorderSide(color: AppColors.secondaryNavyBlue),
              ),
            ),
            onPressed: () {},
            child: Text(
              "Later",
              style: TextStyle(
                color: AppColors.secondaryNavyBlue,
                fontSize: 18.sp,
              ),
            ),
          ),
        ),
        SizedBox(width: 30.w),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondaryNavyBlue,
              foregroundColor: AppColors.primaryWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
            onPressed: () async {
              await controller.submitRating(
                id: jobDetailsModel.id.toString(),
                context: context,
              );
            },
            child: controller.isLoading
                ? CircularProgressIndicator(color: AppColors.primaryWhite)
                : Text(
                    "Submit",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  Column _buildCommentsInput(FinishShiftPageController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Comments",
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 10.h),
        TextFormField(
          controller: controller.commentTextFieldController,
          decoration: InputDecoration(
            hintText: "Enter your comments",
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

  Row _buildJobSupport() {
    return Row(
      children: [
        GetBuilder<FinishShiftPageController>(
          builder: (controller) {
            return RadioGroup(
              onChanged: (value) {
                controller.updateJobSupportSelectedIndex(
                  value: value?.toInt() ?? 5,
                );
              },
              groupValue: controller.jobSupportSelectedIndex,

              child: Row(
                children: [
                  Row(
                    children: [
                      Radio(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: 1,
                        activeColor: AppColors.primaryOrange,
                      ),
                      Text("5", style: TextStyle(fontSize: 16.sp)),
                      SizedBox(width: 1.w),
                      SvgPicture.asset(
                        AppAssets.starIcon,
                        width: 14.w,
                        height: 14.h,
                      ),
                    ],
                  ),
                  Radio(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: 2,
                    activeColor: AppColors.primaryOrange,
                  ),
                  Text("4", style: TextStyle(fontSize: 16.sp)),
                  SizedBox(width: 1.w),
                  SvgPicture.asset(
                    AppAssets.starIcon,
                    width: 14.w,
                    height: 14.h,
                  ),
                  Radio(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: 3,
                    activeColor: AppColors.primaryOrange,
                  ),
                  Text("3", style: TextStyle(fontSize: 16.sp)),
                  SizedBox(width: 1.w),
                  SvgPicture.asset(
                    AppAssets.starIcon,
                    width: 14.w,
                    height: 14.h,
                  ),
                  Radio(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: 4,
                    activeColor: AppColors.primaryOrange,
                  ),
                  Text("2", style: TextStyle(fontSize: 16.sp)),
                  SizedBox(width: 1.w),
                  SvgPicture.asset(
                    AppAssets.starIcon,
                    width: 14.w,
                    height: 14.h,
                  ),

                  Radio(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: 5,
                    activeColor: AppColors.primaryOrange,
                  ),
                  Text("1", style: TextStyle(fontSize: 16.sp)),
                  SizedBox(width: 1.w),
                  SvgPicture.asset(
                    AppAssets.starIcon,
                    width: 14.w,
                    height: 14.h,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Row _buildProfessionalism() {
    return Row(
      children: [
        GetBuilder<FinishShiftPageController>(
          builder: (controller) {
            return RadioGroup(
              onChanged: (value) {
                controller.updateProfessionalismSelectedIndex(
                  value: value?.toInt() ?? 5,
                );
              },
              groupValue: controller.professionalismSelectedIndex,
              child: Row(
                children: [
                  Row(
                    children: [
                      Radio(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: 1,
                        activeColor: AppColors.primaryOrange,
                      ),
                      Text("5", style: TextStyle(fontSize: 16.sp)),
                      SizedBox(width: 1.w),
                      SvgPicture.asset(
                        AppAssets.starIcon,
                        width: 14.w,
                        height: 14.h,
                      ),
                    ],
                  ),
                  Radio(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: 2,
                    activeColor: AppColors.primaryOrange,
                  ),
                  Text("4", style: TextStyle(fontSize: 16.sp)),
                  SizedBox(width: 1.w),
                  SvgPicture.asset(
                    AppAssets.starIcon,
                    width: 14.w,
                    height: 14.h,
                  ),
                  Radio(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: 3,
                    activeColor: AppColors.primaryOrange,
                  ),
                  Text("3", style: TextStyle(fontSize: 16.sp)),
                  SizedBox(width: 1.w),
                  SvgPicture.asset(
                    AppAssets.starIcon,
                    width: 14.w,
                    height: 14.h,
                  ),
                  Radio(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: 4,
                    activeColor: AppColors.primaryOrange,
                  ),
                  Text("2", style: TextStyle(fontSize: 16.sp)),
                  SizedBox(width: 1.w),
                  SvgPicture.asset(
                    AppAssets.starIcon,
                    width: 14.w,
                    height: 14.h,
                  ),

                  Radio(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: 5,
                    activeColor: AppColors.primaryOrange,
                  ),
                  Text("1", style: TextStyle(fontSize: 16.sp)),
                  SizedBox(width: 1.w),
                  SvgPicture.asset(
                    AppAssets.starIcon,
                    width: 14.w,
                    height: 14.h,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Row _buildPayRates() {
    return Row(
      children: [
        GetBuilder<FinishShiftPageController>(
          builder: (controller) {
            return RadioGroup(
              onChanged: (value) {
                controller.updatePayRatesSelectedIndex(
                  value: value?.toInt() ?? 5,
                );
              },
              groupValue: controller.payRatesSelectedIndex,

              child: Row(
                children: [
                  Row(
                    children: [
                      Radio(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: 1,
                        activeColor: AppColors.primaryOrange,
                      ),
                      Text("5", style: TextStyle(fontSize: 16.sp)),
                      SizedBox(width: 1.w),
                      SvgPicture.asset(
                        AppAssets.starIcon,
                        width: 14.w,
                        height: 14.h,
                      ),
                    ],
                  ),
                  Radio(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: 2,
                    activeColor: AppColors.primaryOrange,
                  ),
                  Text("4", style: TextStyle(fontSize: 16.sp)),
                  SizedBox(width: 1.w),
                  SvgPicture.asset(
                    AppAssets.starIcon,
                    width: 14.w,
                    height: 14.h,
                  ),
                  Radio(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: 3,
                    activeColor: AppColors.primaryOrange,
                  ),
                  Text("3", style: TextStyle(fontSize: 16.sp)),
                  SizedBox(width: 1.w),
                  SvgPicture.asset(
                    AppAssets.starIcon,
                    width: 14.w,
                    height: 14.h,
                  ),
                  Radio(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: 4,
                    activeColor: AppColors.primaryOrange,
                  ),
                  Text("2", style: TextStyle(fontSize: 16.sp)),
                  SizedBox(width: 1.w),
                  SvgPicture.asset(
                    AppAssets.starIcon,
                    width: 14.w,
                    height: 14.h,
                  ),

                  Radio(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: 5,
                    activeColor: AppColors.primaryOrange,
                  ),
                  Text("1", style: TextStyle(fontSize: 16.sp)),
                  SizedBox(width: 1.w),
                  SvgPicture.asset(
                    AppAssets.starIcon,
                    width: 14.w,
                    height: 14.h,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Row _buildPaymentRating() {
    return Row(
      children: [
        GetBuilder<FinishShiftPageController>(
          builder: (controller) {
            return RadioGroup(
              onChanged: (value) {
                controller.updatePaymentSelectedIndex(
                  value: value?.toInt() ?? 5,
                );
              },
              groupValue: controller.paymentSelectedIndex,
              child: Row(
                children: [
                  Row(
                    children: [
                      Radio(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: 1,
                        activeColor: AppColors.primaryOrange,
                      ),
                      Text("5", style: TextStyle(fontSize: 16.sp)),
                      SizedBox(width: 1.w),
                      SvgPicture.asset(
                        AppAssets.starIcon,
                        width: 14.w,
                        height: 14.h,
                      ),
                    ],
                  ),
                  Radio(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: 2,
                    activeColor: AppColors.primaryOrange,
                  ),
                  Text("4", style: TextStyle(fontSize: 16.sp)),
                  SizedBox(width: 1.w),
                  SvgPicture.asset(
                    AppAssets.starIcon,
                    width: 14.w,
                    height: 14.h,
                  ),
                  Radio(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: 3,
                    activeColor: AppColors.primaryOrange,
                  ),
                  Text("3", style: TextStyle(fontSize: 16.sp)),
                  SizedBox(width: 1.w),
                  SvgPicture.asset(
                    AppAssets.starIcon,
                    width: 14.w,
                    height: 14.h,
                  ),
                  Radio(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: 4,
                    activeColor: AppColors.primaryOrange,
                  ),
                  Text("2", style: TextStyle(fontSize: 16.sp)),
                  SizedBox(width: 1.w),
                  SvgPicture.asset(
                    AppAssets.starIcon,
                    width: 14.w,
                    height: 14.h,
                  ),

                  Radio(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: 5,
                    activeColor: AppColors.primaryOrange,
                  ),
                  Text("1", style: TextStyle(fontSize: 16.sp)),
                  SizedBox(width: 1.w),
                  SvgPicture.asset(
                    AppAssets.starIcon,
                    width: 14.w,
                    height: 14.h,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Row _buildCommunicationRating() {
    return Row(
      children: [
        GetBuilder<FinishShiftPageController>(
          builder: (controller) {
            return RadioGroup(
              onChanged: (value) {
                controller.updateCommunicationSelectedIndex(
                  value: value?.toInt() ?? 5,
                );
              },
              groupValue: controller.communicationSelectedIndex,

              child: Row(
                children: [
                  Row(
                    children: [
                      Radio(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: 1,
                        activeColor: AppColors.primaryOrange,
                      ),
                      Text("5", style: TextStyle(fontSize: 16.sp)),
                      SizedBox(width: 1.w),
                      SvgPicture.asset(
                        AppAssets.starIcon,
                        width: 14.w,
                        height: 14.h,
                      ),
                    ],
                  ),
                  Radio(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: 2,
                    activeColor: AppColors.primaryOrange,
                  ),
                  Text("4", style: TextStyle(fontSize: 16.sp)),
                  SizedBox(width: 1.w),
                  SvgPicture.asset(
                    AppAssets.starIcon,
                    width: 14.w,
                    height: 14.h,
                  ),
                  Radio(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: 3,
                    activeColor: AppColors.primaryOrange,
                  ),
                  Text("3", style: TextStyle(fontSize: 16.sp)),
                  SizedBox(width: 1.w),
                  SvgPicture.asset(
                    AppAssets.starIcon,
                    width: 14.w,
                    height: 14.h,
                  ),
                  Radio(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: 4,
                    activeColor: AppColors.primaryOrange,
                  ),
                  Text("2", style: TextStyle(fontSize: 16.sp)),
                  SizedBox(width: 1.w),
                  SvgPicture.asset(
                    AppAssets.starIcon,
                    width: 14.w,
                    height: 14.h,
                  ),

                  Radio(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: 5,
                    activeColor: AppColors.primaryOrange,
                  ),
                  Text("1", style: TextStyle(fontSize: 16.sp)),
                  SizedBox(width: 1.w),
                  SvgPicture.asset(
                    AppAssets.starIcon,
                    width: 14.w,
                    height: 14.h,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
