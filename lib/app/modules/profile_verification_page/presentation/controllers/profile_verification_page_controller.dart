import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/core/errors/app_exceptions.dart';
import 'package:flutter_security_workforce/app/core/network/api_endpoints.dart';
import 'package:flutter_security_workforce/app/core/network/dio_client.dart';
import 'package:flutter_security_workforce/app/modules/auth/login_page/data/models/login_response_model.dart';
import 'package:flutter_security_workforce/app/modules/profile_verification_page/data/models/list_of_accreditations_model.dart';
import 'package:flutter_security_workforce/app/modules/profile_verification_page/data/models/list_of_licence_type_model.dart';
import 'package:flutter_security_workforce/app/modules/profile_verification_page/presentation/views/step_five_page.dart';
import 'package:flutter_security_workforce/app/modules/profile_verification_page/presentation/views/step_four_page.dart';
import 'package:flutter_security_workforce/app/modules/profile_verification_page/presentation/views/step_one_page.dart';
import 'package:flutter_security_workforce/app/modules/profile_verification_page/presentation/views/step_three_page.dart';
import 'package:flutter_security_workforce/app/modules/profile_verification_page/presentation/views/step_two_page.dart';
import 'package:flutter_security_workforce/app/routes/app_routes.dart';
import 'package:get/get.dart';
import '../../data/models/verification_details_model.dart';
import '../views/in_review_message_page.dart';

class ProfileVerificationPageController extends GetxController {
  List<Widget> pages = [
    StepOnePage(),
    StepTwoPage(),
    StepThreePage(),
    StepFourPage(),
    StepFivePage(),
    InReviewMessagePage(),
  ];

  late LoginResponseModel loginResponseModel;
  VerificationDetailsModel verificationDetailsModel =
      VerificationDetailsModel();

  final TextEditingController fullNameTEC = TextEditingController();
  final TextEditingController phoneTEC = TextEditingController();
  final TextEditingController summaryTEC = TextEditingController();
  final TextEditingController licenseExpireTEC = TextEditingController();
  final TextEditingController accreditationExpireTEC = TextEditingController();
  final TextEditingController bankNameTEC = TextEditingController();
  final TextEditingController accountHolderNameTEC = TextEditingController();
  final TextEditingController accountNumberTEC = TextEditingController();
  final TextEditingController bsbNumberTEC = TextEditingController();

  FilePickerResult? profileImage;
  FilePickerResult? licenceFiles;
  FilePickerResult? accreditationFile;

  ListOfLicenceTypeModel listOfLicenceTypeModel = ListOfLicenceTypeModel();
  ListOfAccreditationsModel listOfAccreditationsModel =
      ListOfAccreditationsModel();

  String licenceTypeNumber = "1";

  int pageIndex = 0;

  int uploadingPercent = 0;

  int uploadSeconds = 5;

  bool fileUploaded = false;

  double prefRadius = 1.0;

  bool sendNotifications = false;

  bool nextButtonInProgress = false;

  String selectedGender = "";

  String selectedLanguage = "";

  String selectedYearsOfExperience = "";

  String selectedStateOrTerritory = "";

  String selectedLicenseType = "";

  String selectedAccreditation = "";

  Future<void> startUploadingAnimation() async {
    fileUploaded = false;
    update();

    uploadingPercent = 0;
    uploadSeconds = 5;

    Timer.periodic(Duration(seconds: 1), (timer) {
      uploadSeconds--;
      uploadingPercent += 20;
      update();
      if (timer.tick == 5) {
        fileUploaded = true;
        update();
        timer.cancel();
      }
    });
  }

  Future<void> pickPicture() async {
    profileImage = await FilePicker.platform.pickFiles(type: FileType.image);
    update();
  }

  Future<void> pickLicences({required BuildContext context}) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );

    if (result == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Select 2 images first"),
            backgroundColor: AppColors.primaryRed,
          ),
        );
      }
      return;
    }

    if (result.files.length != 2) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Select 2 images"),
            backgroundColor: AppColors.primaryRed,
          ),
        );
      }
      return;
    }

    licenceFiles = result;

    await startUploadingAnimation();

    update();
  }

  Future<void> pickAccreditation({required BuildContext context}) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: true,
      allowedExtensions: ['pdf'],
    );

    if (result == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("upload pdf file"),
            backgroundColor: AppColors.primaryRed,
          ),
        );
      }
      return;
    }

    if (result.files.length != 1) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("upload single pdf file"),
            backgroundColor: AppColors.primaryRed,
          ),
        );
      }
      return;
    }

    accreditationFile = result;

    await startUploadingAnimation();

    update();
  }

  void setSelectedAccreditation(String value) {
    selectedAccreditation = value;
    update();
  }

  void setGender(String value) {
    selectedGender = value;
    update();
  }

  void toggleSendNotifications() {
    sendNotifications = !sendNotifications;
    update();
  }

  void setLanguage(String value) {
    selectedLanguage = value;
    update();
  }

  void setLicenceTypeNumber(String index) {
    licenceTypeNumber = index;
    update();
  }

  void setStateOrTerritory(String value) {
    selectedStateOrTerritory = value;
    // print("sajid testing ${value}");
    update();
  }

  void setSelectedLicenseType(String value) {
    selectedLicenseType = value;

    for (
      int i = 0;
      i < (listOfLicenceTypeModel.licenceTypes?.length ?? 0);
      i++
    ) {
      if (selectedLicenseType ==
          listOfLicenceTypeModel.licenceTypes![i].title) {
        licenceTypeNumber = listOfLicenceTypeModel.licenceTypes![i].id
            .toString();
        break;
      }
    }

    // print("sajid testing $licenceTypeNumber");

    update();
  }

  void setYearsOfExperience(String value) {
    selectedYearsOfExperience = value;
    update();
  }

  Future<void> increasePageIndex() async {
    pageIndex++;
    update();
  }

  void decreasePageIndex() {
    if (pageIndex > 0) {
      pageIndex--;
    }
    update();
  }

  Future<void> submitFirstStepData({required BuildContext context}) async {
    if (profileImage == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("You must upload your profile picture."),
            backgroundColor: AppColors.primaryRed,
          ),
        );
      }
      return;
    }

    nextButtonInProgress = true;
    update();

    try {
      DioClient dioClient = DioClient();

      dio.MultipartFile? profileMultiPartFile;

      final path = profileImage!.files.single.path!;

      profileMultiPartFile = await dio.MultipartFile.fromFile(
        path,
        filename: path.split('/').last,
      );

      // await dioClient.put(
      //   ApiEndpoints.profileUpdateUrl,
      //   data: {
      //     "first_name": fullNameTEC.text.trim(),
      //     "phone": phoneTEC.text.trim(),
      //     "gender": selectedGender,
      //     "image": profileMultiPartFile,
      //   },
      // );

      final formData = dio.FormData.fromMap({
        "account_holder_name": fullNameTEC.text.trim(),
        "first_name": fullNameTEC.text.trim(),
        "phone": phoneTEC.text.trim(),
        "gender": selectedGender,
        "image": profileMultiPartFile,
      });

      dynamic data = await dioClient.put(
        ApiEndpoints.profileUpdateUrl,
        data: formData,
      );

      // print("Sajid testing ${data["data"]}");

      selectedLanguage = data?["data"]?["language"] ?? "";
      selectedYearsOfExperience =
          data?["data"]?["exprience_in_years"]?.toString() ?? "";
      summaryTEC.text = data?["data"]?["exprience_summary"] ?? "";
      prefRadius = data?["data"]?["user_redus"]?.toDouble() ?? 0.1;

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Updated"),
            backgroundColor: AppColors.primaryGreen,
          ),
        );

        increasePageIndex();
        nextButtonInProgress = false;
        update();
        return;
      }
    } on AppException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message),
            backgroundColor: AppColors.primaryRed,
          ),
        );
      }

      nextButtonInProgress = false;
      update();
      return;
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: AppColors.primaryRed,
          ),
        );
      }

      nextButtonInProgress = false;
      update();
      return;
    }

    nextButtonInProgress = false;
    increasePageIndex();
  }

  Future<void> submitSecondStepData({required BuildContext context}) async {
    nextButtonInProgress = true;
    update();

    try {
      DioClient dioClient = DioClient();

      await dioClient.put(
        ApiEndpoints.profileUpdateUrl,
        data: {
          "language": selectedLanguage,
          "exprience_in_years": selectedYearsOfExperience,
          "exprience_summary": summaryTEC.text,
          "user_redus": prefRadius.toString(),
        },
      );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Updated"),
            backgroundColor: AppColors.primaryGreen,
          ),
        );
      }
    } on AppException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message),
            backgroundColor: AppColors.primaryRed,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: AppColors.primaryRed,
          ),
        );
      }
    }

    nextButtonInProgress = false;
    increasePageIndex();
  }

  Future<void> submitThirdStepData({
    required BuildContext context,
    required ProfileVerificationPageController controller,
  }) async {
    if (controller.licenceFiles == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Must upload licence"),
          backgroundColor: AppColors.primaryRed,
        ),
      );
      return;
    }

    nextButtonInProgress = true;
    update();

    try {
      DioClient dioClient = DioClient();

      List<dio.MultipartFile> multipartImages = [];

      for (var file in controller.licenceFiles!.files) {
        multipartImages.add(
          await dio.MultipartFile.fromFile(file.path!, filename: file.name),
        );
      }

      final formData = dio.FormData.fromMap({
        "state_or_territory": selectedStateOrTerritory,
        "licence_type": licenceTypeNumber,
        "expire_date": licenseExpireTEC.text.trim(),
        "licence_images": multipartImages,
      });

      await dioClient.post(ApiEndpoints.addLicenceUrl, data: formData);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Updated"),
            backgroundColor: AppColors.primaryGreen,
          ),
        );
      }
    } on AppException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message),
            backgroundColor: AppColors.primaryRed,
          ),
        );
      }

      nextButtonInProgress = false;
      update();
      return;
    } catch (e) {
      nextButtonInProgress = false;
      update();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: AppColors.primaryRed,
          ),
        );
      }
      return;
    }

    nextButtonInProgress = false;
    increasePageIndex();
  }

  Future<void> submitFourthStepData({required BuildContext context}) async {
    if (accreditationFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Must upload accreditation files"),
          backgroundColor: AppColors.primaryRed,
        ),
      );
      return;
    }

    nextButtonInProgress = true;
    update();

    try {
      DioClient dioClient = DioClient();

      List<dio.MultipartFile> multipartImages = [];

      for (var file in accreditationFile!.files) {
        multipartImages.add(
          await dio.MultipartFile.fromFile(file.path!, filename: file.name),
        );
      }

      String accreditationType = "1";

      for (
        int i = 0;
        i < (listOfAccreditationsModel.certificateTypes?.length ?? 0);
        i++
      ) {
        if (listOfAccreditationsModel.certificateTypes?[i].title ==
            selectedAccreditation) {
          accreditationType =
              listOfAccreditationsModel.certificateTypes?[i].id.toString() ??
              "1";
          break;
        }
      }

      final formData = dio.FormData.fromMap({
        "accreditation_type": accreditationType,
        "expire_date": accreditationExpireTEC.text.trim(),
        "accreditation": multipartImages,
      });

      await dioClient.post(ApiEndpoints.accreditationUrl, data: formData);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Updated"),
            backgroundColor: AppColors.primaryGreen,
          ),
        );
      }
    } on AppException catch (e) {
      nextButtonInProgress = false;
      update();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message),
            backgroundColor: AppColors.primaryRed,
          ),
        );
      }
      return;
    } catch (e) {
      nextButtonInProgress = false;
      update();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: AppColors.primaryRed,
          ),
        );
      }
      return;
    }

    nextButtonInProgress = false;
    increasePageIndex();
  }

  Future<void> submitFifthStepData({required BuildContext context}) async {
    nextButtonInProgress = true;
    update();

    try {
      DioClient dioClient = DioClient();

      await dioClient.put(
        ApiEndpoints.profileUpdateUrl,
        data: {
          "bank_name": bankNameTEC.text.toString().trim(),
          "account_holder_name": accountHolderNameTEC.text.toString().trim(),
          "account_no": accountNumberTEC.text.toString().trim(),
          "bank_branch": bsbNumberTEC.text.toString().trim(),
        },
      );

      Get.offAllNamed(AppRoutes.bottomNavbarRoute);
    } on AppException catch (e) {
      log(e.message);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message),
            backgroundColor: AppColors.primaryRed,
          ),
        );
      }
      nextButtonInProgress = false;
      update();
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: AppColors.primaryRed,
          ),
        );
      }
      nextButtonInProgress = false;
      update();
    }
  }

  @override
  void onInit() async {
    super.onInit();

    fullNameTEC.text =
        Get.arguments["guard_details"]["candidate"]["first_name"] ?? "";
    phoneTEC.text = Get.arguments["guard_details"]["candidate"]["phone"] ?? "";
    selectedGender =
        Get.arguments["guard_details"]["candidate"]["gender"] ?? "";

    selectedLanguage =
        Get.arguments["guard_details"]["candidate"]["language"] ?? "";

    loginResponseModel = LoginResponseModel.fromJson(Get.arguments);

    // print("sajid testing ${loginResponseModel.toJson()}");

    DioClient dioClient = DioClient();

    try {
      dynamic data = await dioClient.get(ApiEndpoints.licenceTypeListUrl);

      listOfLicenceTypeModel = ListOfLicenceTypeModel.fromJson(data);

      dynamic data2 = await dioClient.get(
        ApiEndpoints.accreditationTypeListUrl,
      );

      listOfAccreditationsModel = ListOfAccreditationsModel.fromJson(data2);
    } on AppException catch (e) {
      Get.showSnackbar((GetSnackBar(message: e.message)));
    } catch (e) {
      Get.showSnackbar((GetSnackBar(message: e.toString())));
    }

    update();
  }

  @override
  void onClose() {
    fullNameTEC.dispose();
    phoneTEC.dispose();
    summaryTEC.dispose();
    licenseExpireTEC.dispose();
    accreditationExpireTEC.dispose();
    bankNameTEC.dispose();
    accountHolderNameTEC.dispose();
    accountNumberTEC.dispose();
    bsbNumberTEC.dispose();
    super.onClose();
  }
}
