/// count : 1
/// next : null
/// previous : null
/// results : {"success":true,"message":"data fetched!","my_jobs":[{"id":3,"job_details":{"id":8,"job_title":"Crown Control Operatives","latitude":23.78521422,"longitude":90.9021522,"address":"Mohakhali, Dhaka, Bangladesh","job_date":"2025-12-10","start_time":"10:00:00","end_time":"20:00:00","job_duration":"10.00","pay_type":"negotiation","pay_rate":"25.00","operative_required":15,"licence_type_requirements":1,"min_rating_requirements":3,"accreditations_requirements":1,"is_preferred_guard":"no","gender_requirements":"male","language_requirements":"english","status":"published","engagement_type":"casual","provident_fund":0,"job_details":"the quick brown fox jump over the alzy dog.The Quick Brown fox jump over the lazy deog. Tiger Security company","created_at":"2025-12-23T08:48:47.363084Z","updated_at":"2025-12-29T06:24:52.919484Z"},"operative_trackers":"notstartyet","contacts_trackers":"pending","amend_trackers":"not_amend","amend_details":"","new_end_time":null,"total_amount":"250.00","new_job_duration":"0.00","signature_party_a":null,"signature_party_b":null}]}
library;

class JobHistoryListModel {
  JobHistoryListModel({
    num? count,
    dynamic next,
    dynamic previous,
    Results? results,
  }) {
    _count = count;
    _next = next;
    _previous = previous;
    _results = results;
  }

  JobHistoryListModel.fromJson(dynamic json) {
    _count = json['count'];
    _next = json['next'];
    _previous = json['previous'];
    _results = json['results'] != null
        ? Results.fromJson(json['results'])
        : null;
  }

  num? _count;
  dynamic _next;
  dynamic _previous;
  Results? _results;

  JobHistoryListModel copyWith({
    num? count,
    dynamic next,
    dynamic previous,
    Results? results,
  }) => JobHistoryListModel(
    count: count ?? _count,
    next: next ?? _next,
    previous: previous ?? _previous,
    results: results ?? _results,
  );

  num? get count => _count;

  dynamic get next => _next;

  dynamic get previous => _previous;

  Results? get results => _results;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = _count;
    map['next'] = _next;
    map['previous'] = _previous;
    if (_results != null) {
      map['results'] = _results?.toJson();
    }
    return map;
  }
}

/// success : true
/// message : "data fetched!"
/// my_jobs : [{"id":3,"job_details":{"id":8,"job_title":"Crown Control Operatives","latitude":23.78521422,"longitude":90.9021522,"address":"Mohakhali, Dhaka, Bangladesh","job_date":"2025-12-10","start_time":"10:00:00","end_time":"20:00:00","job_duration":"10.00","pay_type":"negotiation","pay_rate":"25.00","operative_required":15,"licence_type_requirements":1,"min_rating_requirements":3,"accreditations_requirements":1,"is_preferred_guard":"no","gender_requirements":"male","language_requirements":"english","status":"published","engagement_type":"casual","provident_fund":0,"job_details":"the quick brown fox jump over the alzy dog.The Quick Brown fox jump over the lazy deog. Tiger Security company","created_at":"2025-12-23T08:48:47.363084Z","updated_at":"2025-12-29T06:24:52.919484Z"},"operative_trackers":"notstartyet","contacts_trackers":"pending","amend_trackers":"not_amend","amend_details":"","new_end_time":null,"total_amount":"250.00","new_job_duration":"0.00","signature_party_a":null,"signature_party_b":null}]

class Results {
  Results({bool? success, String? message, List<MyJobs>? myJobs}) {
    _success = success;
    _message = message;
    _myJobs = myJobs;
  }

  Results.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    if (json['my_jobs'] != null) {
      _myJobs = [];
      json['my_jobs'].forEach((v) {
        _myJobs?.add(MyJobs.fromJson(v));
      });
    }
  }

  bool? _success;
  String? _message;
  List<MyJobs>? _myJobs;

  Results copyWith({bool? success, String? message, List<MyJobs>? myJobs}) =>
      Results(
        success: success ?? _success,
        message: message ?? _message,
        myJobs: myJobs ?? _myJobs,
      );

  bool? get success => _success;

  String? get message => _message;

  List<MyJobs>? get myJobs => _myJobs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_myJobs != null) {
      map['my_jobs'] = _myJobs?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 3
/// job_details : {"id":8,"job_title":"Crown Control Operatives","latitude":23.78521422,"longitude":90.9021522,"address":"Mohakhali, Dhaka, Bangladesh","job_date":"2025-12-10","start_time":"10:00:00","end_time":"20:00:00","job_duration":"10.00","pay_type":"negotiation","pay_rate":"25.00","operative_required":15,"licence_type_requirements":1,"min_rating_requirements":3,"accreditations_requirements":1,"is_preferred_guard":"no","gender_requirements":"male","language_requirements":"english","status":"published","engagement_type":"casual","provident_fund":0,"job_details":"the quick brown fox jump over the alzy dog.The Quick Brown fox jump over the lazy deog. Tiger Security company","created_at":"2025-12-23T08:48:47.363084Z","updated_at":"2025-12-29T06:24:52.919484Z"}
/// operative_trackers : "notstartyet"
/// contacts_trackers : "pending"
/// amend_trackers : "not_amend"
/// amend_details : ""
/// new_end_time : null
/// total_amount : "250.00"
/// new_job_duration : "0.00"
/// signature_party_a : null
/// signature_party_b : null

class MyJobs {
  MyJobs({
    num? id,
    JobDetails? jobDetails,
    String? operativeTrackers,
    String? contactsTrackers,
    String? amendTrackers,
    String? amendDetails,
    dynamic newEndTime,
    String? totalAmount,
    String? newJobDuration,
    dynamic signaturePartyA,
    dynamic signaturePartyB,
  }) {
    _id = id;
    _jobDetails = jobDetails;
    _operativeTrackers = operativeTrackers;
    _contactsTrackers = contactsTrackers;
    _amendTrackers = amendTrackers;
    _amendDetails = amendDetails;
    _newEndTime = newEndTime;
    _totalAmount = totalAmount;
    _newJobDuration = newJobDuration;
    _signaturePartyA = signaturePartyA;
    _signaturePartyB = signaturePartyB;
  }

  MyJobs.fromJson(dynamic json) {
    _id = json['id'];
    _jobDetails = json['job_details'] != null
        ? JobDetails.fromJson(json['job_details'])
        : null;
    _operativeTrackers = json['operative_trackers'];
    _contactsTrackers = json['contacts_trackers'];
    _amendTrackers = json['amend_trackers'];
    _amendDetails = json['amend_details'];
    _newEndTime = json['new_end_time'];
    _totalAmount = json['total_amount'];
    _newJobDuration = json['new_job_duration'];
    _signaturePartyA = json['signature_party_a'];
    _signaturePartyB = json['signature_party_b'];
  }

  num? _id;
  JobDetails? _jobDetails;
  String? _operativeTrackers;
  String? _contactsTrackers;
  String? _amendTrackers;
  String? _amendDetails;
  dynamic _newEndTime;
  String? _totalAmount;
  String? _newJobDuration;
  dynamic _signaturePartyA;
  dynamic _signaturePartyB;

  MyJobs copyWith({
    num? id,
    JobDetails? jobDetails,
    String? operativeTrackers,
    String? contactsTrackers,
    String? amendTrackers,
    String? amendDetails,
    dynamic newEndTime,
    String? totalAmount,
    String? newJobDuration,
    dynamic signaturePartyA,
    dynamic signaturePartyB,
  }) => MyJobs(
    id: id ?? _id,
    jobDetails: jobDetails ?? _jobDetails,
    operativeTrackers: operativeTrackers ?? _operativeTrackers,
    contactsTrackers: contactsTrackers ?? _contactsTrackers,
    amendTrackers: amendTrackers ?? _amendTrackers,
    amendDetails: amendDetails ?? _amendDetails,
    newEndTime: newEndTime ?? _newEndTime,
    totalAmount: totalAmount ?? _totalAmount,
    newJobDuration: newJobDuration ?? _newJobDuration,
    signaturePartyA: signaturePartyA ?? _signaturePartyA,
    signaturePartyB: signaturePartyB ?? _signaturePartyB,
  );

  num? get id => _id;

  JobDetails? get jobDetails => _jobDetails;

  String? get operativeTrackers => _operativeTrackers;

  String? get contactsTrackers => _contactsTrackers;

  String? get amendTrackers => _amendTrackers;

  String? get amendDetails => _amendDetails;

  dynamic get newEndTime => _newEndTime;

  String? get totalAmount => _totalAmount;

  String? get newJobDuration => _newJobDuration;

  dynamic get signaturePartyA => _signaturePartyA;

  dynamic get signaturePartyB => _signaturePartyB;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    if (_jobDetails != null) {
      map['job_details'] = _jobDetails?.toJson();
    }
    map['operative_trackers'] = _operativeTrackers;
    map['contacts_trackers'] = _contactsTrackers;
    map['amend_trackers'] = _amendTrackers;
    map['amend_details'] = _amendDetails;
    map['new_end_time'] = _newEndTime;
    map['total_amount'] = _totalAmount;
    map['new_job_duration'] = _newJobDuration;
    map['signature_party_a'] = _signaturePartyA;
    map['signature_party_b'] = _signaturePartyB;
    return map;
  }
}

/// id : 8
/// job_title : "Crown Control Operatives"
/// latitude : 23.78521422
/// longitude : 90.9021522
/// address : "Mohakhali, Dhaka, Bangladesh"
/// job_date : "2025-12-10"
/// start_time : "10:00:00"
/// end_time : "20:00:00"
/// job_duration : "10.00"
/// pay_type : "negotiation"
/// pay_rate : "25.00"
/// operative_required : 15
/// licence_type_requirements : 1
/// min_rating_requirements : 3
/// accreditations_requirements : 1
/// is_preferred_guard : "no"
/// gender_requirements : "male"
/// language_requirements : "english"
/// status : "published"
/// engagement_type : "casual"
/// provident_fund : 0
/// job_details : "the quick brown fox jump over the alzy dog.The Quick Brown fox jump over the lazy deog. Tiger Security company"
/// created_at : "2025-12-23T08:48:47.363084Z"
/// updated_at : "2025-12-29T06:24:52.919484Z"

class JobDetails {
  JobDetails({
    num? id,
    String? jobTitle,
    num? latitude,
    num? longitude,
    String? address,
    String? jobDate,
    String? startTime,
    String? endTime,
    String? jobDuration,
    String? payType,
    String? payRate,
    num? operativeRequired,
    num? licenceTypeRequirements,
    num? minRatingRequirements,
    num? accreditationsRequirements,
    String? isPreferredGuard,
    String? genderRequirements,
    String? languageRequirements,
    String? status,
    String? engagementType,
    num? providentFund,
    String? jobDetails,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _jobTitle = jobTitle;
    _latitude = latitude;
    _longitude = longitude;
    _address = address;
    _jobDate = jobDate;
    _startTime = startTime;
    _endTime = endTime;
    _jobDuration = jobDuration;
    _payType = payType;
    _payRate = payRate;
    _operativeRequired = operativeRequired;
    _licenceTypeRequirements = licenceTypeRequirements;
    _minRatingRequirements = minRatingRequirements;
    _accreditationsRequirements = accreditationsRequirements;
    _isPreferredGuard = isPreferredGuard;
    _genderRequirements = genderRequirements;
    _languageRequirements = languageRequirements;
    _status = status;
    _engagementType = engagementType;
    _providentFund = providentFund;
    _jobDetails = jobDetails;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  JobDetails.fromJson(dynamic json) {
    _id = json['id'];
    _jobTitle = json['job_title'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _address = json['address'];
    _jobDate = json['job_date'];
    _startTime = json['start_time'];
    _endTime = json['end_time'];
    _jobDuration = json['job_duration'];
    _payType = json['pay_type'];
    _payRate = json['pay_rate'];
    _operativeRequired = json['operative_required'];
    _licenceTypeRequirements = json['licence_type_requirements'];
    _minRatingRequirements = json['min_rating_requirements'];
    _accreditationsRequirements = json['accreditations_requirements'];
    _isPreferredGuard = json['is_preferred_guard'];
    _genderRequirements = json['gender_requirements'];
    _languageRequirements = json['language_requirements'];
    _status = json['status'];
    _engagementType = json['engagement_type'];
    _providentFund = json['provident_fund'];
    _jobDetails = json['job_details'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  num? _id;
  String? _jobTitle;
  num? _latitude;
  num? _longitude;
  String? _address;
  String? _jobDate;
  String? _startTime;
  String? _endTime;
  String? _jobDuration;
  String? _payType;
  String? _payRate;
  num? _operativeRequired;
  num? _licenceTypeRequirements;
  num? _minRatingRequirements;
  num? _accreditationsRequirements;
  String? _isPreferredGuard;
  String? _genderRequirements;
  String? _languageRequirements;
  String? _status;
  String? _engagementType;
  num? _providentFund;
  String? _jobDetails;
  String? _createdAt;
  String? _updatedAt;

  JobDetails copyWith({
    num? id,
    String? jobTitle,
    num? latitude,
    num? longitude,
    String? address,
    String? jobDate,
    String? startTime,
    String? endTime,
    String? jobDuration,
    String? payType,
    String? payRate,
    num? operativeRequired,
    num? licenceTypeRequirements,
    num? minRatingRequirements,
    num? accreditationsRequirements,
    String? isPreferredGuard,
    String? genderRequirements,
    String? languageRequirements,
    String? status,
    String? engagementType,
    num? providentFund,
    String? jobDetails,
    String? createdAt,
    String? updatedAt,
  }) => JobDetails(
    id: id ?? _id,
    jobTitle: jobTitle ?? _jobTitle,
    latitude: latitude ?? _latitude,
    longitude: longitude ?? _longitude,
    address: address ?? _address,
    jobDate: jobDate ?? _jobDate,
    startTime: startTime ?? _startTime,
    endTime: endTime ?? _endTime,
    jobDuration: jobDuration ?? _jobDuration,
    payType: payType ?? _payType,
    payRate: payRate ?? _payRate,
    operativeRequired: operativeRequired ?? _operativeRequired,
    licenceTypeRequirements:
        licenceTypeRequirements ?? _licenceTypeRequirements,
    minRatingRequirements: minRatingRequirements ?? _minRatingRequirements,
    accreditationsRequirements:
        accreditationsRequirements ?? _accreditationsRequirements,
    isPreferredGuard: isPreferredGuard ?? _isPreferredGuard,
    genderRequirements: genderRequirements ?? _genderRequirements,
    languageRequirements: languageRequirements ?? _languageRequirements,
    status: status ?? _status,
    engagementType: engagementType ?? _engagementType,
    providentFund: providentFund ?? _providentFund,
    jobDetails: jobDetails ?? _jobDetails,
    createdAt: createdAt ?? _createdAt,
    updatedAt: updatedAt ?? _updatedAt,
  );

  num? get id => _id;

  String? get jobTitle => _jobTitle;

  num? get latitude => _latitude;

  num? get longitude => _longitude;

  String? get address => _address;

  String? get jobDate => _jobDate;

  String? get startTime => _startTime;

  String? get endTime => _endTime;

  String? get jobDuration => _jobDuration;

  String? get payType => _payType;

  String? get payRate => _payRate;

  num? get operativeRequired => _operativeRequired;

  num? get licenceTypeRequirements => _licenceTypeRequirements;

  num? get minRatingRequirements => _minRatingRequirements;

  num? get accreditationsRequirements => _accreditationsRequirements;

  String? get isPreferredGuard => _isPreferredGuard;

  String? get genderRequirements => _genderRequirements;

  String? get languageRequirements => _languageRequirements;

  String? get status => _status;

  String? get engagementType => _engagementType;

  num? get providentFund => _providentFund;

  String? get jobDetails => _jobDetails;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['job_title'] = _jobTitle;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['address'] = _address;
    map['job_date'] = _jobDate;
    map['start_time'] = _startTime;
    map['end_time'] = _endTime;
    map['job_duration'] = _jobDuration;
    map['pay_type'] = _payType;
    map['pay_rate'] = _payRate;
    map['operative_required'] = _operativeRequired;
    map['licence_type_requirements'] = _licenceTypeRequirements;
    map['min_rating_requirements'] = _minRatingRequirements;
    map['accreditations_requirements'] = _accreditationsRequirements;
    map['is_preferred_guard'] = _isPreferredGuard;
    map['gender_requirements'] = _genderRequirements;
    map['language_requirements'] = _languageRequirements;
    map['status'] = _status;
    map['engagement_type'] = _engagementType;
    map['provident_fund'] = _providentFund;
    map['job_details'] = _jobDetails;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
