
class RegisterRequest {
  final String name;
  final String email;
  final String password;
  final String phone;
  final String country;
  final String city;

  RegisterRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.country,
    required this.city,
    required this.phone
  });

  Map<String, dynamic> toJson() {
    return {
      "name":name,
      "email": email,
      "password": password,
      "country": country,
      "city": city,
      "phone":phone
    };
  }

  factory RegisterRequest.fromJson(Map<String, dynamic> json) {
    return RegisterRequest(
      email: json["email"] ?? "",
      password: json["password"] ?? "",
      country: json["country"] ?? "",
      city: json["city"] ?? "",
      name: json["name"]??"",
      phone: json["phone"]??""
    );
  }
}