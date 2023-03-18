class ChatModel {
  String content;
  String sendTime;
  String fromUID;
  String toUID;
  String deliveryStatus;

  ChatModel({
    required this.content,
    required this.sendTime,
    required this.fromUID,
    required this.toUID,
    required this.deliveryStatus,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        content: json['content'],
        sendTime: json['sendTime'],
        fromUID: json['fromUID'],
        toUID: json['toUID'],
        deliveryStatus: json['deliveryStatus'],
      );

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'sendTime': sendTime,
      'fromUID': fromUID,
      'toUID': toUID,
      'deliveryStatus': deliveryStatus,
    };
  }
}
