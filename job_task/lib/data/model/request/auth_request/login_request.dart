
class LoginRequest {
  final String email;
  final String password;
  final String country;
  final String city;

  LoginRequest({
    required this.email,
    required this.password,
    required this.country,
    required this.city,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
      "country": country,
      "city": city,
    };
  }

  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    return LoginRequest(
      email: json["email"] ?? "",
      password: json["password"] ?? "",
      country: json["country"] ?? "",
      city: json["city"] ?? "",
    );
  }
}