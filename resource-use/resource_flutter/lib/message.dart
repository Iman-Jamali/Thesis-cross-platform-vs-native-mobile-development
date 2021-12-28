class Message {
    final String message;

    Message({required this.message});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message,
  };
}