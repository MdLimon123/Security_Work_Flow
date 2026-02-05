/// data : [{"id":2,"participants":[{"id":1,"first_name":"ABN Secytiry Ltd.","last_name":"","image":"/media/profile/securisive.png"}],"last_message":{"id":15,"text":"Sajid Vai......","sender_name":"Rofiq Rahman m","created_at":"2026-01-03T04:15:04.372856Z"},"last_message_time":"2026-01-03T04:15:04.372856Z","updated_at":"2026-01-03T04:15:04.375722Z"}]
library;

class ChatlistModel {
  bool? success;
  String? message;
  List<ChatData>? data;

  ChatlistModel({this.success, this.message, this.data});

  ChatlistModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = (json['data'] as List).map((e) => ChatData.fromJson(e)).toList();
    }
  }
}

class ChatData {
  num? id;
  List<Participants>? participants;
  LastMessage? lastMessage;
  DateTime? lastMessageTime;
  DateTime? updatedAt;
  int unreadCount;

  ChatData({
    this.id,
    this.participants,
    this.lastMessage,
    this.lastMessageTime,
    this.updatedAt,
    this.unreadCount = 0,
  });

  ChatData.fromJson(dynamic json) : unreadCount = json['unread_count'] ?? 0 {
    id = json['id'];

    if (json['participants'] != null) {
      participants = (json['participants'] as List)
          .map((e) => Participants.fromJson(e))
          .toList();
    }

    lastMessage = json['last_message'] != null
        ? LastMessage.fromJson(json['last_message'])
        : null;

    lastMessageTime = json['last_message_time'] != null
        ? DateTime.parse(json['last_message_time']).toLocal()
        : null;

    updatedAt = json['updated_at'] != null
        ? DateTime.parse(json['updated_at']).toLocal()
        : null;
  }
}

class LastMessage {
  num? id;
  String? text;
  String? senderName;
  DateTime? createdAt;
  bool isReaded;

  LastMessage({
    this.id,
    this.text,
    this.senderName,
    this.createdAt,
    this.isReaded = false,
  });

  LastMessage.fromJson(dynamic json) : isReaded = json['is_readed'] ?? false {
    id = json['id'];
    text = json['text'];
    senderName = json['sender_name'];
    createdAt = json['created_at'] != null
        ? DateTime.parse(json['created_at']).toLocal()
        : null;
  }
}

class Participants {
  num? id;
  String? firstName;
  String? lastName;
  String? image;

  Participants({this.id, this.firstName, this.lastName, this.image});

  Participants.fromJson(dynamic json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    image = json['image'];
  }
}
