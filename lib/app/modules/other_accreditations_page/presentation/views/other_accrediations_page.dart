import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_security_workforce/app/modules/other_accreditations_page/presentation/controller/other_accrediations_page_controller.dart';
import 'package:flutter_security_workforce/app/routes/app_routes.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';

import './add_license_page.dart';

class OtherAccrediationsPage extends StatelessWidget {
  const OtherAccrediationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Other Accreditations",
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
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
              SizedBox(height: 20.h),
              _buildAddLicencesAndCertificates(),
              SizedBox(height: 16.h),
              // _buildFileSelectedSection(),
              GetBuilder<OtherAccrediationsPageController>(
                builder: (controller) {
                  return Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child: Row(
                          children: [
                            Text(
                              " • ${controller.certificateListModel.data![index].accreditationType?.title ?? ""}",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            SvgPicture.asset(
                              AppAssets.pdfIcon,
                              width: 32.w,
                              height: 32.h,
                            ),
                            SizedBox(width: 12.w),
                            Text("assets.zip"),
                          ],
                        ),
                      ),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 12.h),
                      itemCount:
                          controller.certificateListModel.data?.length ?? 0,
                    ),
                  );
                },
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildAddLicencesAndCertificates() {
    return Row(
      children: [
        Text(
          "All Other Accreditations",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
        ),
        Spacer(),

        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryOrange,
            foregroundColor: AppColors.primaryWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          onPressed: () {
            Get.to(AddLicensePage());
          },
          child: Text("Add Accreditation"),
        ),
      ],
    );
  }
}
