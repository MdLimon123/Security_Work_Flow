import 'package:another_xlider/another_xlider.dart';
import 'package:another_xlider/enums/tooltip_direction_enum.dart';
import 'package:another_xlider/models/handler.dart';
import 'package:another_xlider/models/tooltip/tooltip.dart';
import 'package:another_xlider/models/tooltip/tooltip_box.dart';
import 'package:another_xlider/models/tooltip/tooltip_position_offset.dart';
import 'package:another_xlider/models/trackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_security_workforce/app/core/constants/app_assets.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/modules/search_page/controllers/search_page_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Search", style: TextStyle(fontSize: 20.sp)),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: GetBuilder<SearchPageController>(
              builder: (controller) {
                return Column(
                  children: [
                    _buildFilterSection(controller),
                    SizedBox(height: 24.h),
                    _buildJobList(),
                    SizedBox(height: 12.h),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  ListView _buildJobList() {
    return ListView.separated(
      shrinkWrap: true,
      primary: false,
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: AppColors.primaryBorderColor),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.5.w, vertical: 8.5.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(AppAssets.securityIcon),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      "Need An Experienced Night Security Guard",
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: AppColors.secondaryNavyBlue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 19.h),

              Row(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Posted In ",
                          style: TextStyle(
                            color: AppColors.secondaryTextColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: "Night Security Shift",
                          style: TextStyle(
                            color: AppColors.secondaryNavyBlue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Spacer(),
                  Column(
                    children: [
                      Text(
                        "Shift Date: ",
                        style: TextStyle(
                          color: AppColors.secondaryNavyBlue,
                          fontSize: 12.sp,
                        ),
                      ),
                      Text(
                        "20 Sep,2025",
                        style: TextStyle(
                          color: AppColors.secondaryTextColor,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 32.h),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "---",
                        style: TextStyle(
                          fontSize: 24.sp,
                          color: AppColors.primaryOrange,
                        ),
                      ),
                      Text(
                        "Negotiate",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.secondaryNavyBlue,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 24.w),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.openJobsDetailsRoute);
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          side: BorderSide(color: AppColors.secondaryNavyBlue),
                        ),
                      ),
                      child: Text(
                        "Details",
                        style: TextStyle(color: AppColors.secondaryNavyBlue),
                      ),
                    ),
                  ),

                  SizedBox(width: 12.w),

                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        backgroundColor: AppColors.secondaryNavyBlue,
                        foregroundColor: AppColors.primaryWhite,
                      ),
                      onPressed: () {
                        Get.dialog(
                          Material(
                            color: Colors.black45,
                            child: Center(
                              child: Container(
                                width: Get.width * 0.85,
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Text(
                                        "Fit for Duty Confirmation",
                                        style: TextStyle(
                                          fontSize: 24.sp,
                                          color: AppColors.secondaryNavyBlue,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 16),
                                    Text(
                                      "I confirm that:",
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        color: AppColors.secondaryNavyBlue,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 12),

                                    _buildBullet(
                                      "I hold the correct and current license(s) to perform this task.",
                                    ),
                                    _buildBullet(
                                      "I have no injuries preventing me from completing this or related tasks.",
                                    ),
                                    _buildBullet(
                                      "I am free from alcohol or intoxication (including medication).",
                                    ),
                                    _buildBullet(
                                      "I am sufficiently rested and not affected by illness or fatigue.",
                                    ),
                                    _buildBullet(
                                      "I understand the job requirements and am capable of performing my duties.",
                                    ),

                                    const SizedBox(height: 28),

                                    Row(
                                      children: [
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () => Get.back(),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  AppColors.primaryRed,
                                              foregroundColor:
                                                  AppColors.primaryWhite,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            child: const Text("Cancel"),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  AppColors.primaryGreen,
                                              foregroundColor:
                                                  AppColors.primaryWhite,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            child: const Text("Confirm"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      child: Text("Apply"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      separatorBuilder: (context, index) => SizedBox(height: 16.h),
      itemCount: 20,
    );
  }

  Widget _buildBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 6, right: 8),
            decoration: BoxDecoration(
              color: AppColors.primaryOrange,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  Row _buildFilterSection(SearchPageController controller) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller.searchTEC,
            keyboardType: TextInputType.webSearch,
            textInputAction: TextInputAction.search,
            onSubmitted: (value) {},
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 11.h,
              ),
              prefixIcon: Icon(
                Icons.search,
                color: AppColors.secondaryTextColor,
              ),
              hintStyle: TextStyle(color: AppColors.secondaryTextColor),
              hintText: "Search for jobs or shifts…",
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide(color: AppColors.primaryBorderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide(color: AppColors.primaryBorderColor),
              ),
            ),
          ),
        ),
        SizedBox(width: 13.w),
        GestureDetector(
          onTap: () {
            Get.bottomSheet(
              DraggableScrollableSheet(
                expand: false,
                initialChildSize: 0.75,
                // 50% of screen
                minChildSize: 0.3,
                maxChildSize: 0.95,
                builder: (context, scrollController) {
                  return Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryWhite,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.r),
                        topRight: Radius.circular(24.r),
                      ),
                    ),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      // important to connect scrolling
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 12.h,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // same content as above
                            SizedBox(height: 8.h),
                            Container(
                              width: 40.w,
                              height: 4.h,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Text("Filter", style: TextStyle(fontSize: 20.sp)),
                            SizedBox(height: 16.h),
                            _buildLicenceSelector(),
                            SizedBox(height: 24.h),
                            _buildAccreditationSelector(),
                            SizedBox(height: 24.h),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Distance"),
                            ),
                            _buildDistanceSlider(),
                            SizedBox(height: 12.h),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Pay Range(per Hour)"),
                            ),
                            SizedBox(height: 26.h),
                            _buildPayRangeSlider(),

                            SizedBox(height: 16.h),
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor:
                                          AppColors.secondaryNavyBlue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          16.r,
                                        ),
                                      ),
                                    ),
                                    onPressed: () => Get.back(),
                                    child: Text("Reset"),
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          16.r,
                                        ),
                                      ),
                                      foregroundColor: AppColors.primaryWhite,
                                      backgroundColor:
                                          AppColors.secondaryNavyBlue,
                                    ),
                                    onPressed: () => Get.back(),
                                    child: Text("Apply"),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 24.h),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              isScrollControlled: true,
            );
          },
          child: SvgPicture.asset(
            AppAssets.filterCircleIcon,
            width: 36.w,
            height: 36.h,
          ),
        ),
      ],
    );
  }

  FlutterSlider _buildDistanceSlider() {
    return FlutterSlider(
      trackBar: FlutterSliderTrackBar(
        activeTrackBar: BoxDecoration(color: AppColors.primaryOrange),
        inactiveTrackBar: BoxDecoration(color: Colors.grey.shade300),
      ),

      values: [60],
      max: 100,
      min: 1,

      tooltip: FlutterSliderTooltip(
        alwaysShowTooltip: true,
        format: (value) => "$value km",
      ),

      onDragging: (handlerIndex, lowerValue, upperValue) {},

      // ✅ Circular Drag Handler
      handler: FlutterSliderHandler(
        decoration: BoxDecoration(),
        // remove default circle
        child: Container(
          height: 16.h,
          width: 16.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryWhite, // inner color
            border: Border.all(color: AppColors.primaryOrange, width: 3),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryOrange,
                blurRadius: 8,
                spreadRadius: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  GetBuilder<SearchPageController> _buildPayRangeSlider() {
    return GetBuilder<SearchPageController>(
      builder: (controller) {
        return FlutterSlider(
          min: 1.0,
          max: 100.0,
          values: [
            controller.payRange[0].toDouble(),
            controller.payRange[1].toDouble(),
          ],

          rangeSlider: true,

          trackBar: FlutterSliderTrackBar(
            activeTrackBar: BoxDecoration(color: AppColors.primaryOrange),
            inactiveTrackBar: BoxDecoration(color: Colors.grey.shade300),
          ),

          // ✅ Bubble Tooltips
          tooltip: FlutterSliderTooltip(
            alwaysShowTooltip: true,
            positionOffset: FlutterSliderTooltipPositionOffset(
              top:
                  -25, // tweak this number (try -20, -28, -36) until it looks right
              // left: 0, // optional: nudge horizontally
              // right: 0,
            ),
            direction: FlutterSliderTooltipDirection.top,
            boxStyle: FlutterSliderTooltipBox(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryBlack.withValues(alpha: .2),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
            ),
            textStyle: TextStyle(
              color: AppColors.secondaryNavyBlue,
              fontWeight: FontWeight.w600,
            ),
            format: (value) => "\$$value",
          ),

          // ✅ Custom circular handlers
          handler: FlutterSliderHandler(child: _buildHandler()),
          rightHandler: FlutterSliderHandler(child: _buildHandler()),

          // ✅ Update controller values
          onDragging: (handlerIndex, lowerValue, upperValue) {
            controller.payRange[0] = (lowerValue as num).toInt();
            controller.payRange[1] = (upperValue as num).toInt();
            controller.update();
          },
        );
      },
    );
  }

  Widget _buildHandler() {
    return Container(
      height: 20.h,
      width: 20.w,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.primaryOrange, width: 3),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryOrange.withValues(alpha: 0.5),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
    );
  }

  Column _buildLicenceSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text("Licence", style: TextStyle(fontSize: 16.sp)),
        SizedBox(height: 8.h),

        GetBuilder<SearchPageController>(
          builder: (controller) {
            return SizedBox(
              height: 40.h,
              child: ListView.separated(
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    controller.setSelectedLicense(index: index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      color: controller.selectedLicense == index
                          ? AppColors.primaryOrange
                          : AppColors.primaryWhite,
                      border: controller.selectedLicense == index
                          ? null
                          : Border.all(color: AppColors.primaryBorderColor),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 18.w,
                        vertical: 6.h,
                      ),
                      child: Center(
                        child: Text(
                          "Security",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: controller.selectedLicense == index
                                ? AppColors.primaryWhite
                                : AppColors.primaryBlack,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => SizedBox(width: 16.w),
                itemCount: 8,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
              ),
            );
          },
        ),
      ],
    );
  }

  Column _buildAccreditationSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text("Accreditation", style: TextStyle(fontSize: 16.sp)),
        SizedBox(height: 8.h),

        GetBuilder<SearchPageController>(
          builder: (controller) {
            return SizedBox(
              height: 40.h,
              child: ListView.separated(
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    controller.setSelectedAccreditation(index: index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      color: controller.selectedAccreditation == index
                          ? AppColors.primaryOrange
                          : AppColors.primaryWhite,
                      border: controller.selectedAccreditation == index
                          ? null
                          : Border.all(color: AppColors.primaryBorderColor),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 18.w,
                        vertical: 6.h,
                      ),
                      child: Center(
                        child: Text(
                          "ASIC",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: controller.selectedAccreditation == index
                                ? AppColors.primaryWhite
                                : AppColors.primaryBlack,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => SizedBox(width: 16.w),
                itemCount: 8,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
              ),
            );
          },
        ),
      ],
    );
  }
}
