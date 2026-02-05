import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_security_workforce/app/core/constants/app_assets.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/modules/bank/controller/bank_details_controller.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class BankDetailsScreen extends StatefulWidget {
  const BankDetailsScreen({super.key});

  @override
  State<BankDetailsScreen> createState() => _BankDetailsScreenState();
}

class _BankDetailsScreenState extends State<BankDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BankDetailsController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(Icons.arrow_back, color: Color(0xFF002147)),
            ),
            title: Text(
              "Bank Details",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Color(0xFF002147),
              ),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 32.h),

                  _buildBankNameInput(controller),

                  SizedBox(height: 16.h),

                  _buildAccountHolderNameInput(controller),

                  SizedBox(height: 16.h),

                  _buildAccountNumberInput(controller),

                  SizedBox(height: 16.h),

                  _buildBsbNumberInput(controller),

                  SizedBox(height: 6.h),

                  Row(
                    children: [
                      SvgPicture.asset(
                        AppAssets.cautionIcon,
                        width: 24.w,
                        height: 24.h,
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          "Your bank details are used only to pay your wages.",
                          style: TextStyle(color: AppColors.secondaryGray),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),
                  _buildSubmitButton(controller, context: context),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  SizedBox _buildSubmitButton(
    BankDetailsController controller, {
    required BuildContext context,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          await controller.submitFifthStepData(context: context);
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

  Column _buildBankNameInput(BankDetailsController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Bank Name",
          style: TextStyle(fontSize: 16.sp, color: AppColors.secondaryNavyBlue),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          keyboardType: TextInputType.text,
          controller: controller.bankNameTEC,
          decoration: InputDecoration(
            hintText: "enter your bank name",
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

  Column _buildAccountHolderNameInput(BankDetailsController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Account Holder Name",
          style: TextStyle(fontSize: 16.sp, color: AppColors.secondaryNavyBlue),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          keyboardType: TextInputType.text,
          controller: controller.accountHolderNameTEC,
          decoration: InputDecoration(
            hintText: "enter account holder name",
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

  Column _buildAccountNumberInput(BankDetailsController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Account Number",
          style: TextStyle(fontSize: 16.sp, color: AppColors.secondaryNavyBlue),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          keyboardType: TextInputType.text,
          controller: controller.accountNumberTEC,
          decoration: InputDecoration(
            hintText: "enter your bank account number",
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

  Column _buildBsbNumberInput(BankDetailsController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "BSB Number",
          style: TextStyle(fontSize: 16.sp, color: AppColors.secondaryNavyBlue),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          keyboardType: TextInputType.text,
          controller: controller.bsbNumberTEC,
          decoration: InputDecoration(
            hintText: "enter your BSB number",
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
}
