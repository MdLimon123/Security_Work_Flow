import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_security_workforce/app/core/constants/app_assets.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/modules/license_and_certificates_page/controllers/license_and_certificates_page_controller.dart';
import 'package:flutter_security_workforce/app/modules/license_and_certificates_page/views/add_license_page.dart';
import 'package:flutter_security_workforce/app/routes/app_routes.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class LicenseAndCertificatesPage extends StatelessWidget {
  const LicenseAndCertificatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Licences & Certificates",
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

              _buildLicencesList(),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Expanded _buildLicencesList() {
    return Expanded(
      child: GetBuilder<LicenseAndCertificatesPageController>(
        builder: (controller) {
          return ListView.separated(
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: controller.licencesListFetching
                  ? Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryOrange,
                      ),
                    )
                  : Row(
                      children: [
                        Text(
                          " • ${controller.licenseListModel.data![index].licenceType?.title ?? ""}",
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
            separatorBuilder: (context, index) => SizedBox(height: 16.h),
            itemCount: controller.licenseListModel.data?.length ?? 0,
          );
        },
      ),
    );
  }

  Row _buildAddLicencesAndCertificates() {
    return Row(
      children: [
        Text(
          "All licences & Certificates",
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
          child: Text("Add Licence"),
        ),
      ],
    );
  }
}
