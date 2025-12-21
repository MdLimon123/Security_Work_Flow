/// success : true
/// message : "data fetched!"
/// dashboard_data : {"total_earnings_this_week":0.0,"total_applied_jobs":0,"total_completed_jobs":0,"total_upcoming_jobs":0,"past_jobs":0,"avg_rating":0.0}
library;

class DashBoardInfoModel {
  DashBoardInfoModel({
    bool? success,
    String? message,
    DashboardData? dashboardData,
  }) {
    _success = success;
    _message = message;
    _dashboardData = dashboardData;
  }

  DashBoardInfoModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _dashboardData = json['dashboard_data'] != null
        ? DashboardData.fromJson(json['dashboard_data'])
        : null;
  }

  bool? _success;
  String? _message;
  DashboardData? _dashboardData;

  DashBoardInfoModel copyWith({
    bool? success,
    String? message,
    DashboardData? dashboardData,
  }) => DashBoardInfoModel(
    success: success ?? _success,
    message: message ?? _message,
    dashboardData: dashboardData ?? _dashboardData,
  );

  bool? get success => _success;

  String? get message => _message;

  DashboardData? get dashboardData => _dashboardData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_dashboardData != null) {
      map['dashboard_data'] = _dashboardData?.toJson();
    }
    return map;
  }
}

/// total_earnings_this_week : 0.0
/// total_applied_jobs : 0
/// total_completed_jobs : 0
/// total_upcoming_jobs : 0
/// past_jobs : 0
/// avg_rating : 0.0

class DashboardData {
  DashboardData({
    num? totalEarningsThisWeek,
    num? totalAppliedJobs,
    num? totalCompletedJobs,
    num? totalUpcomingJobs,
    num? pastJobs,
    num? avgRating,
  }) {
    _totalEarningsThisWeek = totalEarningsThisWeek;
    _totalAppliedJobs = totalAppliedJobs;
    _totalCompletedJobs = totalCompletedJobs;
    _totalUpcomingJobs = totalUpcomingJobs;
    _pastJobs = pastJobs;
    _avgRating = avgRating;
  }

  DashboardData.fromJson(dynamic json) {
    _totalEarningsThisWeek = json['total_earnings_this_week'];
    _totalAppliedJobs = json['total_applied_jobs'];
    _totalCompletedJobs = json['total_completed_jobs'];
    _totalUpcomingJobs = json['total_upcoming_jobs'];
    _pastJobs = json['past_jobs'];
    _avgRating = json['avg_rating'];
  }

  num? _totalEarningsThisWeek;
  num? _totalAppliedJobs;
  num? _totalCompletedJobs;
  num? _totalUpcomingJobs;
  num? _pastJobs;
  num? _avgRating;

  DashboardData copyWith({
    num? totalEarningsThisWeek,
    num? totalAppliedJobs,
    num? totalCompletedJobs,
    num? totalUpcomingJobs,
    num? pastJobs,
    num? avgRating,
  }) => DashboardData(
    totalEarningsThisWeek: totalEarningsThisWeek ?? _totalEarningsThisWeek,
    totalAppliedJobs: totalAppliedJobs ?? _totalAppliedJobs,
    totalCompletedJobs: totalCompletedJobs ?? _totalCompletedJobs,
    totalUpcomingJobs: totalUpcomingJobs ?? _totalUpcomingJobs,
    pastJobs: pastJobs ?? _pastJobs,
    avgRating: avgRating ?? _avgRating,
  );

  num? get totalEarningsThisWeek => _totalEarningsThisWeek;

  num? get totalAppliedJobs => _totalAppliedJobs;

  num? get totalCompletedJobs => _totalCompletedJobs;

  num? get totalUpcomingJobs => _totalUpcomingJobs;

  num? get pastJobs => _pastJobs;

  num? get avgRating => _avgRating;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total_earnings_this_week'] = _totalEarningsThisWeek;
    map['total_applied_jobs'] = _totalAppliedJobs;
    map['total_completed_jobs'] = _totalCompletedJobs;
    map['total_upcoming_jobs'] = _totalUpcomingJobs;
    map['past_jobs'] = _pastJobs;
    map['avg_rating'] = _avgRating;
    return map;
  }
}
