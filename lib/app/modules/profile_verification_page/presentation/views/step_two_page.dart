import 'package:another_xlider/another_xlider.dart';
import 'package:another_xlider/models/handler.dart';
import 'package:another_xlider/models/tooltip/tooltip.dart';
import 'package:another_xlider/models/trackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_colors.dart';
import '../controllers/profile_verification_page_controller.dart';

class StepTwoPage extends StatelessWidget {
  const StepTwoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileVerificationPageController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
      

            Text(
              "Personal Information",
              style: TextStyle(
                fontSize: 24.sp,
                color: AppColors.secondaryNavyBlue,
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: 32.h),

            _buildLanguageInput(controller, context),

            SizedBox(height: 12.h),

            _buildYearOfExperienceInput(controller),

            SizedBox(height: 12.h),

            _buildSummaryInput(controller),

            SizedBox(height: 12.h),

            Text(
              "Preferred Job Radius (km)",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.secondaryNavyBlue,
              ),
            ),

            _buildPreferedJobRadiusSlider(),

            Row(
              children: [
                Checkbox(
                  value: controller.sendNotifications,
                  onChanged: (value) => controller.toggleSendNotifications(),
                  activeColor: AppColors.primaryOrange,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    "Send me job notifications within my selected radius only.",
                    style: TextStyle(color: AppColors.primaryGray),
                  ),
                ),
              ],
            ),

            _buildNextButton(controller, context: context),

            SizedBox(height: 12.h),
          ],
        );
      },
    );
  }

  SizedBox _buildNextButton(
    ProfileVerificationPageController controller, {
    required BuildContext context,
  }) {
    return SizedBox(
      width: double.infinity,
      child: GetBuilder<ProfileVerificationPageController>(
        builder: (controller) {
          return controller.nextButtonInProgress
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryWhite,
                  ),
                )
              : ElevatedButton(
                  onPressed: () async {
                    await controller.submitSecondStepData(context: context);
                    // controller.increasePageIndex();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondaryNavyBlue,
                    foregroundColor: AppColors.primaryWhite,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  child: controller.nextButtonInProgress
                      ? Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryWhite,
                          ),
                        )
                      : Text(
                          "Next",
                          style: TextStyle(color: AppColors.primaryWhite),
                        ),
                );
        },
      ),
    );
  }

  GetBuilder<ProfileVerificationPageController>
  _buildPreferedJobRadiusSlider() {
    return GetBuilder<ProfileVerificationPageController>(
      builder: (controller) {
        return FlutterSlider(
          trackBar: FlutterSliderTrackBar(
            activeTrackBar: BoxDecoration(color: AppColors.primaryOrange),
            inactiveTrackBar: BoxDecoration(color: Colors.grey.shade300),
          ),

          values: [controller.prefRadius],
          max: 100,
          min: 1,

          tooltip: FlutterSliderTooltip(
            alwaysShowTooltip: true,
            format: (value) {
              return "$value km";
            },
          ),

          onDragging: (handlerIndex, lowerValue, upperValue) {
            controller.prefRadius = lowerValue;
            controller.update();
            // print("sajid testing $lowerValue");
          },

          // ✅ Circular Drag Handler
          handler: FlutterSliderHandler(
            decoration: BoxDecoration(), // remove default circle
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
      },
    );
  }

  Column _buildSummaryInput(ProfileVerificationPageController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Experience Summary",
          style: TextStyle(fontSize: 16.sp, color: AppColors.secondaryNavyBlue),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          maxLines: 3,
          maxLength: 400,
          keyboardType: TextInputType.multiline,
          controller: controller.summaryTEC,
          decoration: InputDecoration(
            hintText: "Summarise industries, roles and tasks",
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

  Column _buildYearOfExperienceInput(
    ProfileVerificationPageController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Years of Experience",
          style: TextStyle(fontSize: 16.sp, color: AppColors.secondaryNavyBlue),
        ),
        PopupMenuButton<String>(
          color: AppColors.primaryWhite,
          onSelected: (value) {
            controller.setYearsOfExperience(value);
          },
          itemBuilder: (context) => [
            for (int i = 0; i <= 60; i++)
              PopupMenuItem(value: "$i", child: Text("$i")),
          ],
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.secondaryWhite),
            ),
            child: Row(
              children: [
                Icon(Icons.keyboard_arrow_down, color: AppColors.primaryGray),

                SizedBox(width: 8.w),
                Text(
                  controller.selectedYearsOfExperience.isEmpty
                      ? "Select total years of experience"
                      : controller.selectedYearsOfExperience,
                  style: TextStyle(
                    fontSize: 16,
                    color: controller.selectedYearsOfExperience.isEmpty
                        ? AppColors.primaryGray
                        : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Column _buildLanguageInput(
    ProfileVerificationPageController controller,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Language",
          style: TextStyle(fontSize: 16.sp, color: AppColors.secondaryNavyBlue),
        ),
        GestureDetector(
          onTap: () async {
            // Open dialog for multi-select
            final selectedLanguages = await showDialog<List<String>>(
              context: context,
              builder: (context) {
                List<String> languages = [
                  "English",
                  "Spanish",
                  "Mandarin Chinese",
                  "Hindi",
                  "Arabic",
                  "French",
                  "Portuguese",
                  "Russian",
                  "Bengali",
                  "Japanese",
                ];
                List<String> tempSelected = List.from(
                  controller.selectedLanguages,
                ); // copy current selection

                return AlertDialog(
                  title: Text("Select Fluent Languages"),
                  content: StatefulBuilder(
                    builder: (context, setState) {
                      return SingleChildScrollView(
                        child: Column(
                          children: languages.map((lang) {
                            return CheckboxListTile(
                              title: Text(lang),
                              value: tempSelected.contains(lang),
                              onChanged: (checked) {
                                setState(() {
                                  if (checked == true) {
                                    tempSelected.add(lang);
                                  } else {
                                    tempSelected.remove(lang);
                                  }
                                });
                              },
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, null),
                      child: Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, tempSelected),
                      child: Text("OK"),
                    ),
                  ],
                );
              },
            );

            if (selectedLanguages != null) {
              controller.setLanguages(selectedLanguages);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.secondaryWhite),
            ),
            child: Row(
              children: [
                Icon(Icons.keyboard_arrow_down, color: AppColors.primaryGray),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    controller.selectedLanguages.isEmpty
                        ? "Select Fluent Languages"
                        : controller.selectedLanguages.join(", "),
                    style: TextStyle(
                      fontSize: 16,
                      color: controller.selectedLanguages.isEmpty
                          ? AppColors.primaryGray
                          : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }



  // Column _buildLanguageInput(ProfileVerificationPageController controller) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         "Language",
  //         style: TextStyle(fontSize: 16.sp, color: AppColors.secondaryNavyBlue),
  //       ),
  //       PopupMenuButton<String>(
  //         color: AppColors.primaryWhite,
  //         onSelected: (value) {
  //           controller.setLanguage(value);
  //         },
  //         itemBuilder: (context) => [
  //           const PopupMenuItem(value: "English", child: Text("English")),

  //           const PopupMenuItem(
  //             value: "Spanish",
  //             child: Text("Spanish (Latin American or Castilian)"),
  //           ),
  //           const PopupMenuItem(
  //             value: "Mandarin Chinese",
  //             child: Text("Mandarin Chinese (Simplified or Traditional)"),
  //           ),
  //           const PopupMenuItem(value: "Hindi", child: Text("Hindi")),
  //           const PopupMenuItem(value: "Arabic", child: Text("Arabic")),
  //           const PopupMenuItem(
  //             value: "French",
  //             child: Text("French (France or Canada)"),
  //           ),
  //           const PopupMenuItem(
  //             value: "Portuguese",
  //             child: Text("Portuguese (Brazil or Portugal)"),
  //           ),
  //           const PopupMenuItem(value: "Russian", child: Text("Russian")),
  //           const PopupMenuItem(value: "Bengali", child: Text("Bengali")),
  //           const PopupMenuItem(value: "Japanese", child: Text("Japanese")),
  //         ],
  //         child: Container(
  //           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(12),
  //             border: Border.all(color: AppColors.secondaryWhite),
  //           ),
  //           child: Row(
  //             children: [
  //               Icon(Icons.keyboard_arrow_down, color: AppColors.primaryGray),

  //               SizedBox(width: 8.w),
  //               Text(
  //                 controller.selectedLanguage.isEmpty
  //                     ? "Select Fluent Languages"
  //                     : controller.selectedLanguage,
  //                 style: TextStyle(
  //                   fontSize: 16,
  //                   color: controller.selectedLanguage.isEmpty
  //                       ? AppColors.primaryGray
  //                       : Colors.black,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
