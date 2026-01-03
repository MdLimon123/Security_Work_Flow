/// success : true
/// message : "data fatched!"
/// data : [{"id":2,"participants":[{"id":1,"first_name":"ABN Secytiry Ltd.","last_name":"","image":"/media/profile/securisive.png"}],"last_message":{"id":15,"text":"Sajid Vai......","sender_name":"Rofiq Rahman m","created_at":"2026-01-03T04:15:04.372856Z"},"last_message_time":"2026-01-03T04:15:04.372856Z","updated_at":"2026-01-03T04:15:04.375722Z"}]
library;

class ChatlistModel {
  ChatlistModel({bool? success, String? message, List<Data>? data}) {
    _success = success;
    _message = message;
    _data = data;
  }

  ChatlistModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _success;
  String? _message;
  List<Data>? _data;
  ChatlistModel copyWith({bool? success, String? message, List<Data>? data}) =>
      ChatlistModel(
        success: success ?? _success,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get success => _success;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 2
/// participants : [{"id":1,"first_name":"ABN Secytiry Ltd.","last_name":"","image":"/media/profile/securisive.png"}]
/// last_message : {"id":15,"text":"Sajid Vai......","sender_name":"Rofiq Rahman m","created_at":"2026-01-03T04:15:04.372856Z"}
/// last_message_time : "2026-01-03T04:15:04.372856Z"
/// updated_at : "2026-01-03T04:15:04.375722Z"

class Data {
  Data({
    num? id,
    List<Participants>? participants,
    LastMessage? lastMessage,
    String? lastMessageTime,
    String? updatedAt,
  }) {
    _id = id;
    _participants = participants;
    _lastMessage = lastMessage;
    _lastMessageTime = lastMessageTime;
    _updatedAt = updatedAt;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    if (json['participants'] != null) {
      _participants = [];
      json['participants'].forEach((v) {
        _participants?.add(Participants.fromJson(v));
      });
    }
    _lastMessage = json['last_message'] != null
        ? LastMessage.fromJson(json['last_message'])
        : null;
    _lastMessageTime = json['last_message_time'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  List<Participants>? _participants;
  LastMessage? _lastMessage;
  String? _lastMessageTime;
  String? _updatedAt;
  Data copyWith({
    num? id,
    List<Participants>? participants,
    LastMessage? lastMessage,
    String? lastMessageTime,
    String? updatedAt,
  }) => Data(
    id: id ?? _id,
    participants: participants ?? _participants,
    lastMessage: lastMessage ?? _lastMessage,
    lastMessageTime: lastMessageTime ?? _lastMessageTime,
    updatedAt: updatedAt ?? _updatedAt,
  );
  num? get id => _id;
  List<Participants>? get participants => _participants;
  LastMessage? get lastMessage => _lastMessage;
  String? get lastMessageTime => _lastMessageTime;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    if (_participants != null) {
      map['participants'] = _participants?.map((v) => v.toJson()).toList();
    }
    if (_lastMessage != null) {
      map['last_message'] = _lastMessage?.toJson();
    }
    map['last_message_time'] = _lastMessageTime;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

/// id : 15
/// text : "Sajid Vai......"
/// sender_name : "Rofiq Rahman m"
/// created_at : "2026-01-03T04:15:04.372856Z"

class LastMessage {
  LastMessage({num? id, String? text, String? senderName, String? createdAt}) {
    _id = id;
    _text = text;
    _senderName = senderName;
    _createdAt = createdAt;
  }

  LastMessage.fromJson(dynamic json) {
    _id = json['id'];
    _text = json['text'];
    _senderName = json['sender_name'];
    _createdAt = json['created_at'];
  }
  num? _id;
  String? _text;
  String? _senderName;
  String? _createdAt;
  LastMessage copyWith({
    num? id,
    String? text,
    String? senderName,
    String? createdAt,
  }) => LastMessage(
    id: id ?? _id,
    text: text ?? _text,
    senderName: senderName ?? _senderName,
    createdAt: createdAt ?? _createdAt,
  );
  num? get id => _id;
  String? get text => _text;
  String? get senderName => _senderName;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['text'] = _text;
    map['sender_name'] = _senderName;
    map['created_at'] = _createdAt;
    return map;
  }
}

/// id : 1
/// first_name : "ABN Secytiry Ltd."
/// last_name : ""
/// image : "/media/profile/securisive.png"

class Participants {
  Participants({num? id, String? firstName, String? lastName, String? image}) {
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _image = image;
  }

  Participants.fromJson(dynamic json) {
    _id = json['id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _image = json['image'];
  }
  num? _id;
  String? _firstName;
  String? _lastName;
  String? _image;
  Participants copyWith({
    num? id,
    String? firstName,
    String? lastName,
    String? image,
  }) => Participants(
    id: id ?? _id,
    firstName: firstName ?? _firstName,
    lastName: lastName ?? _lastName,
    image: image ?? _image,
  );
  num? get id => _id;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['image'] = _image;
    return map;
  }
}
