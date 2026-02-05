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
    //StepFivePage(),
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

  List<LicenceTypes> filteredLicenceTypes = [];
  List<String> selectedLicenseTypes = [];
  List<String> licenceTypeNumbers = [];

  List<String> selectedAccreditationTypes = [];
  ListOfAccreditationsModel listOfAccreditationsModel =
      ListOfAccreditationsModel();

  String selectedStateOrTerritory = "";

  String licenceTypeNumber = "1";

  int pageIndex = 0;

  int uploadingPercent = 0;

  int uploadSeconds = 5;

  bool fileUploaded = false;

  double prefRadius = 1.0;

  bool sendNotifications = false;

  bool nextButtonInProgress = false;

  String selectedGender = "";

  List<String> selectedLanguages = [];

  String selectedYearsOfExperience = "";

  String selectedAccreditation = "";

  Future<void> getAccreditionType() async {
    try {
      DioClient dioClient = DioClient();
      dynamic data = await dioClient.get(ApiEndpoints.accreditationTypeListUrl);
      listOfAccreditationsModel = ListOfAccreditationsModel.fromJson(data);

      print(
        "Total Accreditation Loaded: ${listOfAccreditationsModel.certificateTypes?.length}",
      );
    } catch (e) {
      print("Error: $e");
      Get.showSnackbar(
        GetSnackBar(
          message: "Failed to load accreditation types: $e",
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> fetchLicenceTypes() async {
    try {
      isLoading = true;
      update();

      DioClient dioClient = DioClient();
      dynamic data = await dioClient.get(ApiEndpoints.licenceTypeListUrl);
      listOfLicenceTypeModel = ListOfLicenceTypeModel.fromJson(data);

      print(
        "Total Licences Loaded: ${listOfLicenceTypeModel.licenceTypes?.length}",
      );

      if (listOfLicenceTypeModel.licenceTypes != null &&
          listOfLicenceTypeModel.licenceTypes!.isNotEmpty) {
        final firstState =
            listOfLicenceTypeModel.licenceTypes!.first.stateOrTerritory;
        if (firstState != null && firstState.isNotEmpty) {
          setStateOrTerritory(firstState);
        }
      }
    } catch (e) {
      print("Error: $e");
      Get.showSnackbar(
        GetSnackBar(
          message: "Failed to load licence types: $e",
          duration: Duration(seconds: 3),
        ),
      );
    } finally {
      isLoading = false;
      update();
    }
  }

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

  void setLanguages(List<String> languages) {
    selectedLanguages = languages;
    update();
  }

  void setLicenceTypeNumber(String index) {
    licenceTypeNumber = index;
    update();
  }

  void setStateOrTerritory(String value) {
    selectedStateOrTerritory = value;

    // Filter করা - যে state select করা হয়েছে সেই state এর সব licence
    filteredLicenceTypes =
        listOfLicenceTypeModel.licenceTypes?.where((e) {
          if (e.stateOrTerritory == null) return false;
          return e.stateOrTerritory!.trim().toLowerCase() ==
              value.trim().toLowerCase();
        }).toList() ??
        [];

    print("✅ Selected State: $value");
    print("✅ Filtered Licences: ${filteredLicenceTypes.length}");

    // আগের selection clear করা
    selectedLicenseTypes.clear();
    licenceTypeNumbers.clear();

    update();
  }

  void toggleSelectedLicenseType(String value) {
    if (selectedLicenseTypes.contains(value)) {
      selectedLicenseTypes.remove(value);
    } else {
      selectedLicenseTypes.add(value);
    }

    licenceTypeNumbers.clear();
    for (var licence in listOfLicenceTypeModel.licenceTypes ?? []) {
      if (selectedLicenseTypes.contains(licence.title)) {
        licenceTypeNumbers.add(licence.id.toString());
      }
    }

    print("✅ Selected Licences: $selectedLicenseTypes");
    print("✅ Licence IDs: $licenceTypeNumbers");

    update();
  }

  void toggleSelectedAccreditation(String value) {
    if (selectedAccreditationTypes.contains(value)) {
      selectedAccreditationTypes.remove(value);
    } else {
      selectedAccreditationTypes.add(value);
    }

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
    nextButtonInProgress = true;
    update();

    try {
      DioClient dioClient = DioClient();

      dio.MultipartFile? profileMultiPartFile;

      if (profileImage != null) {
        final path = profileImage!.files.single.path!;
        profileMultiPartFile = await dio.MultipartFile.fromFile(
          path,
          filename: path.split('/').last,
        );
      }

      final formData = dio.FormData.fromMap({
        "account_holder_name": fullNameTEC.text.trim(),
        "first_name": fullNameTEC.text.trim(),
        "phone": phoneTEC.text.trim(),
        "gender": selectedGender,
        if (profileMultiPartFile != null) "image": profileMultiPartFile,
      });

      // API call
      dynamic data = await dioClient.put(
        ApiEndpoints.profileUpdateUrl,
        data: formData,
      );

      selectedLanguages = (data?["data"]?["languages"] ?? "")
          .toString()
          .split(",")
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();
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
    } finally {
      nextButtonInProgress = false;
      update();
    }
  }

  Future<void> submitSecondStepData({required BuildContext context}) async {
    nextButtonInProgress = true;
    update();

    try {
      DioClient dioClient = DioClient();

      await dioClient.put(
        ApiEndpoints.profileUpdateUrl,
        data: {
          "exprience_in_years": selectedYearsOfExperience,
          "exprience_summary": summaryTEC.text,
          "user_redus": prefRadius.toString(),
          "languages": selectedLanguages.join(', '),
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
        "licence_types": licenceTypeNumbers.map((e) => int.parse(e)).toList(),
        "expire_date": licenseExpireTEC.text.trim(),
        "licence_images": multipartImages,
      });

      print("sajid testing ===========>${formData.fields}");

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

    if (selectedAccreditationTypes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please select at least one accreditation type"),
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

      List<String> accreditationIds = [];
      for (var selected in selectedAccreditationTypes) {
        final matched = listOfAccreditationsModel.certificateTypes
            ?.where((e) => e.title == selected)
            .toList();

        if (matched != null && matched.isNotEmpty && matched[0].id != null) {
          accreditationIds.add(matched[0].id.toString());
        }
      }

      final formData = dio.FormData.fromMap({
        "accreditation_types": accreditationIds,
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

      Get.offAllNamed(AppRoutes.loginRoute);
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

  // Future<void> submitFourthStepData({required BuildContext context}) async {
  //   if (accreditationFile == null) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text("Must upload accreditation files"),
  //         backgroundColor: AppColors.primaryRed,
  //       ),
  //     );
  //     return;
  //   }

  //   nextButtonInProgress = true;
  //   update();

  //   try {
  //     DioClient dioClient = DioClient();

  //     List<dio.MultipartFile> multipartImages = [];

  //     for (var file in accreditationFile!.files) {
  //       multipartImages.add(
  //         await dio.MultipartFile.fromFile(file.path!, filename: file.name),
  //       );
  //     }

  //     String accreditationType = "1";

  //     for (
  //       int i = 0;
  //       i < (listOfAccreditationsModel.certificateTypes?.length ?? 0);
  //       i++
  //     ) {
  //       if (listOfAccreditationsModel.certificateTypes?[i].title ==
  //           selectedAccreditation) {
  //         accreditationType =
  //             listOfAccreditationsModel.certificateTypes?[i].id.toString() ??
  //             "1";
  //         break;
  //       }
  //     }

  //     final formData = dio.FormData.fromMap({
  //       "accreditation_types": accreditationType,
  //       "expire_date": accreditationExpireTEC.text.trim(),
  //       "accreditation": multipartImages,
  //     });

  //     await dioClient.post(ApiEndpoints.accreditationUrl, data: formData);

  //     if (context.mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text("Updated"),
  //           backgroundColor: AppColors.primaryGreen,
  //         ),
  //       );
  //     }
  //     Get.offAllNamed(AppRoutes.loginRoute);
  //   } on AppException catch (e) {
  //     nextButtonInProgress = false;
  //     update();
  //     if (context.mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(e.message),
  //           backgroundColor: AppColors.primaryRed,
  //         ),
  //       );
  //     }
  //     return;
  //   } catch (e) {
  //     nextButtonInProgress = false;
  //     update();
  //     if (context.mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(e.toString()),
  //           backgroundColor: AppColors.primaryRed,
  //         ),
  //       );
  //     }
  //     return;
  //   }

  //   nextButtonInProgress = false;
  //   increasePageIndex();
  // }

  @override
  void onInit() async {
    super.onInit();

    fetchLicenceTypes();
    getAccreditionType();

    fullNameTEC.text =
        Get.arguments["guard_details"]["candidate"]["first_name"] ?? "";
    phoneTEC.text = Get.arguments["guard_details"]["candidate"]["phone"] ?? "";
    selectedGender =
        Get.arguments["guard_details"]["candidate"]["gender"] ?? "";

    // selectedLanguages =
    //     Get.arguments["guard_details"]["candidate"]["languages"] ?? "";

    final languagesFromApi =
        Get.arguments["guard_details"]["candidate"]["languages"] ?? "";
    if (languagesFromApi is String && languagesFromApi.isNotEmpty) {
      selectedLanguages = languagesFromApi
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();
    } else if (languagesFromApi is List) {
      selectedLanguages = List<String>.from(languagesFromApi);
    }
    loginResponseModel = LoginResponseModel.fromJson(Get.arguments);
  }

  bool isLoading = false;

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
