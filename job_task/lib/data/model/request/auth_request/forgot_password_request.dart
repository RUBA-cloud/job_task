class SendEmailRequest {
  final String email;


  SendEmailRequest({
    required this.email,

  });

  Map<String, dynamic> toJson() {
    return {
      'email': email
    };
  }

  factory SendEmailRequest.fromJson(Map<String, dynamic> json) {
    return SendEmailRequest(
      email: json['email'] as String,

    );
  }
}