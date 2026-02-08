import 'dart:async';
import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/core/errors/app_exceptions.dart';
import 'package:flutter_security_workforce/app/core/network/api_endpoints.dart';
import 'package:flutter_security_workforce/app/core/network/dio_client.dart';
import 'package:flutter_security_workforce/app/modules/auth/login_page/data/models/login_response_model.dart';
import 'package:flutter_security_workforce/app/modules/bottom_navbar/presentation/views/bottom_navbar_page.dart';
import 'package:flutter_security_workforce/app/modules/profile_verification_page/data/models/list_of_accreditations_model.dart';
import 'package:flutter_security_workforce/app/modules/profile_verification_page/data/models/list_of_licence_type_model.dart';
import 'package:flutter_security_workforce/app/modules/profile_verification_page/presentation/views/step_four_page.dart';
import 'package:flutter_security_workforce/app/modules/profile_verification_page/presentation/views/step_one_page.dart';
import 'package:flutter_security_workforce/app/modules/profile_verification_page/presentation/views/step_three_page.dart';
import 'package:flutter_security_workforce/app/modules/profile_verification_page/presentation/views/step_two_page.dart';
import 'package:flutter_security_workforce/app/routes/app_routes.dart';
import 'package:get/get.dart';
import '../../data/models/verification_details_model.dart';

class LicenceBlockModel {
  String selectedStateOrTerritory = "";
  List<String> selectedLicenseTypes = [];
  List<String> licenceTypeNumbers = [];
  List<LicenceTypes> filteredLicenceTypes = [];
  TextEditingController expiryTEC = TextEditingController();
  FilePickerResult? licenceFiles;

  /// NEW FIELDS FOR UPLOAD ANIMATION
  int uploadingPercent = 0;
  int uploadSeconds = 0;

  /// Optional: to know if files are uploaded
  bool fileUploaded = false;
}

class ProfileVerificationPageController extends GetxController {
  List<Widget> pages = [
    StepOnePage(),
    StepTwoPage(),
    StepThreePage(),
    StepFourPage(),

    //BottomNavbarPage(),

    // LoginPage(),

    //StepFivePage(),
    //InReviewMessagePage(),
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

  /// new
  List<LicenceBlockModel> licenceBlocks = [LicenceBlockModel()];

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

  List<LicenceBlockModel> licences = [LicenceBlockModel()];

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
        for (int i = 0; i < licences.length; i++) {
          final firstState =
              listOfLicenceTypeModel.licenceTypes!.first.stateOrTerritory;
          if (firstState != null && firstState.isNotEmpty) {
            setStateOrTerritory(i, firstState);
          }
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

  /// add new

  void addAnotherLicence() {
    licenceBlocks.add(LicenceBlockModel());
    update();
  }

  /// add new

  void removeLicence(int index) {
    licenceBlocks.removeAt(index);
    update();
  }

  /// STATE SELECT
  void setStateOrTerritory(int index, String value) {
    final block = licenceBlocks[index];

    block.selectedStateOrTerritory = value;

    block.filteredLicenceTypes =
        listOfLicenceTypeModel.licenceTypes
            ?.where(
              (e) =>
                  e.stateOrTerritory != null &&
                  e.stateOrTerritory!.trim().toLowerCase() ==
                      value.trim().toLowerCase(),
            )
            .toList() ??
        [];

    block.selectedLicenseTypes.clear();
    block.licenceTypeNumbers.clear();

    print("✅ [$index] State: $value");
    print("✅ [$index] Filtered: ${block.filteredLicenceTypes.length}");

    update();
  }

  void toggleSelectedLicenseType(String value, int index) {
    final block = licenceBlocks[index];

    if (block.selectedLicenseTypes.contains(value)) {
      block.selectedLicenseTypes.remove(value);
    } else {
      block.selectedLicenseTypes.add(value);
    }

    block.licenceTypeNumbers.clear();
    for (var licence in listOfLicenceTypeModel.licenceTypes ?? []) {
      if (block.selectedLicenseTypes.contains(licence.title)) {
        block.licenceTypeNumbers.add(licence.id.toString());
      }
    }

    print("✅ [$index] Selected: ${block.selectedLicenseTypes}");
    print("✅ [$index] IDs: ${block.licenceTypeNumbers}");

    update();
  }

  Future<void> pickLicences({
    required BuildContext context,
    required int index,
  }) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );

    if (result == null || result.files.length != 2) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Select exactly 2 images"),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    licenceBlocks[index].licenceFiles = result;

    await startUploadingAnimation(index);

    update();
  }

  Future<void> startUploadingAnimation(int index) async {
    licenceBlocks[index].uploadingPercent = 0;
    licenceBlocks[index].uploadSeconds = 5;
    update();

    for (int i = 1; i <= 5; i++) {
      await Future.delayed(const Duration(seconds: 1));
      licenceBlocks[index].uploadingPercent += 20;
      licenceBlocks[index].uploadSeconds--;
      update();
    }
  }

  Future<void> startUploadingAnimation1() async {
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

    await startUploadingAnimation1();

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

  Future<void> submitThirdStepData({required BuildContext context}) async {
    nextButtonInProgress = true;
    update();

    try {
      DioClient dioClient = DioClient();

      final formData = dio.FormData();

      for (int i = 0; i < licenceBlocks.length; i++) {
        final block = licenceBlocks[i];

        // Validate files
        if (block.licenceFiles == null || block.licenceFiles!.files.isEmpty) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Please upload licence for all sections"),
                backgroundColor: AppColors.primaryRed,
              ),
            );
          }
          nextButtonInProgress = false;
          update();
          return;
        }

        // Add text fields
        formData.fields.add(
          MapEntry("$i.state_or_territory", block.selectedStateOrTerritory),
        );
        formData.fields.add(
          MapEntry("$i.expire_date", block.expiryTEC.text.trim()),
        );

        // Add multiple licence types
        for (var licenceType in block.licenceTypeNumbers) {
          formData.fields.add(
            MapEntry("$i.licence_types", licenceType.toString()),
          );
        }

        // Add files individually
        for (var file in block.licenceFiles!.files) {
          formData.files.add(
            MapEntry(
              "$i.licence_images",
              await dio.MultipartFile.fromFile(file.path!, filename: file.name),
            ),
          );
        }
      }

      // Debug
      print(
        "Submitting FormData after :"
        "${formData.fields}",
      );
      formData.fields.forEach((f) => print("Field: ${f.key} = ${f.value}"));
      formData.files.forEach(
        (f) => print("File: ${f.key} = ${f.value.filename}"),
      );

      print("Submitting FormData before: ${formData.fields}");

      await dioClient.post(ApiEndpoints.addLicenceUrl, data: formData);

      print("Submitting FormData: ${formData.fields}");

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Updated Successfully"),
            backgroundColor: AppColors.primaryGreen,
          ),
        );
      }
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
    update();
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

      Get.offAllNamed(AppRoutes.bottomNavbarRoute);

      //Get.offAllNamed(AppRoutes.loginRoute);
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
   // increasePageIndex();
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
