

class EngagementListModel {
  bool? success;
  String? message;
  List<Engagement>? engagements;

  EngagementListModel({this.success, this.message, this.engagements});

  factory EngagementListModel.fromJson(Map<String, dynamic> json) {
    return EngagementListModel(
      success: json['success'],
      message: json['message'],
      engagements: json['engagements'] != null
          ? List<Engagement>.from(
              json['engagements'].map((x) => Engagement.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'engagements':
            engagements != null ? engagements!.map((x) => x.toJson()).toList() : null,
      };
}

class Engagement {
  int? id;
  JobDetails? jobDetails;
  Application? application;
  String? operativeTrackers;
  String? contactsTrackers;
  String? amendTrackers;
  String? amendDetails;
  String? newEndTime;
  String? totalAmount;
  String? newJobDuration;
  String? signaturePartyA;
  String? signaturePartyB;

  Engagement({
    this.id,
    this.jobDetails,
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

  factory Engagement.fromJson(Map<String, dynamic> json) {
    return Engagement(
      id: json['id'],
      jobDetails: json['job_details'] != null
          ? JobDetails.fromJson(json['job_details'])
          : null,
      application: json['application'] != null
          ? Application.fromJson(json['application'])
          : null,
      operativeTrackers: json['operative_trackers'],
      contactsTrackers: json['contacts_trackers'],
      amendTrackers: json['amend_trackers'],
      amendDetails: json['amend_details'],
      newEndTime: json['new_end_time'],
      totalAmount: json['total_amount'],
      newJobDuration: json['new_job_duration'],
      signaturePartyA: json['signature_party_a'],
      signaturePartyB: json['signature_party_b'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'job_details': jobDetails?.toJson(),
        'application': application?.toJson(),
        'operative_trackers': operativeTrackers,
        'contacts_trackers': contactsTrackers,
        'amend_trackers': amendTrackers,
        'amend_details': amendDetails,
        'new_end_time': newEndTime,
        'total_amount': totalAmount,
        'new_job_duration': newJobDuration,
        'signature_party_a': signaturePartyA,
        'signature_party_b': signaturePartyB,
      };
}

class JobDetails {
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
  double? providentFund;
  String? jobDetailsText;
  String? createdAt;
  String? updatedAt;

  JobDetails({
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
    this.providentFund,
    this.jobDetailsText,
    this.createdAt,
    this.updatedAt,
  });

  factory JobDetails.fromJson(Map<String, dynamic> json) {
    return JobDetails(
      id: json['id'],
      jobProvider: json['job_provider'] != null
          ? JobProvider.fromJson(json['job_provider'])
          : null,
      jobTitle: json['job_title'],
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      address: json['address'],
      jobDate: json['job_date'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      jobDuration: json['job_duration'],
      payType: json['pay_type'],
      payRate: json['pay_rate'],
      operativeRequired: json['operative_required'],
      licenceTypeRequirements: json['licence_type_requirements'],
      minRatingRequirements: json['min_rating_requirements'],
      accreditationsRequirements: json['accreditations_requirements'],
      isPreferredGuard: json['is_preferred_guard'],
      genderRequirements: json['gender_requirements'],
      languageRequirements: json['language_requirements'],
      status: json['status'],
      engagementType: json['engagement_type'],
      providentFund: (json['provident_fund'] as num?)?.toDouble(),
      jobDetailsText: json['job_details'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'job_provider': jobProvider?.toJson(),
        'job_title': jobTitle,
        'latitude': latitude,
        'longitude': longitude,
        'address': address,
        'job_date': jobDate,
        'start_time': startTime,
        'end_time': endTime,
        'job_duration': jobDuration,
        'pay_type': payType,
        'pay_rate': payRate,
        'operative_required': operativeRequired,
        'licence_type_requirements': licenceTypeRequirements,
        'min_rating_requirements': minRatingRequirements,
        'accreditations_requirements': accreditationsRequirements,
        'is_preferred_guard': isPreferredGuard,
        'gender_requirements': genderRequirements,
        'language_requirements': languageRequirements,
        'status': status,
        'engagement_type': engagementType,
        'provident_fund': providentFund,
        'job_details': jobDetailsText,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
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

  factory JobProvider.fromJson(Map<String, dynamic> json) {
    return JobProvider(
      id: json['id'],
      company: json['company'] != null ? Company.fromJson(json['company']) : null,
      companyName: json['company_name'],
      phoneNumber: json['phone_number'],
      abnNumber: json['abn_number'],
      averageRatingMain: json['average_rating_main'],
      averageComunication: json['average_comunication'],
      averageReliability: json['average_reliability'],
      averagePayRate: json['average_pay_rate'],
      averageProfessionalism: json['average_professionalism'],
      averageJobSupport: json['average_job_support'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'company': company?.toJson(),
        'company_name': companyName,
        'phone_number': phoneNumber,
        'abn_number': abnNumber,
        'average_rating_main': averageRatingMain,
        'average_comunication': averageComunication,
        'average_reliability': averageReliability,
        'average_pay_rate': averagePayRate,
        'average_professionalism': averageProfessionalism,
        'average_job_support': averageJobSupport,
      };
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

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      firstName: json['first_name'],
      email: json['email'],
      phone: json['phone'],
      isEmailVarified: json['is_email_varified'],
      createAt: json['create_at'],
      updatedAt: json['updated_at'],
      image: json['image'],
      lastActivity: json['last_activity'],
      userType: json['user_type'],
      gender: json['gender'],
      isAdminAproved: json['is_admin_aproved'],
      isAdminRejected: json['is_admin_rejected'],
      isSubscribe: json['is_subscribe'],
      exprienceInYears: json['exprience_in_years'],
      licences: json['licences'] != null
          ? List<Licence>.from(json['licences'].map((x) => Licence.fromJson(x)))
          : null,
      accreditations: json['accreditations'] != null
          ? List<Accreditation>.from(
              json['accreditations'].map((x) => Accreditation.fromJson(x)))
          : null,
      bankName: json['bank_name'],
      accountHolderName: json['account_holder_name'],
      accountNo: json['account_no'],
      bankBranch: json['bank_branch'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'first_name': firstName,
        'email': email,
        'phone': phone,
        'is_email_varified': isEmailVarified,
        'create_at': createAt,
        'updated_at': updatedAt,
        'image': image,
        'last_activity': lastActivity,
        'user_type': userType,
        'gender': gender,
        'is_admin_aproved': isAdminAproved,
        'is_admin_rejected': isAdminRejected,
        'is_subscribe': isSubscribe,
        'exprience_in_years': exprienceInYears,
        'licences': licences?.map((x) => x.toJson()).toList(),
        'accreditations': accreditations?.map((x) => x.toJson()).toList(),
        'bank_name': bankName,
        'account_holder_name': accountHolderName,
        'account_no': accountNo,
        'bank_branch': bankBranch,
      };
}

// Licence, LicenceType, LicenceImage
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

  factory Licence.fromJson(Map<String, dynamic> json) {
    return Licence(
      id: json['id'],
      stateOrTerritory: json['state_or_territory'],
      licenceNo: json['licence_no'],
      expireDate: json['expire_date'],
      createdAt: json['created_at'],
      licenceType: json['licence_type'] != null
          ? LicenceType.fromJson(json['licence_type'])
          : null,
      licenceImages: json['licence_images'] != null
          ? List<LicenceImage>.from(
              json['licence_images'].map((x) => LicenceImage.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'state_or_territory': stateOrTerritory,
        'licence_no': licenceNo,
        'expire_date': expireDate,
        'created_at': createdAt,
        'licence_type': licenceType?.toJson(),
        'licence_images': licenceImages?.map((x) => x.toJson()).toList(),
      };
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

  factory LicenceType.fromJson(Map<String, dynamic> json) {
    return LicenceType(
      id: json['id'],
      title: json['title'],
      discription: json['discription'],
      isActive: json['is_active'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'discription': discription,
        'is_active': isActive,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}

class LicenceImage {
  int? id;
  String? file;
  String? createdAt;
  String? updatedAt;

  LicenceImage({this.id, this.file, this.createdAt, this.updatedAt});

  factory LicenceImage.fromJson(Map<String, dynamic> json) {
    return LicenceImage(
      id: json['id'],
      file: json['file'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'file': file,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}

// Accreditation and AccreditationType
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

  factory Accreditation.fromJson(Map<String, dynamic> json) {
    return Accreditation(
      id: json['id'],
      accreditation: json['accreditation'],
      expireDate: json['expire_date'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      accreditationType: json['accreditation_type'] != null
          ? AccreditationType.fromJson(json['accreditation_type'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'accreditation': accreditation,
        'expire_date': expireDate,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'accreditation_type': accreditationType?.toJson(),
      };
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

  factory AccreditationType.fromJson(Map<String, dynamic> json) {
    return AccreditationType(
      id: json['id'],
      title: json['title'],
      discription: json['discription'],
      isActive: json['is_active'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'discription': discription,
        'is_active': isActive,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}

// Application & Candidate
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

  factory Application.fromJson(Map<String, dynamic> json) {
    return Application(
      id: json['id'],
      status: json['status'],
      candidate:
          json['candidate'] != null ? Candidate.fromJson(json['candidate']) : null,
      currency: json['currency'],
      isAdminAproved: json['is_admin_aproved'],
      avgRatingMain: json['avg_rating_main'],
      avgPresentationGrooming: json['avg_presentation_grooming'],
      avgCommunication: json['avg_communication'],
      avgReportsAdministration: json['avg_reports_administration'],
      avgPunctualityReliability: json['avg_punctuality_reliability'],
      avgSkillsAttributes: json['avg_skills_attributes'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'status': status,
        'candidate': candidate?.toJson(),
        'currency': currency,
        'is_admin_aproved': isAdminAproved,
        'avg_rating_main': avgRatingMain,
        'avg_presentation_grooming': avgPresentationGrooming,
        'avg_communication': avgCommunication,
        'avg_reports_administration': avgReportsAdministration,
        'avg_punctuality_reliability': avgPunctualityReliability,
        'avg_skills_attributes': avgSkillsAttributes,
      };
}

class Candidate {
  int? id;
  String? firstName;
  String? email;
  String? phone;
  String? gender;
  String? image;

  Candidate({
    this.id,
    this.firstName,
    this.email,
    this.phone,
    this.gender,
    this.image,
  });

  factory Candidate.fromJson(Map<String, dynamic> json) {
    return Candidate(
      id: json['id'],
      firstName: json['first_name'],
      email: json['email'],
      phone: json['phone'],
      gender: json['gender'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'first_name': firstName,
        'email': email,
        'phone': phone,
        'gender': gender,
        'image': image,
      };
}

