import 'package:get/get.dart';
import 'package:signature/signature.dart';

import '../../../../core/constants/app_colors.dart';

class OpenContactPageController extends GetxController {
  final SignatureController signatureController = SignatureController(
    penStrokeWidth: 1,
    penColor: AppColors.primaryBlack,
    exportBackgroundColor: AppColors.primaryWhite,
  );

  @override
  void onClose() {
    signatureController.dispose();
    super.onClose();
  }
}
