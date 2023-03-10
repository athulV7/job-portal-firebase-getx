class ChatModel {
  String content;
  String sendTime;
  String fromUID;
  String toUID;

  ChatModel({
    required this.content,
    required this.sendTime,
    required this.fromUID,
    required this.toUID,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        content: json['content'],
        sendTime: json['sendTime'],
        fromUID: json['fromUID'],
        toUID: json['toUID'],
      );

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'sendTime': sendTime,
      'fromUID': fromUID,
      'toUID': toUID,
    };
  }
}
