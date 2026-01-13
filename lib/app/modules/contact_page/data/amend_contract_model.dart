class AmendContractModel {
  bool? success;
  String? message;
  List<AmendEngagements> amendEngagements;

  AmendContractModel({
    this.success,
    this.message,
    List<AmendEngagements>? amendEngagements,
  }) : amendEngagements = amendEngagements ?? [];

  AmendContractModel.fromJson(dynamic json)
      : success = json['success'] as bool?,
        message = json['message'] as String?,
        amendEngagements = (json['engagements'] as List<dynamic>?)
                ?.map((e) => AmendEngagements.fromJson(e))
                .toList() ??
            [];
}


class AmendEngagements {
  int? id;
  AmendJobDetails? amendJobDetails;
  Application? application;
  String? operativeTrackers;
  String? contactsTrackers;
  String? amendTrackers;
  String? amendDetails;
  String? newEndTime;
  String? totalAmount;
  String? newJobDuration;
  dynamic signaturePartyA;
  dynamic signaturePartyB;

  AmendEngagements({
    this.id,
    this.amendJobDetails,
    this.application,
    this.operativeTrackers,
    this.contactsTrackers,
    this.amendTrackers,
    this.amendDetails,
    this.newEndTime,
    this.totalAmount,
    this.newJobDuration,
    this.signaturePartyA,
    this.signaturePartyB,
  });

  AmendEngagements.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amendJobDetails = json['job_details'] != null
        ? AmendJobDetails.fromJson(json['job_details'])
        : null;
    application = json['application'] != null
        ? Application.fromJson(json['application'])
        : null;
    operativeTrackers = json['operative_trackers'];
    contactsTrackers = json['contacts_trackers'];
    amendTrackers = json['amend_trackers'];
    amendDetails = json['amend_details'];
    newEndTime = json['new_end_time'];
    totalAmount = json['total_amount'];
    newJobDuration = json['new_job_duration'];
    signaturePartyA = json['signature_party_a'];
    signaturePartyB = json['signature_party_b'];
  }
}

class AmendJobDetails {
  int? id;
  JobProvider? jobProvider;
  String? jobTitle;
  double? latitude;
  double? longitude;
  String? address;
  String? jobDate;
  String? startTime;
  String? endTime;
  String? jobDuration;
  String? payType;
  String? payRate;
  int? operativeRequired;
  int? licenceTypeRequirements;
  int? minRatingRequirements;
  int? accreditationsRequirements;
  String? isPreferredGuard;
  String? genderRequirements;
  String? languageRequirements;
  String? status;
  String? engagementType;
  String? jobDetails; // description
  String? createdAt;
  String? updatedAt;

  AmendJobDetails({
    this.id,
    this.jobProvider,
    this.jobTitle,
    this.latitude,
    this.longitude,
    this.address,
    this.jobDate,
    this.startTime,
    this.endTime,
    this.jobDuration,
    this.payType,
    this.payRate,
    this.operativeRequired,
    this.licenceTypeRequirements,
    this.minRatingRequirements,
    this.accreditationsRequirements,
    this.isPreferredGuard,
    this.genderRequirements,
    this.languageRequirements,
    this.status,
    this.engagementType,
    this.jobDetails,
    this.createdAt,
    this.updatedAt,
  });

  AmendJobDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobProvider = json['job_provider'] != null
        ? JobProvider.fromJson(json['job_provider'])
        : null;
    jobTitle = json['job_title'];
    latitude = (json['latitude'] as num?)?.toDouble();
    longitude = (json['longitude'] as num?)?.toDouble();
    address = json['address'];
    jobDate = json['job_date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    jobDuration = json['job_duration'];
    payType = json['pay_type'];
    payRate = json['pay_rate'];
    operativeRequired = json['operative_required'];
    licenceTypeRequirements = json['licence_type_requirements'];
    minRatingRequirements = json['min_rating_requirements'];
    accreditationsRequirements = json['accreditations_requirements'];
    isPreferredGuard = json['is_preferred_guard'];
    genderRequirements = json['gender_requirements'];
    languageRequirements = json['language_requirements'];
    status = json['status'];
    engagementType = json['engagement_type'];
    jobDetails = json['job_details'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class JobProvider {
  int? id;
  Company? company;
  String? companyName;
  String? phoneNumber;
  int? abnNumber;
  String? averageRatingMain;
  String? averageComunication;
  String? averageReliability;
  String? averagePayRate;
  String? averageProfessionalism;
  String? averageJobSupport;

  JobProvider({
    this.id,
    this.company,
    this.companyName,
    this.phoneNumber,
    this.abnNumber,
    this.averageRatingMain,
    this.averageComunication,
    this.averageReliability,
    this.averagePayRate,
    this.averageProfessionalism,
    this.averageJobSupport,
  });

  JobProvider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    company = json['company'] != null ? Company.fromJson(json['company']) : null;
    companyName = json['company_name'];
    phoneNumber = json['phone_number'];
    abnNumber = json['abn_number'];
    averageRatingMain = json['average_rating_main'];
    averageComunication = json['average_comunication'];
    averageReliability = json['average_reliability'];
    averagePayRate = json['average_pay_rate'];
    averageProfessionalism = json['average_professionalism'];
    averageJobSupport = json['average_job_support'];
  }
}

class Company {
  int? id;
  String? firstName;
  String? email;
  String? phone;
  bool? isEmailVarified;
  String? createAt;
  String? updatedAt;
  String? image;
  String? lastActivity;
  String? userType;
  String? gender;
  bool? isAdminAproved;
  bool? isAdminRejected;
  bool? isSubscribe;
  int? exprienceInYears;
  List<Licence>? licences;
  List<Accreditation>? accreditations;
  String? bankName;
  String? accountHolderName;
  String? accountNo;
  String? bankBranch;

  Company({
    this.id,
    this.firstName,
    this.email,
    this.phone,
    this.isEmailVarified,
    this.createAt,
    this.updatedAt,
    this.image,
    this.lastActivity,
    this.userType,
    this.gender,
    this.isAdminAproved,
    this.isAdminRejected,
    this.isSubscribe,
    this.exprienceInYears,
    this.licences,
    this.accreditations,
    this.bankName,
    this.accountHolderName,
    this.accountNo,
    this.bankBranch,
  });

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    email = json['email'];
    phone = json['phone'];
    isEmailVarified = json['is_email_varified'];
    createAt = json['create_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
    lastActivity = json['last_activity'];
    userType = json['user_type'];
    gender = json['gender'];
    isAdminAproved = json['is_admin_aproved'];
    isAdminRejected = json['is_admin_rejected'];
    isSubscribe = json['is_subscribe'];
    exprienceInYears = json['exprience_in_years'];
    if (json['licences'] != null) {
      licences = [];
      json['licences'].forEach((v) {
        licences!.add(Licence.fromJson(v));
      });
    }
    if (json['accreditations'] != null) {
      accreditations = [];
      json['accreditations'].forEach((v) {
        accreditations!.add(Accreditation.fromJson(v));
      });
    }
    bankName = json['bank_name'];
    accountHolderName = json['account_holder_name'];
    accountNo = json['account_no'];
    bankBranch = json['bank_branch'];
  }
}

class Licence {
  int? id;
  String? stateOrTerritory;
  String? licenceNo;
  String? expireDate;
  String? createdAt;
  LicenceType? licenceType;
  List<LicenceImage>? licenceImages;

  Licence({
    this.id,
    this.stateOrTerritory,
    this.licenceNo,
    this.expireDate,
    this.createdAt,
    this.licenceType,
    this.licenceImages,
  });

  Licence.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stateOrTerritory = json['state_or_territory'];
    licenceNo = json['licence_no'];
    expireDate = json['expire_date'];
    createdAt = json['created_at'];
    licenceType = json['licence_type'] != null
        ? LicenceType.fromJson(json['licence_type'])
        : null;
    if (json['licence_images'] != null) {
      licenceImages = [];
      json['licence_images'].forEach((v) {
        licenceImages!.add(LicenceImage.fromJson(v));
      });
    }
  }
}

class LicenceType {
  int? id;
  String? title;
  String? discription;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  LicenceType({
    this.id,
    this.title,
    this.discription,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  LicenceType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    discription = json['discription'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class LicenceImage {
  int? id;
  String? file;
  String? createdAt;
  String? updatedAt;

  LicenceImage({this.id, this.file, this.createdAt, this.updatedAt});

  LicenceImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    file = json['file'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class Accreditation {
  int? id;
  String? accreditation;
  String? expireDate;
  String? createdAt;
  String? updatedAt;
  AccreditationType? accreditationType;

  Accreditation({
    this.id,
    this.accreditation,
    this.expireDate,
    this.createdAt,
    this.updatedAt,
    this.accreditationType,
  });

  Accreditation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accreditation = json['accreditation'];
    expireDate = json['expire_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    accreditationType = json['accreditation_type'] != null
        ? AccreditationType.fromJson(json['accreditation_type'])
        : null;
  }
}

class AccreditationType {
  int? id;
  String? title;
  String? discription;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  AccreditationType({
    this.id,
    this.title,
    this.discription,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  AccreditationType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    discription = json['discription'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class Application {
  int? id;
  String? status;
  Candidate? candidate;
  String? currency;
  bool? isAdminAproved;
  String? avgRatingMain;
  String? avgPresentationGrooming;
  String? avgCommunication;
  String? avgReportsAdministration;
  String? avgPunctualityReliability;
  String? avgSkillsAttributes;

  Application({
    this.id,
    this.status,
    this.candidate,
    this.currency,
    this.isAdminAproved,
    this.avgRatingMain,
    this.avgPresentationGrooming,
    this.avgCommunication,
    this.avgReportsAdministration,
    this.avgPunctualityReliability,
    this.avgSkillsAttributes,
  });

  Application.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    candidate =
        json['candidate'] != null ? Candidate.fromJson(json['candidate']) : null;
    currency = json['currency'];
    isAdminAproved = json['is_admin_aproved'];
    avgRatingMain = json['avg_rating_main'];
    avgPresentationGrooming = json['avg_presentation_grooming'];
    avgCommunication = json['avg_communication'];
    avgReportsAdministration = json['avg_reports_administration'];
    avgPunctualityReliability = json['avg_punctuality_reliability'];
    avgSkillsAttributes = json['avg_skills_attributes'];
  }
}

class Candidate {
  int? id;
  String? firstName;
  String? email;
  String? phone;
  bool? isEmailVarified;
  String? createAt;
  String? updatedAt;
  String? image;
  String? lastActivity;
  String? userType;
  String? gender;
  bool? isAdminAproved;
  bool? isAdminRejected;
  bool? isSubscribe;
  int? exprienceInYears;
  List<Licence>? licences;
  List<Accreditation>? accreditations;
  String? bankName;
  String? accountHolderName;
  String? accountNo;
  String? bankBranch;

  Candidate({
    this.id,
    this.firstName,
    this.email,
    this.phone,
    this.isEmailVarified,
    this.createAt,
    this.updatedAt,
    this.image,
    this.lastActivity,
    this.userType,
    this.gender,
    this.isAdminAproved,
    this.isAdminRejected,
    this.isSubscribe,
    this.exprienceInYears,
    this.licences,
    this.accreditations,
    this.bankName,
    this.accountHolderName,
    this.accountNo,
    this.bankBranch,
  });

  Candidate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    email = json['email'];
    phone = json['phone'];
    isEmailVarified = json['is_email_varified'];
    createAt = json['create_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
    lastActivity = json['last_activity'];
    userType = json['user_type'];
    gender = json['gender'];
    isAdminAproved = json['is_admin_aproved'];
    isAdminRejected = json['is_admin_rejected'];
    isSubscribe = json['is_subscribe'];
    exprienceInYears = json['exprience_in_years'];
    if (json['licences'] != null) {
      licences = [];
      json['licences'].forEach((v) {
        licences!.add(Licence.fromJson(v));
      });
    }
    if (json['accreditations'] != null) {
      accreditations = [];
      json['accreditations'].forEach((v) {
        accreditations!.add(Accreditation.fromJson(v));
      });
    }
    bankName = json['bank_name'];
    accountHolderName = json['account_holder_name'];
    accountNo = json['account_no'];
    bankBranch = json['bank_branch'];
  }
}
