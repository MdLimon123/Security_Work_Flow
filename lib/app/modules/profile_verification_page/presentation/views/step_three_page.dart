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
        return SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
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

              /// ---------------- DYNAMIC LICENCE SECTIONS ----------------
              for (int i = 0; i < controller.licenceBlocks.length; i++)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.h),
                    _buildStateOrTerritoryInput(controller, i),
                    SizedBox(height: 16.h),
                    _buildLicenseTypeInput(controller, i),
                    SizedBox(height: 16.h),
                    _buildLicenseExpireInput(controller, i),
                    SizedBox(height: 16.h),
                    _buildLicenceUploadSection(controller, i),

                    if (i != 0)
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => controller.removeLicence(i),
                        ),
                      ),
                  ],
                ),

              SizedBox(height: 16.h),

              /// ---------------- ADD ANOTHER LICENCE BUTTON ----------------
              Center(
                child: ElevatedButton(
                  onPressed: () => controller.addAnotherLicence(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryOrange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  child: Text(
                    "Add Another Licence",
                    style: TextStyle(
                      color: AppColors.primaryWhite,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 24.h),

              /// ---------------- NEXT BUTTON ----------------
              _buildNextButton(controller, context: context),
              SizedBox(height: 12.h),

              /// ---------------- SKIP BUTTON ----------------
              Center(
                child: InkWell(
                  onTap: () => controller.increasePageIndex(),
                  child: Text(
                    "Skip",
                    style: TextStyle(color: AppColors.primaryOrange),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// ---------------- STATE OR TERRITORY INPUT ----------------
  Column _buildStateOrTerritoryInput(
    ProfileVerificationPageController controller,
    int index,
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

    final block = controller.licenceBlocks[index];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "State or Territory",
          style: TextStyle(
            fontSize: 16.sp,
            color: Color(0xFF002147),
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        PopupMenuButton<String>(
          onSelected: (value) => controller.setStateOrTerritory(index, value),
          itemBuilder: (_) => states
              .map((e) => PopupMenuItem(value: e, child: Text(e)))
              .toList(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0xFFE1E1E1)),
            ),
            child: Row(
              children: [
                Icon(Icons.keyboard_arrow_down),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    block.selectedStateOrTerritory.isEmpty
                        ? "Select State or Territory"
                        : block.selectedStateOrTerritory,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Color(0xFF878787),
                      fontWeight: FontWeight.w400,
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

  /// ---------------- LICENSE TYPE INPUT ----------------
  Column _buildLicenseTypeInput(
    ProfileVerificationPageController controller,
    int index,
  ) {
    final block = controller.licenceBlocks[index];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select Licence Type(s):",
          style: TextStyle(
            fontSize: 16.sp,
            color: Color(0xFF002147),
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 12.h),
        GetBuilder<ProfileVerificationPageController>(
          builder: (_) {
            if (controller.isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            final items = block.filteredLicenceTypes;

            if (items.isEmpty) {
              return Text(
                block.selectedStateOrTerritory.isEmpty
                    ? "Please select a State or Territory to see licences"
                    : "No licences found for ${block.selectedStateOrTerritory}.",
                style: TextStyle(color: Colors.red),
              );
            }

            return GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: items.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 16,
                mainAxisExtent: 60,
              ),
              itemBuilder: (context, idx) {
                final item = items[idx];
                return InkWell(
                  onTap: () =>
                      controller.toggleSelectedLicenseType(item.title!, index),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: block.selectedLicenseTypes.contains(item.title),
                        onChanged: (_) => controller.toggleSelectedLicenseType(
                          item.title!,
                          index,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          item.title ?? "",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Color(0xFF6D6D6D),
                            fontWeight: FontWeight.w500,
                          ),
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
      ],
    );
  }

  /// ---------------- LICENSE EXPIRY INPUT ----------------
  Column _buildLicenseExpireInput(
    ProfileVerificationPageController controller,
    int index,
  ) {
    final block = controller.licenceBlocks[index];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Licence Expiry Date",
          style: TextStyle(
            fontSize: 16.sp,
            color: Color(0xFF002147),
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: block.expiryTEC,
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
              block.expiryTEC.text =
                  "${pickedDate.year.toString().padLeft(4, '0')}-"
                  "${pickedDate.month.toString().padLeft(2, '0')}-"
                  "${pickedDate.day.toString().padLeft(2, '0')}";
            }
          },
        ),
      ],
    );
  }

  /// ---------------- LICENCE UPLOAD ----------------
  Column _buildLicenceUploadSection(
    ProfileVerificationPageController controller,
    int index,
  ) {
    final block = controller.licenceBlocks[index];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Licence Upload",
          style: TextStyle(fontSize: 16.sp, color: AppColors.secondaryNavyBlue),
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: () =>
              controller.pickLicences(context: Get.context!, index: index),
          child: SvgPicture.asset(AppAssets.uploadBackFrontImageLicenseImage),
        ),
        SizedBox(height: 8.h),
        for (int i = 0; i < (block.licenceFiles?.files.length ?? 0); i++)
          Column(
            children: [
              block.fileUploaded
                  ? Text(
                      block.licenceFiles?.files[i].name ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  : _buildUploadFileStatus(controller, index),
              SizedBox(height: 16.h),
            ],
          ),
      ],
    );
  }

  /// ---------------- UPLOAD STATUS ----------------
  Visibility _buildUploadFileStatus(
    ProfileVerificationPageController controller,
    int index,
  ) {
    final block = controller.licenceBlocks[index];

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
                          builder: (_) {
                            return Text(
                              "${block.uploadingPercent}%  • ${block.uploadSeconds} seconds remaining",
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
                  builder: (_) {
                    return LinearProgressIndicator(
                      value: block.uploadingPercent / 100,
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

  /// ---------------- NEXT BUTTON ----------------
  SizedBox _buildNextButton(
    ProfileVerificationPageController controller, {
    required BuildContext context,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          await controller.submitThirdStepData(context: context);
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
