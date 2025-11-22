import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/modules/card_edit_page/presentation/controllers/card_edit_page_controller.dart';
import 'package:flutter_security_workforce/app/routes/app_routes.dart';
import 'package:get/get.dart';

class CardEditPage extends StatelessWidget {
  const CardEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(AppRoutes.notificationRoute);
            },
            icon: Icon(Icons.notifications_outlined),
          ),
        ],
        title: Text(
          "Edit Card Details ",
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                _buildCardHolderNameInput(),
                SizedBox(height: 12.h),
                _buildCardNumberInput(),
                SizedBox(height: 12.h),
                _buildExpiryDateInput(),
                SizedBox(height: 12.h),
                _buildCVVInput(),
                SizedBox(height: 12.h),
                _buildBillingAddressInput(),
                SizedBox(height: 42.h),
                _buildSaveAndUpdateButton(),
                SizedBox(height: 18.h),
                Center(
                  child: InkWell(
                    onTap: () {},
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: AppColors.secondaryNavyBlue,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox _buildSaveAndUpdateButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondaryNavyBlue,
          foregroundColor: AppColors.primaryWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        child: Text(
          "Save & Update",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Column _buildBillingAddressInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Billing Address",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 4.h),
        GetBuilder<CardEditPageController>(
          builder: (controller) {
            return TextField(
              controller: controller.billingAddressTEC,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: "123 George Street, Sydney, Australia",
                hintStyle: TextStyle(color: AppColors.secondaryTextColor),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: AppColors.primaryBorderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: AppColors.primaryBorderColor),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Column _buildCVVInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "CVV",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 4.h),
        GetBuilder<CardEditPageController>(
          builder: (controller) {
            return TextField(
              keyboardType: TextInputType.number,
              controller: controller.cvvTEC,
              decoration: InputDecoration(
                hintText: "***",
                hintStyle: TextStyle(color: AppColors.secondaryTextColor),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: AppColors.primaryBorderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: AppColors.primaryBorderColor),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Column _buildExpiryDateInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Expiry Date (MM/YY)",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 4.h),
        GetBuilder<CardEditPageController>(
          builder: (controller) {
            return TextField(
              keyboardType: TextInputType.datetime,
              controller: controller.expireDateTEC,
              decoration: InputDecoration(
                hintText: "06 / 27",
                hintStyle: TextStyle(color: AppColors.secondaryTextColor),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: AppColors.primaryBorderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: AppColors.primaryBorderColor),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Column _buildCardNumberInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Card Number",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 4.h),
        GetBuilder<CardEditPageController>(
          builder: (controller) {
            return TextField(
              controller: controller.cardNumberTEC,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "********",
                hintStyle: TextStyle(color: AppColors.secondaryTextColor),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: AppColors.primaryBorderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: AppColors.primaryBorderColor),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Column _buildCardHolderNameInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Cardholder Name",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 4.h),
        GetBuilder<CardEditPageController>(
          builder: (controller) {
            return TextField(
              controller: controller.cardHolderNameTEC,
              decoration: InputDecoration(
                hintText: "John Smith",
                hintStyle: TextStyle(color: AppColors.secondaryTextColor),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: AppColors.primaryBorderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: AppColors.primaryBorderColor),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
