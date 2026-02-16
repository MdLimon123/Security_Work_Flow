class UpcomingJobModel {
  final int? count;
  final dynamic next;
  final dynamic previous;
  final UpcomingResults? results;

  UpcomingJobModel({
     this.count,
     this.next,
     this.previous,
     this.results,
  });

  factory UpcomingJobModel.fromJson(Map<String, dynamic> json) {
    return UpcomingJobModel(
      count: json['count'] ?? 0,
      next: json['next'],
      previous: json['previous'],
      results: UpcomingResults.fromJson(json['results'] ?? {}),
    );
  }
}
class UpcomingResults {
  final bool success;
  final String message;
  final List<UpcomingJob> myJobs;

  UpcomingResults({
    required this.success,
    required this.message,
    required this.myJobs,
  });

  factory UpcomingResults.fromJson(Map<String, dynamic> json) {
    return UpcomingResults(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      myJobs: (json['my_jobs'] as List?)
              ?.map((e) => UpcomingJob.fromJson(e))
              .toList() ??
          [],
    );
  }
}
class UpcomingJob {
  final int id;
  final UpcomingJobDetails jobDetails;
  final String operativeTrackers;
  final String contactsTrackers;
  final String amendTrackers;
  final String amendDetails;
  final String? newEndTime;
  final double totalAmount;
  final double newJobDuration;
  final String? signaturePartyA;
  final String? signaturePartyB;

  UpcomingJob({
    required this.id,
    required this.jobDetails,
    required this.operativeTrackers,
    required this.contactsTrackers,
    required this.amendTrackers,
    required this.amendDetails,
    this.newEndTime,
    required this.totalAmount,
    required this.newJobDuration,
    this.signaturePartyA,
    this.signaturePartyB,
  });

  factory UpcomingJob.fromJson(Map<String, dynamic> json) {
    return UpcomingJob(
      id: json['id'] ?? 0,
      jobDetails: UpcomingJobDetails.fromJson(json['job_details'] ?? {}),
      operativeTrackers: json['operative_trackers'] ?? '',
      contactsTrackers: json['contacts_trackers'] ?? '',
      amendTrackers: json['amend_trackers'] ?? '',
      amendDetails: json['amend_details'] ?? '',
      newEndTime: json['new_end_time'],
      totalAmount:
          double.tryParse(json['total_amount']?.toString() ?? '0') ?? 0,
      newJobDuration:
          double.tryParse(json['new_job_duration']?.toString() ?? '0') ?? 0,
      signaturePartyA: json['signature_party_a'],
      signaturePartyB: json['signature_party_b'],
    );
  }
}
class UpcomingJobDetails {
  final int id;
  final String jobTitle;
  final UpcomingJobProvider jobProvider;
  final double latitude;
  final double longitude;
  final String address;
  final String jobDate;
  final String startTime;
  final String endTime;
  final double jobDuration;
  final String payType;
  final double payRate;
  final int operativeRequired;
  final int licenceTypeRequirements;
  final int minRatingRequirements;
  final int accreditationsRequirements;
  final String isPreferredGuard;
  final String genderRequirements;
  final String languageRequirements;
  final String status;
  final String engagementType;
  final int providentFund;
  final String jobDetails;
  final String createdAt;
  final String updatedAt;

  UpcomingJobDetails({
    required this.id,
    required this.jobTitle,
    required this.jobProvider,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.jobDate,
    required this.startTime,
    required this.endTime,
    required this.jobDuration,
    required this.payType,
    required this.payRate,
    required this.operativeRequired,
    required this.licenceTypeRequirements,
    required this.minRatingRequirements,
    required this.accreditationsRequirements,
    required this.isPreferredGuard,
    required this.genderRequirements,
    required this.languageRequirements,
    required this.status,
    required this.engagementType,
    required this.providentFund,
    required this.jobDetails,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UpcomingJobDetails.fromJson(Map<String, dynamic> json) {
    return UpcomingJobDetails(
      id: json['id'] ?? 0,
      jobTitle: json['job_title'] ?? '',
      jobProvider:
          UpcomingJobProvider.fromJson(json['job_provider'] ?? {}),
      latitude:
          double.tryParse(json['latitude']?.toString() ?? '0') ?? 0,
      longitude:
          double.tryParse(json['longitude']?.toString() ?? '0') ?? 0,
      address: json['address'] ?? '',
      jobDate: json['job_date'] ?? '',
      startTime: json['start_time'] ?? '',
      endTime: json['end_time'] ?? '',
      jobDuration:
          double.tryParse(json['job_duration']?.toString() ?? '0') ?? 0,
      payType: json['pay_type'] ?? '',
      payRate:
          double.tryParse(json['pay_rate']?.toString() ?? '0') ?? 0,
      operativeRequired: json['operative_required'] ?? 0,
      licenceTypeRequirements:
          json['licence_type_requirements'] ?? 0,
      minRatingRequirements:
          json['min_rating_requirements'] ?? 0,
      accreditationsRequirements:
          json['accreditations_requirements'] ?? 0,
      isPreferredGuard: json['is_preferred_guard'] ?? '',
      genderRequirements: json['gender_requirements'] ?? '',
      languageRequirements: json['language_requirements'] ?? '',
      status: json['status'] ?? '',
      engagementType: json['engagement_type'] ?? '',
      providentFund: json['provident_fund'] ?? 0,
      jobDetails: json['job_details'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}
class UpcomingJobProvider {
  final int id;
  final UpcomingCompany company;
  final String? companyName;
  final String? phoneNumber;
  final String? abnNumber;
  final double averageRatingMain;
  final double averageCommunication;
  final double averageReliability;
  final double averagePayRate;
  final double averageProfessionalism;
  final double averageJobSupport;

  UpcomingJobProvider({
    required this.id,
    required this.company,
    this.companyName,
    this.phoneNumber,
    this.abnNumber,
    required this.averageRatingMain,
    required this.averageCommunication,
    required this.averageReliability,
    required this.averagePayRate,
    required this.averageProfessionalism,
    required this.averageJobSupport,
  });

  factory UpcomingJobProvider.fromJson(Map<String, dynamic> json) {
    return UpcomingJobProvider(
      id: json['id'] ?? 0,
      company: UpcomingCompany.fromJson(json['company'] ?? {}),
      companyName: json['company_name'],
      phoneNumber: json['phone_number'],
      abnNumber: json['abn_number'],
      averageRatingMain:
          double.tryParse(json['average_rating_main']?.toString() ?? '0') ?? 0,
      averageCommunication:
          double.tryParse(json['average_comunication']?.toString() ?? '0') ?? 0,
      averageReliability:
          double.tryParse(json['average_reliability']?.toString() ?? '0') ?? 0,
      averagePayRate:
          double.tryParse(json['average_pay_rate']?.toString() ?? '0') ?? 0,
      averageProfessionalism:
          double.tryParse(json['average_professionalism']?.toString() ?? '0') ??
              0,
      averageJobSupport:
          double.tryParse(json['average_job_support']?.toString() ?? '0') ?? 0,
    );
  }
}
class UpcomingCompany {
  final int id;
  final String firstName;
  final String email;
  final String? phone;
  final bool isEmailVarified;
  final String? image;
  final String userType;
  final bool isAdminApproved;
  final bool isSubscribe;

  UpcomingCompany({
    required this.id,
    required this.firstName,
    required this.email,
    this.phone,
    required this.isEmailVarified,
    this.image,
    required this.userType,
    required this.isAdminApproved,
    required this.isSubscribe,
  });

  factory UpcomingCompany.fromJson(Map<String, dynamic> json) {
    return UpcomingCompany(
      id: json['id'] ?? 0,
      firstName: json['first_name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      isEmailVarified: json['is_email_varified'] ?? false,
      image: json['image'],
      userType: json['user_type'] ?? '',
      isAdminApproved: json['is_admin_aproved'] ?? false,
      isSubscribe: json['is_subscribe'] ?? false,
    );
  }
}
