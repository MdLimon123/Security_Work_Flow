import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_security_workforce/app/core/constants/app_assets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_colors.dart';
import '../controllers/profile_verification_page_controller.dart';

class StepThreePage extends StatelessWidget {
  const StepThreePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileVerificationPageController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Licences",
                style: TextStyle(
                  fontSize: 24.sp,
                  color: AppColors.secondaryNavyBlue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            SizedBox(height: 32.h),

            _buildStateOrTerritoryInput(controller),

            SizedBox(height: 16.h),

            _buildLicenseTypeInput(controller),

            _buildLicenseExpireInput(controller),
            SizedBox(height: 16.h),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Licence Upload",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.secondaryNavyBlue,
                  ),
                ),

                GestureDetector(
                  onTap: () async {
                    await controller.pickLicences(context: context);
                  },
                  child: SvgPicture.asset(
                    AppAssets.uploadBackFrontImageLicenseImage,
                  ),
                ),

                SizedBox(height: 8.h),

                for (
                  int i = 0;
                  i <
                      (controller.licenceFiles?.files == null
                          ? 0
                          : controller.licenceFiles!.files.length);
                  i++
                )
                  Column(
                    children: [
                      controller.fileUploaded
                          ? Text(
                              controller.licenceFiles?.files[i].name ?? "",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )
                          : _buildUploadFileStatus(),
                      SizedBox(height: 16.h),
                    ],
                  ),

                SizedBox(height: 20.h),
                _buildNextButton(controller, context: context),
                SizedBox(height: 12.h),

                Center(
                  child: InkWell(
                    onTap: () {
                      controller.increasePageIndex();
                    },
                    child: Text(
                      "Skip",
                      style: TextStyle(color: AppColors.primaryOrange),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Column _buildLicenseExpireInput(
    ProfileVerificationPageController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Licence Expiry Date",
          style: TextStyle(fontSize: 16.sp, color: AppColors.secondaryNavyBlue),
        ),

        SizedBox(height: 8.h),

        TextFormField(
          controller: controller.licenseExpireTEC,
          readOnly: true,
          decoration: InputDecoration(
            hintText: "YYYY-MM-DD",
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
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: Get.context!,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );

            if (pickedDate != null) {
              controller.licenseExpireTEC.text =
                  "${pickedDate.year.toString().padLeft(4, '0')}-"
                  "${pickedDate.month.toString().padLeft(2, '0')}-"
                  "${pickedDate.day.toString().padLeft(2, '0')}";
            }
          },
        ),
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

  Column _buildStateOrTerritoryInput(
    ProfileVerificationPageController controller,
  ) {
    final states = [
      "New South Wales",
      "Victoria",
      "Queensland",
      "Western Australia",
      "South Australia",
      "Tasmania",
      "Northern Territory",
      "Australian Capital Territory",
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "State or Territory",
          style: TextStyle(fontSize: 16, color: Color(0xFF002147)),
        ),
        const SizedBox(height: 8),
        GetBuilder<ProfileVerificationPageController>(
          builder: (_) {
            if (controller.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return PopupMenuButton<String>(
              onSelected: controller.setStateOrTerritory,
              itemBuilder: (_) => states
                  .map((e) => PopupMenuItem(value: e, child: Text(e)))
                  .toList(),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.keyboard_arrow_down),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        controller.selectedStateOrTerritory.isEmpty
                            ? "Select State or Territory"
                            : controller.selectedStateOrTerritory,
                        style: TextStyle(
                          color: controller.selectedStateOrTerritory.isEmpty
                              ? Colors.grey
                              : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Column _buildLicenseTypeInput(ProfileVerificationPageController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const Text(
          "Select Licence Type(s):",
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

            final items = c.filteredLicenceTypes;

            if (items.isEmpty) {
              return Text(
                c.selectedStateOrTerritory.isEmpty
                    ? "Please select a State or Territory to see licences"
                    : "No licences found for ${c.selectedStateOrTerritory}. Please check API data.",
                style: const TextStyle(color: Colors.red),
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
                  onTap: () => c.toggleSelectedLicenseType(item.title!),
                  child: Row(
                    children: [
                      Checkbox(
                        value: c.selectedLicenseTypes.contains(item.title),
                        onChanged: (_) =>
                            c.toggleSelectedLicenseType(item.title!),
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



  SizedBox _buildNextButton(
    ProfileVerificationPageController controller, {
    required BuildContext context,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          await controller.submitThirdStepData(
            context: context,
            controller: controller,
          );
          // controller.increasePageIndex();
          print(
            controller.licenceTypeNumbers.map((e) => int.parse(e)).toList(),
          );
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
            : Text("Next", style: TextStyle(color: AppColors.primaryWhite)),
      ),
    );
  }
}
