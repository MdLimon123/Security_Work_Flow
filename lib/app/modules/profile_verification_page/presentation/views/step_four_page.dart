import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_security_workforce/app/core/constants/app_assets.dart';
import 'package:flutter_security_workforce/app/routes/app_routes.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_colors.dart';
import '../controllers/profile_verification_page_controller.dart';

class StepFourPage extends StatelessWidget {
  const StepFourPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileVerificationPageController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Other Accreditations",
                style: TextStyle(
                  fontSize: 24.sp,
                  color: AppColors.secondaryNavyBlue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            SizedBox(height: 32.h),

            _buildAccreditationInput(controller),

            SizedBox(height: 16.h),

            Text(
              "Accreditation Upload",
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.secondaryNavyBlue,
              ),
            ),

            InkWell(
              onTap: () async {
                await controller.pickAccreditation(context: context);
              },
              child: SvgPicture.asset(
                AppAssets.uploadBackFrontImageAccreditationImage,
              ),
            ),

            SizedBox(height: 8.h),

            for (
              int i = 0;
              i <
                  (controller.accreditationFile?.files == null
                      ? 0
                      : controller.accreditationFile!.files.length);
              i++
            )
              Column(
                children: [
                  controller.fileUploaded
                      ? _buildUploadedElementStatus(
                          fileName:
                              controller.accreditationFile?.files[i].name ?? "",
                          fileSize:
                              controller.accreditationFile?.files[i].size
                                  .toString() ??
                              "",
                        )
                      : _buildUploadFileStatus(),
                  SizedBox(height: 16.h),
                ],
              ),

            // SizedBox(height: 4.h),
            // _buildUploadedElementStatus(),
            SizedBox(height: 16.h),

            _buildExpireDateAccreditationInput(controller),

            SizedBox(height: 20.h),
            _buildNextButton(controller, context: context),
            SizedBox(height: 12.h),
            Center(
              child: InkWell(
                onTap: () {
                  Get.offAllNamed(AppRoutes.bottomNavbarRoute);
                },
                child: Text(
                  "Skip",
                  style: TextStyle(color: AppColors.primaryOrange),
                ),
              ),
            ),
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
      child: ElevatedButton(
        onPressed: () async {
          await controller.submitFourthStepData(context: context);
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
                child: CircularProgressIndicator(color: AppColors.primaryWhite),
              )
            : Text("Submit", style: TextStyle(color: AppColors.primaryWhite)),
      ),
    );
  }

  Column _buildExpireDateAccreditationInput(
    ProfileVerificationPageController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Expiry Date",
          style: TextStyle(fontSize: 16.sp, color: AppColors.secondaryNavyBlue),
        ),

        TextFormField(
          readOnly: true,
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: Get.context!,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );

            if (pickedDate != null) {
              controller.accreditationExpireTEC.text =
                  "${pickedDate.year.toString().padLeft(4, '0')}-"
                  "${pickedDate.month.toString().padLeft(2, '0')}-"
                  "${pickedDate.day.toString().padLeft(2, '0')}";
            }
          },
          keyboardType: TextInputType.datetime,
          controller: controller.accreditationExpireTEC,
          decoration: InputDecoration(
            hintText: "Enter accreditation expiry date",
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

  Visibility _buildUploadedElementStatus({
    required String fileName,
    required String fileSize,
  }) {
    return Visibility(
      visible: true,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.primaryGray),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.sp),
          child: Row(
            children: [
              SvgPicture.asset(AppAssets.pdfIcon),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fileName,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        // overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      "$fileSize Bytes",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondaryTextColor,
                      ),
                    ),
                  ],
                ),
              ),
              // Spacer(),
              // InkWell(
              //   onTap: () {
              //
              //   },
              //   child: SvgPicture.asset(
              //     AppAssets.cancelIcon,
              //     width: 24.w,
              //     height: 24.h,
              //     colorFilter: ColorFilter.mode(
              //       AppColors.primaryGray,
              //       BlendMode.srcIn,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  // Column _buildAccreditationInput(
  //   ProfileVerificationPageController controller,
  // ) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         "Accreditation Type",
  //         style: TextStyle(fontSize: 16.sp, color: AppColors.secondaryNavyBlue),
  //       ),
  //       PopupMenuButton<String>(
  //         color: AppColors.primaryWhite,
  //         onSelected: (value) {
  //           controller.setSelectedAccreditation(value);
  //         },
  //         itemBuilder: (context) => [
  //           for (
  //             int i = 0;
  //             i < controller.listOfAccreditationsModel.certificateTypes!.length;
  //             i++
  //           )
  //             PopupMenuItem(
  //               value:
  //                   controller
  //                       .listOfAccreditationsModel
  //                       .certificateTypes?[i]
  //                       .title ??
  //                   "0",
  //               child: Text(
  //                 controller
  //                         .listOfAccreditationsModel
  //                         .certificateTypes?[i]
  //                         .title ??
  //                     "",
  //               ),
  //             ),
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
  //                 controller.selectedAccreditation.isEmpty
  //                     ? "Select your accreditation type"
  //                     : controller.selectedAccreditation,
  //                 style: TextStyle(
  //                   fontSize: 16,
  //                   color: controller.selectedAccreditation.isEmpty
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

  Column _buildAccreditationInput(
    ProfileVerificationPageController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const Text(
          "Select Accreditation Type(s):",
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF002147),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),

        GetBuilder<ProfileVerificationPageController>(
          builder: (c) {
            if (c.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            final items = c.listOfAccreditationsModel.certificateTypes ?? [];

            if (items.isEmpty) {
              return const Text(
                "No accreditation types found. Please check API data.",
                style: TextStyle(color: Colors.red),
              );
            }

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 16,
                mainAxisExtent: 60,
              ),
              itemBuilder: (context, index) {
                final item = items[index];

                return InkWell(
                  onTap: () => c.toggleSelectedAccreditation(item.title!),
                  child: Row(
                    children: [
                      Checkbox(
                        value: c.selectedAccreditationTypes.contains(
                          item.title,
                        ),
                        onChanged: (_) =>
                            c.toggleSelectedAccreditation(item.title!),
                      ),
                      Expanded(
                        child: Text(
                          item.title ?? "",
                          maxLines: 3,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),

        const SizedBox(height: 12),
      ],
    );
  }

  Visibility _buildUploadFileStatus() {
    return Visibility(
      visible: true,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.primaryGray),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Uploading...",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        GetBuilder<ProfileVerificationPageController>(
                          builder: (controller) {
                            return Text(
                              "${controller.uploadingPercent}%  • ${controller.uploadSeconds} seconds remaining",
                              style: TextStyle(
                                color: AppColors.secondaryTextColor,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  // Spacer(),
                  // Row(
                  //   children: [
                  //     InkWell(
                  //       onTap: () {},
                  //       child: SvgPicture.asset(
                  //         AppAssets.pauseIcon,
                  //         width: 24.w,
                  //         height: 24.h,
                  //       ),
                  //     ),
                  //     SizedBox(width: 4.w),
                  //     InkWell(
                  //       onTap: () {},
                  //       child: SvgPicture.asset(
                  //         AppAssets.cancelIcon,
                  //         width: 24.w,
                  //         height: 24.h,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),

              SizedBox(height: 8.h),
              SizedBox(
                width: double.infinity,
                child: GetBuilder<ProfileVerificationPageController>(
                  builder: (controller) {
                    return LinearProgressIndicator(
                      value: controller.uploadingPercent / 100,
                      minHeight: 8.sp,
                      borderRadius: BorderRadius.circular(6.r),
                      color: AppColors.primaryBlue,
                      backgroundColor: AppColors.lightGrey,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
